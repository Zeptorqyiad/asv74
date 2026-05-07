<?php
/** @var array $data */
?>

<div class="product-manager-info <?= $data['className'] ?>">
    <div class="product-manager-info__credentials">
        <div class="product-manager-info__image-wrap">
            <img class="product-manager-info__avatar"
                 src="<?= $data['image'] ?: '/assets/images/placeholders/fallback-img.webp' ?>"
                 alt="<?= $data['name'] ?>"
                 loading="lazy"
                 draggable="false"
            >
        </div>

        <div class="product-manager-info__text">
            <h4 class="product-manager-info__name"><?= $data['name'] ?></h4>
            <?php if ($data['job']): ?>
                <p class="product-manager-info__job"><?= $data['job'] ?></p>
            <?php endif; ?>
        </div>

        <div class="product-manager-info__links">
            <?php if ($data['phone']): ?>
                <?php foreach (json_decode($data['phone'], true)['v'] ?? [] as $phone): ?>
                    <a class="product-manager-info__phone"
                       href="<?= 'tel:' . $phone['phone'] ?>"
                    >
                        <span><?= $phone['phone'] ?></span>
                    </a>
                <?php endforeach; ?>
            <?php endif; ?>

            <?php if ($data['email']): ?>
                <a class="product-manager-info__email"
                   href="<?= 'mailto:' . $data['email'] ?>"
                >
                    <span><?= $data['email'] ?></span>
                </a>
            <?php endif; ?>
        </div>
    </div>

    <div class="product-manager-info__benefits">
        <div class="product-manager-info__row">
            <?= renderIcon('unique-shield-tick') ?>
            <p class="product-manager-info__row-text">Гарантия на навесное <span>12 месяцев</span></p>
        </div>
        <div class="product-manager-info__row">
            <?= renderIcon('unique-car') ?>
            <p class="product-manager-info__row-text">Доставка по РФ и СНГ</p>
        </div>
        <a href="/info/delivery/" class="product-manager-info__row product-manager-info__row--link">
            Подробнее о доставке и оплате
        </a>
    </div>
</div>