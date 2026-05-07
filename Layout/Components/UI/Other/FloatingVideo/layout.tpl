<?php
/** @var array $data */
?>

<div class="floating-video <?= $data['class'] ?>">
    <div class="floating-video__media">

        <a
            class="floating-video__media-wrap"
            href="<?= $data['src'] ?>"
            data-poster="<?= $data['poster'] ?>"
            data-fancybox
        >
            <video class="floating-video__video"
                   playsinline
                   muted
                   loop
                   preload="metadata"
                   autoplay
                   poster="<?= $data['poster'] ?>"
            >
                <source src="<?= $data['src'] ?>" type="video/mp4">
                Ваш браузер не поддерживает видео.
            </video>

<!--            <a class="floating-video__link" href="--><?php //= $data['linkTo'] ?><!--" draggable="false"></a>-->
        </a>

        <button class="floating-video__button-close">
            <?= renderIcon('close') ?>
        </button>
    </div>
</div>
