<?php
/** @var array $data */

?>

<div class="comparison-sheet">
    <div class="comparison-sheet__container container">
        <div class="comparison-sheet__tab-list">
            <?php
            foreach ($data['cats'] as $cat) {
                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'comparison__tab ' . ($data['cur'] == $cat->category_id ? 'active' : ''),
                    text: $cat->name,
                    link: '/compare/?c=' . $cat->category_id,
                    badge: count($data['prodToCat'][$cat->category_id] ?? []),
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Underline,
                );
            }
            ?>
        </div>

        <div class="comparison-sheet__actions">
            <div class="comparison-sheet__controls">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'comparison-sheet__button-add',
                    text: 'Добавить товары',
                    icon: 'menu-3-line-mod',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                    iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                    attributes: [
                        'onclick' => 'modalManager.open("comparison-modal");'
                    ]
                );

                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'comparison-sheet__button-clear',
                    text: 'Очистить сравнение',
                    icon: 'trash',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                    iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                    attributes: [
                        'onclick' => 'toastManager.queue({ message: "Сравнение очищено"}); window.location.reload();'
                    ]
                );
                ?>
            </div>

            <div class="comparison-sheet__buttons-navigation">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'comparison-sheet__button-prev',
                    icon: 'arrow-left',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small
                );
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'comparison-sheet__button-next',
                    icon: 'arrow-right',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small
                );
                ?>
            </div>
        </div>

        <div class="comparison-sheet__products-slider">
            <div class="swiper-wrapper">
                <?php foreach ($data['slides'] as $slide) {
                    App\Layout\Components\Cards\ComparisonCard\Layout::drawComparisonCard(
                        productId: $slide['id'] ?? 0,
                        variantId: $slide['variantId'] ?? 0,
                        className: 'comparison-card--no-image swiper-slide',
                        link: $slide['link'] ?? '',
                        title: $slide['title'] ?? '',
                        price: $slide['price'] ?? '',
                        oldPrice: $slide['oldPrice'] ?? '',
                        toOrder: $slide['toOrder'] ?? false,
                        images: $slide['images'] ?? [],
                    );
                }
                ?>
            </div>
        </div>
    </div>
</div>