<?php
/** @var array $data */
?>

<div class="hover-image <?= $data['class'] ?>" data-hover-image>

    <?php foreach ($data['images'] as $index => $img): ?>
        <img src="<?= $img ?>"
             alt="<?= $data['title'] . ' ' . $index ?>"
             class="hover-image__img <?= $index == 0 ? 'hover-image__img--active' : '' ?>"
             loading="lazy"
             onerror="this.src=null;this.src='/assets/images/placeholders/fallback-img.webp'"
        >
    <?php endforeach; ?>

    <?php if ($data['link']): ?>
        <a class="hover-image__link" href="<?= $data['link'] ?>" aria-label="<?= $data['title'] ?>">
            <div class="hover-image__sections"></div>
        </a>
    <?php else: ?>
        <div class="hover-image__sections"></div>
    <?php endif; ?>

    <div class="hover-image__pagination"></div>
</div>