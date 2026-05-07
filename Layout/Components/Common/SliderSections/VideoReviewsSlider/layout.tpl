<?php
/** @var array $data */
?>

<section class="video-reviews-slider <?= $data['className'] ?>">

    <h2 class="video-reviews-slider__title"><?= $data['title'] ?? 'Видео-обзоры нашей техники' ?></h2>

    <div class="video-reviews-slider__buttons">
        <?php if ($data['link']) {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'video-reviews-slider__button-link',
                text: 'Показать все',
                link: $data['link'],
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
            );
        }
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'video-reviews-slider__button-prev',
            icon: 'arrow-left',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        );
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'video-reviews-slider__button-next',
            icon: 'arrow-right',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        ); ?>
    </div>

    <div class="video-reviews-slider__slider-wrap">
        <div class="video-reviews-slider__slider">
            <div class="swiper-wrapper">
                <?php foreach ($data['slides'] as $slide) {
                    App\Layout\Components\Cards\VideoReviewCard\Layout::drawVideoReviewCard(
                        className: 'swiper-slide',
                        title: $slide['title'] ?? '',
                        src: $slide['src'] ?? '',
                        poster: $slide['poster'] ?? '',
                    );
                } ?>
            </div>
        </div>
    </div>
</section>