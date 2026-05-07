<?php
/** @var array $data */
?>

<section class="offers-slider <?= $data['className'] ?>">

    <h2 class="section-title offers-slider__title"><?= $data['title'] ?? 'Акции и специальные предложения' ?></h2>

    <div class="offers-slider__buttons">
        <?php if ($data['link']) {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'offers-slider__button-link',
                text: 'История поставок',
                link: $data['link'],
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
            );
        }
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'offers-slider__button-prev',
            icon: 'arrow-left',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        );
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'offers-slider__button-next',
            icon: 'arrow-right',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        ); ?>
    </div>

    <div class="offers-slider__slider-wrap">
        <div class="offers-slider__slider">
            <div class="swiper-wrapper">
                <?php foreach ($data['slides'] as $slide) {
                    App\Layout\Components\Cards\OfferCard\Layout::drawOfferCard(
                        className: 'swiper-slide',
                        link: $slide['link'] ?? '',
                        image: $slide['image'] ?? '',
                        title: $slide['title'] ?? '',
                        darkText: $slide['darkText'] ?? '',
                    );
                } ?>
            </div>
        </div>
    </div>
</section>