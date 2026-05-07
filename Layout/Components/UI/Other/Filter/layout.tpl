<?php
/** @var array $data */

$filterClasses = [
    'filter',
    "filter-type_{$data['type']}",
    $data['className'] ?? ''
];

$arr = [];
$arrType = '';

if(isset($data['data']['checkbox'])):
    $arr = $data['data']['checkbox'];
    $arrType = 'checkbox';
endif;

if(isset($data['data']['radio'])):
    $arr = $data['data']['radio'];
    $arrType = 'radio';
endif;
?>

<?php if ($data['type'] === 'category'): ?>
    <div class="<?= implode(' ', $filterClasses) ?>" <?= buildAttrs($data['attributes'] ?? []) ?>
         data-filter-group="<?= $data['groupName'] ?>">
        <h3 class="filter__title"><?= $data['data']['title'] ?></h3>
        <?php if (isset($data['data']['imgCategories'])): ?>
            <div class="filter__subcategories-wrap">
                <div class="filter__subcategories">
                    <?php foreach ($data['data']['imgCategories'] as $i): {
                        App\Layout\Components\UI\Core\TabImage\Layout::drawTabImage(
                            className: 'js--item-more',
                            text: $i['text'],
                            link: $i['link'],
                            image: $i['image'] ? '/uf/images/source/'.$i['image'] : '',
                            style: $i['style'] ?? App\Layout\Components\UI\Core\TabImage\TabImageStyle::Secondary,
                            size: $i['size'] ?? App\Layout\Components\UI\Core\TabImage\TabImageSize::Small,
                        );
                    } ?>
                    <?php endforeach; ?>
                </div>
                <button class="filter__button-more" type="button">Показать все</button>
            </div>
        <?php endif; ?>
        <?php if (isset($data['data']['categories'])): ?>
            <div class="filter__content">
                <div class="filter__subcategories">
                    <?php
                    foreach ($data['data']['categories'] as $c):
                        App\Layout\Components\UI\Core\TabImage\Layout::drawTabImage(
                            className: 'tab-cat js--item-more',
                            text: $c['text'],
                            link: $c['link'],
                            image: $c['image'] ? '/uf/images/source/'.$c['image'] : '',
                            style: $c['style'] ?? App\Layout\Components\UI\Core\TabImage\TabImageStyle::Secondary,
                            size: $c['size'] ?? App\Layout\Components\UI\Core\TabImage\TabImageSize::Small,
                        );
                    endforeach;
                    ?>
                </div>
                <button class="filter__button-more" type="button">Показать все</button>
            </div>
        <?php endif; ?>
    </div>

<?php elseif ($data['type'] === 'field-select'): ?>
    <div class="<?= implode(' ', $filterClasses) ?> " <?= buildAttrs($data['attributes'] ?? []) ?>
         data-filter-group="<?= $data['groupName'] ?>">
        <div class="filter__top">
            <span class="filter__title"><?= $data['title'] ?></span>
            <button class="filter__button-reset" type="button" data-reset-group="<?= $data['groupName'] ?>">
                сбросить
            </button>
            <?= renderIcon('chevron-up-sm', ' filter__button-hide') ?>
        </div>

        <div class="filter__top_mobile">
            <span class="filter__title"><?= $data['title'] ?></span>
            <?php if(!empty($arr) && count($arr) > 5):
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'filter__button-all js--show-subfilter',
                    text: 'Все',
                    icon: 'chevron-right',
                    iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::ExtraSmall,
                );
            endif; ?>
        </div>

        <div class="filter__content collapsed">
            <div class="filter__tags js--filter-tags">
                <?php if(!empty($arr)):
                    $arrCur = $arr;
                    $arrChecked = array_filter($arr, function ($arrItem) {
                        return $arrItem['checked'] === true;
                    });

                    if (count($arrChecked) == 0) {
                        $arrCur = array_slice($arrCur, 0, 5);
                    } elseif (count($arrChecked) > 5) {
                        $arrCur = $arrChecked;
                    } else {
                        usort($arrCur, fn ($a, $b) => (int)$b['checked'] <=> (int)$a['checked']);
                        $arrCur = array_slice($arrCur, 0, 5);
                    }

                    foreach ($arrCur as $item):
                        App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                            className: $item['checked']
                                ? 'filter__tags-item js--filter__tags-item active'
                                : 'filter__tags-item js--filter__tags-item',
                            text: $item['text'],
                            icon: 'close',
                            iconPos: \App\Layout\Components\UI\Core\Tab\TabIconPos::Right,
                            style: \App\Layout\Components\UI\Core\Tab\TabStyle::Primary,
                            size: \App\Layout\Components\UI\Core\Tab\TabSize::ExtraSmall,
                            attributes: [
                                'data-name' => $item['name'],
                                'data-value' => $item['value'],
                                'data-type' => $arrType
                            ]
                        );
                    endforeach;
                endif; ?>
            </div>

            <?php if(!empty($arr)):
                App\Layout\Components\Modals\SubfilterModal\Layout::draw([
                    'title' => $data['title'],
                    'items' => $arr,
                    'group' => $data['groupName'],
                    'type' => $arrType
                ]);
            endif; ?>
        </div>
    </div>

