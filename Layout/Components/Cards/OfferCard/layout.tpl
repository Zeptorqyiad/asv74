<?php
/** @var array $data */
?>

<?php if ($data['link']): ?>
    <a href="<?= $data['link'] ?>"
       class="offer-card <?= $data['className'] ?>"
       draggable="false"
       aria-label="<?= $data['title'] ?>"
       title="<?= $data['title'] ?>"
    >
        <img class="offer-card__image"
             src="<?= $data['image'] ?>"
             alt=""
             draggable="false"
             loading="lazy"
        >
        <?php if ($data['title']): ?>
            <p class="offer-card__text <?= $data['darkText'] ? '' : 'offer-card__text--white' ?>"><?= $data['title'] ?></p>
        <?php endif; ?>
    </a>
<?php endif; ?>