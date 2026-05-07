<?php
/** @var array $data */

$catalogCardClasses = [
    'complect-card',
    $data['className'] ?? ''
];

$badgeConfigs = [
    [
        'condition' => $data['toOrder'] ?? false,
        'class' => 'complect-card__badge--to-order',
        'text' => 'Под заказ'
    ],
    [
        'condition' => $data['isNew'] ?? false,
        'class' => 'complect-card__badge--is-new',
        'text' => 'Новинка'
    ],
    [
        'condition' => $data['inStock'] ?? false,
        'class' => 'complect-card__badge--in-stock',
        'text' => 'В наличии'
    ],
    [
        'condition' => $data['isSale'] ?? false,
        'class' => 'complect-card__badge--sale',
        'text' => 'Акция'
    ]
];

?>

<div class="<?= implode(' ', $catalogCardClasses) ?>"
    <?= buildAttrs($data['attributes'] ?? []) ?>
     title="<?= $data['title'] ?>"
     itemscope
     itemtype="https://schema.org/Product"
>
    <a class="complect-card__link"
       href="<?= $data['link'] ?? '' ?>"
       draggable="false"
       aria-label="<?= $data['title'] ?? '' ?>"
    ></a>

    <div class="complect-card__container">
        <div class="complect-card__media">
            <div class="complect-card__media-wrapper">
                <div class="complect-card__status-badges">
                    <?php foreach ($badgeConfigs as $config) {
                        if ($config['condition']) {
                            App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                                className: "complect-card__badge {$config['class']}",
                                text: $config['text'],
                                style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::White,
                                size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                            );
                        }
                    } ?>
                </div>

                <?php App\Layout\Components\UI\Other\ButtonCompare\Layout::drawButtonCompare(
                    class: 'complect-card__button-compare',
                    productId: $data['productId'] ?? 0,
                    variantId: $data['variantId'] ?? 0,
                ); ?>

                <button class="complect-card__button-specification" type="button" onclick="modalManager.open('specs-modal', {
                        title: '<?= $data['title'] ?>',
                        link: '<?= $data['link'] ?>',
                        price: '<?= $data['price'] ?>',
                        priceOld: '<?= $data['oldPrice'] ?>',
                        toOrder: <?= $data['toOrder'] ? 'true' : 'false' ?>,
                        image: '<?= $data['images'][0] ?? '/assets/images/placeholders/fallback-img.webp' ?>',
                        specs: '<?= htmlspecialchars(json_encode($data['specs'])) ?>'
                        })">
                    <span>Характеристики</span>
                    <?= renderIcon('chevron-right') ?>
                </button>
            </div>
            <div class="complect-card__image-container">
                <?php
                App\Layout\Components\UI\Other\HoverImage\Layout::drawHoverImage(
                    class: 'complect-card__image-gallery',
                    images: $data['images'] ?? [],
                    link: $data['link'] ?? '',
                    title: $data['title'] ?? '',
                );
                ?>
            </div>
        </div>

        <div class="complect-card__content">
            <div class="complect-card__info">
                <h4 class="complect-card__title" itemprop="name"><?= $data['title'] ?></h4>
                <span class="complect-card__sku"><b>Код:</b> <?= $data['sku'] ?></span>
                <p class="complect-card__desc" itemprop="description"><?= $data['desc'] ?></p>
            </div>
            <div class="complect-card__actions">
                <div class="complect-card__prices" itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                    <meta itemprop="priceCurrency" content="RUB">

                    <?php /* if ($data['toOrder'] || !(int)$data['price']): ?>
                        <span class="complect-card__price complect-card__price--request">
                            Узнайте цену сейчас
                        </span>
                    <?php endif; */?>

                    <?php if ((int)$data['price']): ?>
                        <span class="complect-card__price complect-card__price--current" itemprop="price">
                            от <?= $data['price'] ?> ₽
                        </span>
                    <?php endif; ?>

                    <?php if ($data['oldPrice'] && $data['oldPrice'] != $data['price']): ?>
                        <span class="complect-card__price complect-card__price--old">
                            <?= $data['oldPrice'] ?> ₽
                        </span>
                    <?php else: ?>
                        <span class="complect-card__price complect-card__price--request">
                            Узнайте цену сейчас
                        </span>
                    <?php endif; ?>
                </div>

                <div class="complect-card__action-buttons">
                    <?php
                    /*
                    if ($data['toOrder'] || !(int)$data['price']) {
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'complect-card__button-order',
                            text: 'Узнать цену',
                            attributes: [
                                'onclick' => 'modalManager.open("callback-modal"); tracker.track("request_form_open");',
                            ]
                        );
                    }
                    */

                    if ((int)$data['price']) {
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'complect-card__button-order',
                            text: 'Оставить заявку',
                            attributes: [
                                'onclick' => 'modalManager.open("callback-modal"); tracker.track("order_form_open");',
                            ]
                        );
                    } else {
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'complect-card__button-order',
                            text: 'Узнать цену',
                            attributes: [
                                'onclick' => 'modalManager.open("callback-modal"); tracker.track("request_form_open");',
                            ]
                        );
                    }

                    if($data['link']) {
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'complect-card__button-order',
                            text: 'Подробнее',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                            attributes: [ 'onclick' => 'window.location.href="' . $data['link'] . '"' ]
                        );
                    }
                    ?>
                </div>
            </div>
        </div>
    </div>
</div>