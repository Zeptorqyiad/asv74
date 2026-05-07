<?php
/** @var array $data */

?>

<div class="carousel carousel--desktop">
    <div class="carousel__track">
        <?php foreach ($data['slides'] as $index => $slide): ?>
            <div class="carousel__slide" data-index="<?= $index ?>">
                <div class="carousel__slide-image-wrap">

                    <?php if ($slide->image && !$slide->video): ?>
                        <img src="<?= '/uf/images/source/' . $slide->image ?>"
                             alt="<?= $slide->title ?>"
                             class="carousel__slide-image"
                             draggable="false"
                             loading="lazy"
                        >
                    <?php elseif ($slide->video && $slide->image): ?>
                        <video class="carousel__slide-video"
                               playsinline
                               muted
                               autoplay
                               loop
                               poster="<?= '/uf/images/source/' . $slide->image ?>"
                               preload="metadata"
                        >
                            <source src="<?= '/uf/files/' . $slide->video ?>"
                                    type="video/<?= pathinfo('/uf/files/' . $slide->video, PATHINFO_EXTENSION) ?>">
                            Ваш браузер не поддерживает видео.
                        </video>
                    <?php endif; ?>

                    <div class="carousel__slide-buttons">
                        <button class="carousel__slide-button carousel__slide-button--prev" aria-label="Предыдущий слайд">
                            <?= renderIcon('arrow-left') ?>
                        </button>
                        <button class="carousel__slide-button carousel__slide-button--next" aria-label="Следующий слайд">
                            <?= renderIcon('arrow-right') ?>
                        </button>
                    </div>
                </div>

                <div class="carousel__slide-container">
                    <?php if (!empty($slide->link)): ?>
                    <a href="<?= $slide->link ?>" class="carousel__slide-link" title="<?= $slide->title ?>">
                        <span class="carousel__slide-title">
                            <span><?= $slide->title ?></span>
                            <?= renderIcon('arrow-up-right') ?>
                        </span>
                        <p class="carousel__slide-desc"><?= $slide->desc ?></p>
                    </a>
                    <?php endif; ?>
                </div>
            </div>
        <?php endforeach; ?>
    </div>

    <?php
    App\Layout\Components\UI\Other\Preloader\Layout::drawPreloader(
        className: 'carousel__preloader active',
    );
    ?>
</div>

<div class="carousel carousel--mobile">
    <div class="carousel__swiper">
        <div class="swiper-wrapper">
            <?php foreach ($data['slides'] as $index => $slide) {
                App\Layout\Components\Cards\CarouselCard\Layout::drawCarouselCard(
                    className: 'swiper-slide',
                    link: $slide->link ?? '',
                    title: $slide->title ?? '',
                    desc: $slide->desc ?? '',
                    image: $slide->image_mob ? '/uf/images/source/' . $slide->image_mob : '',
                    video: $slide->video ? '/uf/files/' . $slide->video : '',
                );
            } ?>
        </div>
    </div>
    <div class="carousel__swiper-pagination"></div>
</div>