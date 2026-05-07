<?php
/** @var array $data */

?>

<div class="search-card"
    <?= buildAttrs($data['attributes'] ?? []) ?>
     title="<?= $data['title'] ?>"
     data-product-id="<?= $data['productId'] ?>"
     data-variant-id="<?= $data['variantId'] ?>"
     itemscope
     itemtype="https://schema.org/Product"
>

    <a class="search-card__link"
       href="<?= $data['link'] ?>"
       draggable="false"
       aria-label="<?= $data['title'] ?>"
    ></a>

    <img class="search-card__image"
         src="<?= $data['image'] ?>"
         alt="<?= $data['title'] ?>"
         loading="lazy"
         onerror="this.src=null;this.src='/assets/images/placeholders/fallback-img.webp'"
    >

    <div class="search-card__text">
        <p class="search-card__title"><?= $data['title'] ?></p>
        <span class="search-card__desc"><?= $data['desc'] ?></span>
    </div>
</div>