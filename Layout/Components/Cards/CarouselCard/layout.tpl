<?php
/** @var array $data */


?>

<div class="carousel-card <?= $data['className'] ?>">
    <div class="carousel-card__media">
        <?php if ($data['image'] && !$data['video']): ?>
            <img src="<?= $data['image'] ?>" alt="" class="carousel-card__image" draggable="false" loading="lazy">
        <?php elseif ($data['video'] && $data['image']): ?>
            <video class="carousel-card__video"
                   playsinline
                   muted
                   autoplay
                   loop
                   poster="<?= $data['image'] ?>"
                   preload="metadata"
            >
                <source src="<?= $data['video'] ?>" type="video/<?= pathinfo($data['video'], PATHINFO_EXTENSION) ?>">
                Ваш браузер не поддерживает видео.
            </video>
        <?php endif; ?>
    </div>

    <div class="carousel-card__container">
        <?php if (!empty($data['link'])): ?>
        <a class="carousel-card__link" href="<?= $data['link'] ?>" aria-label="<?= $data['title'] ?>">
            <h3 class="carousel-card__title">
                <span><?= $data['title'] ?></span>
                <?= renderIcon('arrow-up-right') ?>
            </h3>
            <p class="carousel-card__desc"><?= $data['desc'] ?></p>
        </a>
        <?php endif; ?>
    </div>
</div>