<?php
/** @var array $data */

?>

<div class="work-card <?= $data['class'] ?>">

    <?php if ($data['image']): ?>
        <img class="work-card__image"
             src="<?= $data['image'] ?>"
             alt="<?= $data['title'] ?>"
             draggable="false"
             loading="lazy"
        >
    <?php endif; ?>

    <div class="work-card__text">
        <h4 class="work-card__title"><?= $data['title'] ?></h4>
        <p class="work-card__desc"><?= $data['desc'] ?></p>
    </div>
</div>