<?php
/** @var \App\Extensions\Site\Model\Category $cat */
$cat = $data['c'];


$filters = [];
if ($cat->category_id) {
    $filters = \Simflex\Core\DB::result(
        'select filters from catalog_category_cache where category_id = ?',
        0,
        [$cat->category_id]
    );
    $filters = explode(',', (string)$filters);
} else {
    $qs = $data['th']->makeQFilter();
    $qf = $data['th']->makeWFilter(true);
    $qr = '';
    if ($qs[0]) {
        $qr .= $qs[0];
    }
    if ($qf[0]) {
        if ($qr) {
            $qr .= ' and ';
        }
        $qr .= $qf[0];
    }

    if ($qr) {
        $qr = str_replace('t.', 'p.', $qr);
        $qr = ' and ' . $qr;
    }

    $filters = \Simflex\Core\Cache::getOrSet(
        'c.fq.' . md5($qr),
        fn() => \App\Extensions\Catalog\CategoryAssist::getGlobalFilters($qr, array_merge($qs[1] ?? [], $qf[1] ?? [])),
        86400
    );
}
?>

<div id="filter-modal" class="modal filter-modal" role="dialog" aria-modal="true">
    <form class="filter-modal__container">
        <div class="filter-modal__top">
            <span class="filter-modal__title">Фильтры</span>
            <button class="filter__button-reset" type="reset">сбросить</button>
            <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
                className: 'filter-modal__button-close',
                attributes: [ 'onclick' => 'modalManager.close("filter-modal")' ]
            ); ?>
        </div>

        <div class="filter-modal__body" data-simplebar>
            <div class="filter-modal__body-wrap">
                <?php

                $parent = $cat->getParent();
                if (!$parent && $cat->category_id) {
                    $text = 'Каталог';
                    $link = '/catalog/';
                } else {
                    $text = $parent->name;
                    $link = '/' . $parent->path . '/';
                }

                if (isset($text)) {
                    App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                        className: 'filter-modal__back',
                        icon: 'arrow-left',
                        text: $text,
                        link: $link,
                        style: App\Layout\Components\UI\Core\Tab\TabStyle::Flat,
                        size: App\Layout\Components\UI\Core\Tab\TabSize::ExtraSmall,
                    );
                }

                if ($children = array_map(fn($c) => ['text' => $c->name, 'link' => '/' . $c->path . '/'], $cat->getChildren())) {
                    App\Layout\Components\UI\Other\Filter\Layout::drawFilter(
                        groupName: 'categories',
                        type: App\Layout\Components\UI\Other\Filter\FilterType::Category,
                        data: [
                            'title' => $cat->name,
                            'categories' => $children,
                        ]
                    );
                }

                $items = [];
                if (in_array('is_new', $filters)) {
                    $items[] = [
                        'text' => 'Новинки',
                        'attributes' => [
                                'name' => 'new',
                                'value' => 1
                            ] + (($_REQUEST['new'] ?? 0) ? ['checked' => 'checked'] : [])
                    ];
                }

                if (in_array('is_popular', $filters)) {
                    $items[] = [
                        'text' => 'Под заказ',
                        'tooltip' => 'Изготовление под заказ',
                        'attributes' => [
                                'name' => 'popular',
                                'value' => 1
                            ] + (($_REQUEST['popular'] ?? 0) ? ['checked' => 'checked'] : [])
                    ];
                }

                if (in_array('is_sale', $filters)) {
                    $items[] = [
                        'text' => 'Акции',
                        'attributes' => [
                                'name' => 'discount',
                                'value' => 1
                            ] + (($_REQUEST['discount'] ?? 0) ? ['checked' => 'checked'] : [])
                    ];
                }

                if (in_array('stock', $filters)) {
                    $items[] = [
                        'text' => 'В наличии',
                        'tooltip' => 'Доступно без ожидания',
                        'attributes' => [
                                'name' => 'stock',
                                'value' => 1
                            ] + (($_REQUEST['stock'] ?? 0) ? ['checked' => 'checked'] : [])
                    ];
                }

                if ($items) {
                    App\Layout\Components\UI\Other\Filter\Layout::drawFilter(
                        groupName: 'switches',
                        data: [
                            'switches' => $items
                        ]
                    );
                }

                App\Layout\Components\UI\Other\Filter\Layout::drawFilter(
                    title: 'Цена',
                    groupName: 'price',
                    type: \App\Layout\Components\UI\Other\Filter\FilterType::Range,
                    data: [
                        'min' => $data['minp'],
                        'max' => $data['maxp'],
                        'nameMin' => 'price_min',
                        'nameMax' => 'price_max',
                        'minNow' => $_REQUEST['price_min'] ?? $data['minp'] ?? 0,
                        'maxNow' => $_REQUEST['price_max'] ?? $data['maxp'] ?? 100,
                    ]
                );

                if ($brands = \App\Extensions\Catalog\Model\Brand::findForCategory($cat->category_id)) {
                    $items = [];
                    foreach ($brands as $brand) {
                        $items[] = [
                            'text' => $brand->name,
                            'name' => 'brand[]',
                            'value' => $brand->brand_id,
                            'checked' => in_array(
                                $brand->brand_id,
                                $_REQUEST['brand'] ?? []
                            ),
                        ];
                    }

                    App\Layout\Components\UI\Other\Filter\Layout::drawFilter(
                        title: 'Марка',
                        groupName: 'brand',
                        type: App\Layout\Components\UI\Other\Filter\FilterType::FieldSelect,
                        data: [
                            'radio' => $items
                        ]
                    );
                }

                $pars = \App\Extensions\Catalog\Model\Param::getAllForCategory($cat->category_id);
                $seen = [];
                for ($i = 0, $iMax = count($pars); $i < $iMax; ++$i) {
                    $p = $pars[$i];
                    if (in_array($p->param_id, $seen)) {
                        continue;
                    }

                    $seen[] = $p->param_id;
                    $v = $cat->category_id ? \Simflex\Core\Cache::getOrSet(implode('.', ['filtera.params', $cat->category_id, $p->param_id]), function () use ($p, $cat) {
                        $v = $p->getValues(array_merge([$cat->category_id], $cat->getAllChildren()));

                        $nv = [];
                        foreach ($v as $k => $vv) {
                            // test this shit (iq = 0)
                            $ret = \Simflex\Core\DB::result("
select count(*) from catalog_product p 
    join catalog_p2c pc on pc.product_id = p.product_id 
    join catalog_param_value pv on pv.product_id = p.product_id and pv.param_id = ?
where pv.value = ? and pc.category_id in (?)", 0, [$p->param_id, $vv['value'], implode(',', array_merge([$cat->category_id], $cat->getAllChildren()))]);

                            if ($ret <= 0) {
                                \Simflex\Core\Log::debug('removed {v}', ['v' => $vv['value']]);
                            } else {
                                $nv[$k] = $vv;
                            }
                        }

                        return array_filter($nv);
                    }, 86400) : $p->getValues(array_merge([$cat->category_id], $cat->getAllChildren()));

                    if (!$v) {
                        continue;
                    }

                    if (!$p->is_bool) {
                        $items = [];
                        foreach ($v as $vv) {
                            $items[] = [
                                'text' => $vv['value'],
                                'name' => 'param_' . $p->param_id . '[]',
                                'value' => $vv['value'],
                                'checked' => in_array(
                                    $vv['value'],
                                    $_REQUEST['param_' . $p->param_id] ?? []
                                ),
                            ];
                        }

                        if (count($items) < 2) {
                            continue;
                        }

                        App\Layout\Components\UI\Other\Filter\Layout::drawFilter(
                            title: $p->name,
                            groupName: $p->param_id,
                            type: App\Layout\Components\UI\Other\Filter\FilterType::FieldSelect,
                            data: [
                                'checkbox' => $items
                            ]
                        );
                    } else {
                        App\Layout\Components\UI\Other\Filter\Layout::drawFilter(
                            groupName: 'test',
                            data: [
                                'switches' => [[
                                    'text' => $p->name,
                                    'attributes' => [
                                            'name' => 'param_' . $p->param_id,
                                            'value' => 1
                                        ] + (($_REQUEST['param_' . $p->param_id] ?? 0) ? ['checked' => 'checked'] : [])
                                ]]
                            ]
                        );
                    }
                }

                $cPars = \App\Extensions\Site\Model\Chassis\Param::find(['in_filters' => 1]);
                foreach ($cPars as $p) {
                    $v = $cat->category_id ? \Simflex\Core\Cache::getOrSet(implode('.', ['filtera.cparams', $cat->category_id, $p->chassis_param_id]), function () use ($p, $cat) {
                        $v = $p->getValues();

                        $nv = [];
                        foreach ($v as $k => $vv) {
                            // test this shit (iq = 0)
                            $ret = \Simflex\Core\DB::result("
select count(*) from catalog_product p 
    join catalog_p2c pc on pc.product_id = p.product_id 
    join catalog_chassis_param_value pv on pv.chassis_id = p.chassis_id and pv.chassis_param_id = ?
where pv.value = ? and pc.category_id in (?)", 0, [$p->chassis_param_id, $vv['value'], implode(',', array_merge([$cat->category_id], $cat->getAllChildren()))]);

                            if ($ret <= 0) {
                                \Simflex\Core\Log::debug('removed chassis param {v}', ['v' => $vv['value']]);
                            } else {
                                $nv[$k] = $vv;
                            }
                        }

                        return array_filter($nv);
                    }, 86400) : $p->getValues();

                    if (!$v) {
                        continue;
                    }

                    $items = [];
                    foreach ($v as $vv) {
                        $items[] = [
                            'text' => $vv['value'],
                            'name' => 'cparam_' . $p->chassis_param_id . '[]',
                            'value' => $vv['value'],
                            'checked' => in_array(
                                $vv['value'],
                                $_REQUEST['cparam_' . $p->chassis_param_id] ?? []
                            ),
                        ];
                    }

                    if (count($items) < 2) {
                        continue;
                    }

                    App\Layout\Components\UI\Other\Filter\Layout::drawFilter(
                        title: $p->name,
                        groupName: $p->chassis_param_id,
                        type: App\Layout\Components\UI\Other\Filter\FilterType::FieldSelect,
                        data: [
                            'checkbox' => $items
                        ]
                    );
                }

                $aPars = \App\Extensions\Site\Model\Addon\Param::find(['in_filters' => 1]);
                foreach ($aPars as $p) {
                    $v = $cat->category_id ? \Simflex\Core\Cache::getOrSet(implode('.', ['filtera.aparams', $cat->category_id, $p->addon_param_id]), function () use ($p, $cat) {
                        $v = $p->getValues();

                        $nv = [];
                        foreach ($v as $k => $vv) {
                            // test this shit (iq = 0)
                            $ret = \Simflex\Core\DB::result("
select count(*) from catalog_product p 
    join catalog_p2c pc on pc.product_id = p.product_id 
    join catalog_addon_param_value pv on pv.addon_id = p.addon_id and pv.addon_param_id = ?
where pv.value = ? and pc.category_id in (?)", 0, [$p->addon_param_id, $vv['value'], implode(',', array_merge([$cat->category_id], $cat->getAllChildren()))]);

                            $ret += \Simflex\Core\DB::result("
select count(*) from catalog_addon p 
    join catalog_a2c pc on pc.addon_id = p.addon_id 
    join catalog_addon_param_value pv on pv.addon_id = p.addon_id and pv.addon_param_id = ?
where pv.value = ? and pc.category_id in (?)", 0, [$p->addon_param_id, $vv['value'], implode(',', array_merge([$cat->category_id], $cat->getAllChildren()))]);

                            if ($ret <= 0) {
                                \Simflex\Core\Log::debug('removed addon param {v}', ['v' => $vv['value']]);
                                continue;
                            } else {
                                $nv[$k] = $vv;
                            }
                        }

                        return array_filter($nv);
                    }, 86400) : $p->getValues();
                    if (!$v) {
                        continue;
                    }

                    $items = [];
                    foreach ($v as $vv) {
                        $items[] = [
                            'text' => $vv['value'],
                            'name' => 'aparam_' . $p->addon_param_id . '[]',
                            'value' => $vv['value'],
                            'checked' => in_array(
                                $vv['value'],
                                $_REQUEST['aparam_' . $p->addon_param_id] ?? []
                            ),
                        ];
                    }

                    if (count($items) < 2) {
                        continue;
                    }

                    App\Layout\Components\UI\Other\Filter\Layout::drawFilter(
                        title: $p->name,
                        groupName: $p->addon_param_id,
                        type: App\Layout\Components\UI\Other\Filter\FilterType::FieldSelect,
                        data: [
                            'checkbox' => $items
                        ]
                    );
                }
                ?>
            </div>
        </div>

        <div class="filter-modal__actions">
            <div class="filter-modal__actions-buttons">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'filter-modal__button-reset w-full',
                    text: 'Сбросить',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    attributes: [
                        'type' => 'reset',
                    ]
                );

                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'filter-modal__button-submit w-full',
                    text: 'Применить',
                    loader: true,
                    attributes: [
                        'type' => 'submit',
                    ]
                );
                ?>
            </div>
            <span class="filter-modal__count js--filter-available-count">Товаров подходит: <?= $data['cnt'] ?></span>
        </div>
    </form>
</div>