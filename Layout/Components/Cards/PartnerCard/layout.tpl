<?php
/** @var array $data */
?>

<?php if ($data['image']): ?>
    <div class="partner-card <?= $data['className'] ?>" title="<?= $data['title'] ?>">
        <div class="partner-card__image-wrap">
            <img class="partner-card__image"
                 src="<?= $data['image'] ?>"
                 alt="<?= $data['title'] ?>"
                 draggable="false"
                 loading="lazy"
            >
        </div>

        <div class="partner-card__text">
            <h3 class="partner-card__title"><?= $data['title'] ?></h3>
            <p class="partner-card__desc"><?= $data['desc'] ?></p>
        </div>
    </div>
<?php endif; ?>