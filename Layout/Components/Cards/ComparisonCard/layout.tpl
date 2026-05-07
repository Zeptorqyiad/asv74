<?php
/** @var array $data */

$comparisonCardClasses = [
    'comparison-card',
    $data['className'] ?? ''
];
?>

<div class="<?= implode(' ', $comparisonCardClasses) ?>"
    <?= buildAttrs($data['attributes'] ?? []) ?>
     title="<?= $data['title'] ?>"
     data-product-id="<?= $data['productId'] ?>"
     data-variant-id="<?= $data['variantId'] ?>"
     itemscope
     itemtype="https://schema.org/Product"
>

    <a class="comparison-card__link"
       href="<?= $data['link'] ?>"
       draggable="false"
       aria-label="<?= $data['title'] ?? '' ?>"
    ></a>

    <div class="comparison-card__media">
        <div class="comparison-card__media-wrapper">
            <?php
            App\Layout\Components\UI\Other\ButtonCompare\Layout::drawButtonCompare(
                class: 'comparison-card__button-compare',
                productId: $data['productId'] ?? 0,
                variantId: $data['variantId'] ?? 0
            );
            ?>
        </div>

        <div class="comparison-card__image-container">
            <?php foreach ($data['images'] as $index => $img): ?>
                <img src="<?= $img ?>"
                     alt="<?= $data['title'] . ' ' . $index ?>' ?>"
                     draggable="false"
                     itemprop="image"
                     loading="lazy"
                >
            <?php endforeach; ?>
        </div>

        <div class="comparison-card__pagination"></div>
    </div>

    <div class="comparison-card__content">
        <div class="comparison-card__info">
            <h4 class="comparison-card__title" itemprop="name">
                <?= $data['title'] ?>
            </h4>

            <?php if ($data['desc']): ?>
                <p class="comparison-card__desc" itemprop="description"><?= $data['desc'] ?></p>
            <?php endif; ?>

            <div class="comparison-card__prices"
                 itemprop="offers"
                 itemscope
                 itemtype="https://schema.org/Offer"
            >
                <meta itemprop="priceCurrency" content="RUB">

                <?php if ($data['toOrder'] && !$data['price']): ?>
                    <span class="comparison-card__price comparison-card__price--request">
                        Узнайте цену сейчас
                    </span>
                <?php endif; ?>

                <?php if ($data['price']): ?>
                    <span class="comparison-card__price comparison-card__price--current" itemprop="price">
                        от <?= $data['price'] ?> ₽
                    </span>
                <?php endif; ?>

                <?php if ($data['oldPrice'] && $data['oldPrice'] != $data['price']): ?>
                    <span class="comparison-card__price comparison-card__price--old">
                        <?= $data['oldPrice'] ?> ₽
                    </span>
                <?php endif; ?>
            </div>
        </div>

        <div class="comparison-card__actions">
            <?php
            if ($data['toOrder'] && !$data['price']) {
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'comparison-card__button-order',
                    text: 'Узнать цену',
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                    attributes: [
                        'onclick' => 'modalManager.open("callback-modal")',
                    ]
                );
            }

            if ($data['price']) {
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'comparison-card__button-order',
                    text: 'Оставить заявку',
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                    attributes: [
                        'onclick' => 'modalManager.open("callback-modal")',
                    ]
                );
            }

            App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                className: 'comparison-card__button-about',
                text: 'Подробнее',
                link: $data['link'],
                style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                size: \App\Layout\Components\UI\Core\Tab\TabSize::Small
            );
            ?>
        </div>
    </div>
</div>