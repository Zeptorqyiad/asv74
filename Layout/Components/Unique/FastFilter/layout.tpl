<?php
/** @var array $data */
/** @var \App\Extensions\Site\Model\Category $c */
$c = $data['c'];

$tabs = array_map(fn(\App\Extensions\Catalog\Model\Brand $b) => [
    'text' => $b->name,
    'value' => $b->brand_id
], \App\Extensions\Catalog\Model\Brand::findForCategory($c->category_id));

$shouldShowFilters = false;
foreach ($_REQUEST as $k => $v) {
    if (str_starts_with(
            $k,
            'param_'
        ) || $k == 'price_min' || $k == 'price_max' || $k == 'brand' || $k == 'new' || $k == 'stock' || $k == 'discount' || $k == 'popular') {
        if ($v) {
            if (($k == 'price_min' || $k == 'price_max') && !$_REQUEST['price_min'] && !$_REQUEST['price_max']) {
                continue;
            }

            $shouldShowFilters = true;
            break;
        }
    }
}

$tags = [];
if ($shouldShowFilters) {
    $priceText = '';
    if ($_REQUEST['price_min'] ?? 0) {
        $priceText .= 'От ' . $_REQUEST['price_min'] . ' ₽ ';
    }

    if ($_REQUEST['price_max'] ?? 0) {
        $fl = 'Д';
        if ($priceText) {
            $fl = 'д';
        }

        $priceText .= $fl . 'о ' . $_REQUEST['price_max'] . ' ₽';
    }

    if ($priceText) {
        $tags[] = ['text' => $priceText, 'value' => 'price'];
    }

    if ($_REQUEST['popular'] ?? false) {
        $tags[] = ['text' => 'Под заказ', 'value' => 'popular'];
    }

    if ($_REQUEST['new'] ?? false) {
        $tags[] = ['text' => 'Новинки', 'value' => 'new'];
    }

    if ($_REQUEST['discount'] ?? false) {
        $tags[] = ['text' => 'Акции', 'value' => 'discount'];
    }

    if ($_REQUEST['stock'] ?? false) {
        $tags[] = ['text' => 'В наличии', 'value' => 'stock'];
    }

    foreach ($_REQUEST as $k => $v) {
        if (!str_starts_with($k, 'param_')) {
            continue;
        }

        $wasArray = true;
        if (!is_array($v)) {
            $v = [$v];
            $wasArray = false;
        }

        foreach ($v as $vv) {
            $param = \App\Extensions\Catalog\Model\Param::findOne([
                'param_id' => (int)substr(
                    $k,
                    strlen('param_')
                )
            ]);

            $tags[] = ['text' => $wasArray ? ($param->name . ': ' . $vv) : $param->name, 'value' => urlencode($k . '[]') . '=' . urlencode($vv)];
        }
    }

    foreach ($_REQUEST as $k => $v) {
        if (!str_starts_with($k, 'cparam_')) {
            continue;
        }

        $wasArray = true;
        if (!is_array($v)) {
            $v = [$v];
            $wasArray = false;
        }

        foreach ($v as $vv) {
            $param = \App\Extensions\Site\Model\Chassis\Param::findOne([
                'chassis_param_id' => (int)substr(
                    $k,
                    strlen('cparam_')
                )
            ]);

            $tags[] = ['text' => $wasArray ? ($param->name . ': ' . $vv) : $param->name, 'value' => urlencode($k . '[]') . '=' . urlencode($vv)];
        }
    }

    foreach ($_REQUEST as $k => $v) {
        if (!str_starts_with($k, 'aparam_')) {
            continue;
        }

        $wasArray = true;
        if (!is_array($v)) {
            $v = [$v];
            $wasArray = false;
        }

        foreach ($v as $vv) {
            $param = \App\Extensions\Site\Model\Addon\Param::findOne([
                'addon_param_id' => (int)substr(
                    $k,
                    strlen('aparam_')
                )
            ]);

            $tags[] = ['text' => $wasArray ? ($param->name . ': ' . $vv) : $param->name, 'value' => urlencode($k . '[]') . '=' . urlencode($vv)];
        }
    }
}
?>

<section class="fast-filter <?= $data['className'] ?>">
    <div class="fast-filter__container container">

        <div class="fast-filter__controls">
            <?php
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'fast-filter__button-modal',
                text: 'Все фильтры',
                icon: 'filter',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                attributes: [
                    'onclick' => 'modalManager.open("filter-modal");',
                ]
            );

            $sortTabs = [
                'popular' => 'Под заказ', 'pmin' => 'Дешевле', 'pmax' => 'Дороже',
                'discount' => 'Размер скидки', '' => 'Сортировка'
            ];

            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'fast-filter__button-modal',
                text: in_array($_REQUEST['sort'] ?? '', ['', 'default']) ? 'Сортировка' : $sortTabs[$_REQUEST['sort'] ?? ''],
                icon: 'sort',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                attributes: [
                    'onclick' => 'modalManager.open("sort-modal");',
                ]
            );
            ?>
        </div>

        <?php if ($tabs): ?>
            <div class="fast-filter__tabs">
                <?php
                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: !$_REQUEST['brand']
                        ? 'fast-filter__tab-all active'
                        : 'fast-filter__tab-all',
                    text: 'Все марки',
                    link: './',
                    icon: 'unique-tag',
                    size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                    attributes: [
                        'data-value' => 'all'
                    ]
                );

                foreach ($tabs as $tab) {
                    App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                        className: ($_REQUEST['brand'] ?? 0) && in_array($tab['value'], $_REQUEST['brand'])
                            ? 'fast-filter__tab active'
                            : 'fast-filter__tab',
                        text: $tab['text'],
                        link: './?brand[]=' . $tab['value'],
                        size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                        attributes: [
                            'data-value' => $tab['value']
                        ]
                    );
                }
                ?>
            </div>
        <?php endif; ?>

        <?php if ($tags): ?>
            <div class="fast-filter__tags">
                <?php
                foreach ($tags as $tag) {
                    App\Layout\Components\UI\Core\Tag\Layout::drawTag(
                        className: 'fast-filter__tag active',
                        text: $tag['text'],
                        style: \App\Layout\Components\UI\Core\Tag\TagStyle::Gray,
                        attributes: [
                            'data-tag' => 'param',
                            'data-text' => $tag['value']
                        ]
                    );
                }

                App\Layout\Components\UI\Core\Tag\Layout::drawTag(
                    className: 'fast-filter__tag-reset active',
                    text: 'Очистить всё',
                    style: \App\Layout\Components\UI\Core\Tag\TagStyle::Secondary,
                    attributes: [
                        'data-tag' => 'all'
                    ]
                );
                ?>
            </div>
        <?php endif; ?>
    </div>
</section>

