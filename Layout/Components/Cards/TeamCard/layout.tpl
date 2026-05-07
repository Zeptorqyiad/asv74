<?php
/** @var array $data */

?>

<div class="team-card <?= $data['class'] ?>">

    <img class="team-card__image"
         src="<?= $data['image'] ?: '/assets/images/placeholders/fallback-img.webp' ?>"
         alt="<?= $data['title'] ?>"
         draggable="false"
         loading="lazy"
    >

    <div class="team-card__text">
        <h4 class="team-card__title"><?= $data['name'] ?></h4>
        <p class="team-card__desc"><?= $data['job'] ?></p>
    </div>
</div>