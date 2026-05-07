<?php
/** @var array $data */
?>

<section class="new-models-slider container <?= $data['className'] ?>">

    <h2 class="section-title new-models-slider__title"><?= $data['title'] ?? 'Новые модели' ?></h2>

    <div class="new-models-slider__buttons">
        <?php if ($data['link']) {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'new-models-slider__button-link',
                text: 'Показать все',
                link: $data['link'],
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
            );
        }
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'new-models-slider__button-prev',
            icon: 'arrow-left',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        );
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'new-models-slider__button-next',
            icon: 'arrow-right',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        ); ?>
    </div>

    <div class="new-models-slider__slider-wrap">
        <div class="new-models-slider__slider">
            <div class="swiper-wrapper">
                <?php foreach ($data['slides'] as $slide) {
                    App\Layout\Components\Cards\NewModelBanner\Layout::drawNewModelBanner(
                        className: 'swiper-slide',
                        link: $slide->link ?? '',
                        background: $slide->background ? '/uf/images/source/' . $slide->background : '',
                        image: $slide->image ? '/uf/images/source/' . $slide->image : '',
                        title: $slide->title ?? '',
                        desc: $slide->desc ?? '',
                        toOrder: $slide->to_order ?? false,
                        isNew: $slide->is_new ?? false,
                        inStock: $slide->in_stock ?? false,
                        isSale: $slide->is_sale ?? false,
                        fabric: $slide->fabric ?? '',
                        badges: $slide->getBadges() ?? [],
                    );
                } ?>
            </div>
        </div>

        <div class="new-models-slider__pagination"></div>
    </div>
</section>