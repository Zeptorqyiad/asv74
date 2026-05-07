<?php
/** @var array $data */
?>

<section class="partners-slider <?= $data['className'] ?>">

    <div class="partners-slider__slider-background"></div>

    <div class="partners-slider__container">

        <h2 class="section-title partners-slider__title"><?= $data['title'] ?? 'Нам доверяют ' ?></h2>

        <div class="partners-slider__buttons">
            <?php if ($data['link']) {
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'partners-slider__button-link',
                    text: 'История поставок',
                    link: $data['link'],
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                );
            }
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'partners-slider__button-prev',
                icon: 'arrow-left',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            );
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'partners-slider__button-next',
                icon: 'arrow-right',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            ); ?>
        </div>

        <div class="partners-slider__slider-wrap">
            <div class="partners-slider__slider">
                <div class="swiper-wrapper">
                    <?php foreach ($data['slides'] as $slide) {
                        App\Layout\Components\Cards\PartnerCard\Layout::drawPartnerCard(
                            className: 'swiper-slide',
                            image: $slide['image'] ?? '',
                            title: $slide['title'] ?? '',
                            desc: $slide['desc'] ?? '',
                        );
                    } ?>
                </div>
            </div>
        </div>
    </div>

</section>