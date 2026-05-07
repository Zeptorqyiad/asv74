<?php
/** @var array $data */
?>

<?php if ($data['link']): ?>
    <a class="file-card <?= $data['className'] ?>"
       href="<?= $data['link'] ?>"
       target="_blank"
       download
       title="<?= $data['name'] ?>"
       aria-label="<?= $data['title'] ?>"
    >
        <span class="file-card__marker">
            <?= renderIcon('file') ?>
        </span>
        <p class="file-card__name"><?= $data['name'] ?></p>
        <span class="file-card__size"><?= $data['size'] ?></span>
    </a>
<?php endif; ?>