<?php elseif ($data['type'] === 'switch'): ?>
    <fieldset class="<?= implode(' ', $filterClasses) ?> " <?= buildAttrs($data['attributes'] ?? []) ?>
              data-filter-group="<?= $data['groupName'] ?>">
        <?php foreach ($data['data']['switches'] as $s): ?>
            <?php App\Layout\Components\UI\Core\ToggleSwitch\Layout::drawToggle(
                text: $s['text'],
                size: $s['size'] ?? App\Layout\Components\UI\Core\ToggleSwitch\ToggleSize::Small,
                position: $s['position'] ?? App\Layout\Components\UI\Core\ToggleSwitch\TogglePosition::Right,
                attributes: $s['attributes'] ?? [],
                tooltip: $s['tooltip'] ?? ''
            ); ?>
        <?php endforeach; ?>
    </fieldset>

<?php elseif ($data['type'] === 'range'): ?>
    <div class="<?= implode(' ', $filterClasses) ?> " <?= buildAttrs($data['attributes'] ?? []) ?>
         data-filter-group="<?= $data['groupName'] ?>">
        <div class="filter__top">
            <span class="filter__title"><?= $data['title'] ?></span>
            <button class="filter__button-reset" type="button" data-reset-group="<?= $data['groupName'] ?>">
                сбросить
            </button>
            <?= renderIcon('chevron-up-sm', ' filter__button-hide') ?>
        </div>
        <?php
        App\Layout\Components\UI\Core\DualRangeSlider\Layout::drawRangeSlider(
            className: 'filter filter__content',
            min: $data['data']['min'],
            max: $data['data']['max'],
            minNow: $data['data']['minNow'],
            maxNow: $data['data']['maxNow'],
            nameMin: $data['data']['nameMin'],
            nameMax: $data['data']['nameMax'],
        ); ?>
    </div>

<?php elseif ($data['type'] === 'tag-list'): ?>
    <div class="<?= implode(' ', $filterClasses) ?> " <?= buildAttrs($data['attributes'] ?? []) ?>
         data-filter-group="<?= $data['groupName'] ?>">
        <div class="filter__top">
            <h5 class="filter__title"><?= $data['title'] ?></h5>
            <?php
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'filter__tags-more',
                text: 'Все',
                icon: 'chevron-right-sm',
                style: $data['data']['style'] ?? App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                size: $data['data']['size'] ?? App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::ExtraSmall,
                iconPos: App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right
            ); ?>
        </div>
        <fieldset>
            <?php foreach ($data['data']['tags'] as $t): ?>
                <?php
                App\Layout\Components\UI\Core\Chip\Layout::drawChip(
                    text: $t['text'],
                    attributes: [
                        'name' => $t['name'],
                        'id' => $t['id'],
                        'value' => $t['value'],
                    ] + ($t['checked'] ? ['checked' => 'checked'] : []));
                ?>
            <?php endforeach; ?>
        </fieldset>
    </div>
<?php endif; ?>
