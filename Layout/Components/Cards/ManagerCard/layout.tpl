<?php
/** @var array $data */

?>

<div class="manager-card <?= $data['className'] ?>">
    <div class="manager-card__image-wrap">
        <img class="manager-card__avatar"
             src="<?= $data['image'] ?: '/assets/images/placeholders/fallback-img.webp' ?>"
             alt="<?= $data['name'] ?>"
             loading="lazy"
             draggable="false"
        >
    </div>

    <div class="manager-card__text">
        <h4 class="manager-card__name"><?= $data['name'] ?></h4>
        <?php if ($data['job']): ?>
            <p class="manager-card__job"><?= $data['job'] ?></p>
        <?php endif; ?>
    </div>

    <div class="manager-card__links">
        <?php if ($data['phone']): ?>
            <a class="manager-card__phone"
               href="<?= 'tel:' . $data['phone'] ?>"
            >
                <span><?= $data['phone'] ?></span>
            </a>
        <?php endif; ?>

        <?php if ($data['email']): ?>
            <a class="manager-card__email"
               href="<?= 'mailto:' . $data['email'] ?>"
            >
                <span><?= $data['email'] ?></span>
            </a>
        <?php endif; ?>
    </div>
</div>