<?php
/** @var array $data */
?>

<section class="case-fs <?= $data['class'] ?>">
    <div class="case-fs__container container">
        <h1 class="case-fs__title"><?= $data['title'] ?></h1>
        <div class="case-fs__media">
            <div class="case-fs__image-container">
                <!------- Main ------->
                <div class="case-fs__image-gallery">
                    <div class="case-fs__main-slider">
                        <div class="swiper-wrapper">
                            <?php foreach ($data['images'] as $index => $img): ?>
                                <div class="case-fs__main-slide swiper-slide">
                                    <img class="case-fs__main-image"
                                         src="<?= $img['image'] ?>"
                                         alt="<?= $data['title'] . ' ' . $index ?>"
                                         data-index="<?= $index ?>"
                                         loading="lazy"
                                         draggable="false"
                                         data-fancybox="case-gallery-desktop"
                                    >
                                </div>
                            <?php endforeach; ?>
                        </div>
                        <?php
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'case-fs__slider-button--prev',
                            icon: 'arrow-left',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                        );

                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'case-fs__slider-button--next',
                            icon: 'arrow-right',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                        );
                        ?>
                    </div>
                </div>

                <!------- Thumbs ------->
                <div class="case-fs__images-aside">
                    <div class="swiper-wrapper">
                        <?php foreach ($data['images'] as $index => $img): ?>
                            <img class="case-fs__slide-thumb swiper-slide"
                                 src="<?= $img['image'] ?>"
                                 alt="<?= $data['title'] . ' ' . $index ?>"
                                 data-index="<?= $index ?>"
                                 loading="lazy"
                                 draggable="false"
                            >
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
            <div class="case-fs__main-slider-pagination"></div>

            <!------- Mobile ------->
            <div class="case-fs__slider">
                <div class="case-fs__slider-wrap">
                    <div class="swiper-wrapper">
                        <?php foreach ($data['images'] as $index => $img): ?>
                            <div class="case-fs__slide swiper-slide">
                                <img src="<?= $img['image'] ?>"
                                     alt="<?= $data['title'] . ' ' . $index ?>"
                                     loading="lazy"
                                     draggable="false"
                                     data-fancybox="case-gallery-mobile"
                                >
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
                <div class="case-fs__slider-pagination"></div>
            </div>
        </div>
    </div>
</section>