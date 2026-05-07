<?php
/** @var array $data */

$categoryCardClasses = [
    'category-card',
    "category-card-size--{$data['size']}",
    $data['className'] ?? ''
];
?>

<div class="<?= implode(' ', $categoryCardClasses) ?>" <?= buildAttrs($data['attributes'] ?? []) ?>>

    <a class="category-card__link"
       href="<?= $data['link'] ?>"
       aria-label="<?= $data['title'] ?>"
    ></a>

    <div class="category-card__image-wrapper">
        <img src="<?= $data['image'] ?: '/assets/images/placeholders/fallback-icon.svg' ?>"
             alt="<?= $data['title'] ?>"
             draggable="false"
             loading="lazy"
             onerror="this.src=null;this.src='/assets/images/placeholders/fallback-icon.svg'"
        >
    </div>

    <h3 class="category-card__title">
        <span><?= $data['title'] ?></span>
        <?= renderIcon('arrow-up-right') ?>
    </h3>

    <a class="category-card__button-link" style="<?= ($data['link2'] ?? '') ? 'display:flex' : '' ?>"
       href="<?= $data['link2'] ?? $data['link'] ?>">
        <span>Перейти в категорию</span>
        <?= renderIcon('arrow-up-right') ?>
    </a>

    <?php if ($data['subcategories']): ?>
        <div class="category-card__subcategories">
            <?php foreach ($data['subcategories'] as $subcategory): ?>
                <a class="category-card__subcategory-link" href="/<?= $subcategory['link'] ?>">
                    <?= $subcategory['title'] ?>
                </a>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</div>