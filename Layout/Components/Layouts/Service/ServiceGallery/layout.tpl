<?php
/** @var array $data */
?>

<?php if (!empty($data['images'])): ?>
<section class="service-gallery <?= $data['class'] ?>">
    <div class="service-gallery__container container">
        <div class="service-gallery__image-container">
            <div class="service-gallery__slider">
                <div class="swiper-wrapper">
                    <?php foreach ($data['images'] as $index => $img): ?>
                        <div class="service-gallery__slide swiper-slide">
                            <img src="<?= $img['image'] ?>"
                                 alt="<?= $data['title'] . ' ' . $index ?>"
                                 data-index="<?= $index ?>"
                                 loading="lazy"
                                 draggable="false"
                                 data-fancybox="service-gallery-desktop"
                            >
                        </div>
                    <?php endforeach; ?>
                </div>
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'service-gallery__slider-button--prev',
                    icon: 'arrow-left',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                );

                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'service-gallery__slider-button--next',
                    icon: 'arrow-right',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                );
                ?>
            </div>

            <div class="service-gallery__thumbs">
                <div class="swiper-wrapper">
                    <?php foreach ($data['images'] as $index => $img): ?>
                        <img class="service-gallery__thumb-slide swiper-slide"
                             src="<?= $img['image'] ?>"
                             alt="<?= $data['title'] . ' ' . $index ?>"
                             data-index="<?= $index ?>"
                             loading="lazy"
                             draggable="false"
                        >
                    <?php endforeach; ?>
                </div>
            </div>

            <div class="service-gallery__slider-pagination"></div>
        </div>
    </div>
</section>
<?php endif; ?>