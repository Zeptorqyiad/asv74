<?php
/** @var array $data */
?>

<div class="certificate-card <?= $data['className'] ?>"
    <?= buildAttrs($data['attributes'] ?? []) ?>
     title="<?= $data['title'] ?>"
>

    <div class="certificate-card__media">
        <img class="certificate-card__image"
             src="<?= $data['image'] ?>"
             alt="<?= $data['title'] ?>"
             draggable="false"
             loading="lazy"
             data-fancybox="cert-images"
             data-caption="<?= $data['title'] ?>"
        >
    </div>

    <?php if ($data['title']): ?>
        <h4 class="certificate-card__title"><?= $data['title'] ?></h4>
    <?php endif; ?>
</div>