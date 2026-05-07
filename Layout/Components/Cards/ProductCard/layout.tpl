<?php
/** @var array $data */

$productCardClasses = [
    'product-card',
    $data['className'] ?? ''
];

$badgeConfigs = [
    [
        'condition' => $data['toOrder'] ?? false,
        'class' => 'product-card__badge--to-order',
        'text' => 'Под заказ'
    ],
    [
        'condition' => $data['isNew'] ?? false,
        'class' => 'product-card__badge--is-new',
        'text' => 'Новинка'
    ],
    [
        'condition' => $data['inStock'] ?? false,
        'class' => 'product-card__badge--in-stock',
        'text' => 'В наличии'
    ],
    [
        'condition' => $data['isSale'] ?? false,
        'class' => 'product-card__badge--sale',
        'text' => 'Акция'
    ],
    [
        'condition' => $data['fabric'] ?? false,
        'class' => 'product-card__badge--fabric',
        'text' => $data['fabric']
    ],
    [
        'condition' => $data['chassisDep'] ?? false,
        'class' => 'product-card__badge--chassis-dep',
        'text' => 'Собственное производство'
    ]
];
?>

<div class="<?= implode(' ', $productCardClasses) ?>"
    <?= buildAttrs($data['attributes'] ?? []) ?>
     title="<?= $data['title'] ?>"
     data-product-id="<?= $data['productId'] ?>"
     data-variant-id="<?= $data['variantId'] ?>"
     itemscope
     itemtype="https://schema.org/Product"
>

    <a class="product-card__link"
       href="<?= $data['link'] ?>"
       draggable="false"
       aria-label="<?= $data['title'] ?? '' ?>"
    ></a>

    <div class="product-card__media">
        <div class="product-card__media-wrapper">
            <div class="product-card__status-badges">
                <?php foreach ($badgeConfigs as $config) {
                    if ($config['condition']) {
                        App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                            className: "product-card__badge {$config['class']}",
                            text: $config['text'],
                            style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::White,
                            size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                        );
                    }
                }
                ?>
            </div>

            <?php App\Layout\Components\UI\Other\ButtonCompare\Layout::drawButtonCompare(
                class: 'product-card__button-compare',
                productId: $data['productId'] ?? 0,
                variantId: $data['variantId'] ?? 0,
            ); ?>

            <?php /* ?>
            <button class="product-card__button-specification" type="button"
                    onclick="modalManager.open('specs-modal', {
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
            <?php */ ?>
        </div>

        <div class="product-card__image-container">
            <?php
            App\Layout\Components\UI\Other\HoverImage\Layout::drawHoverImage(
                images: $data['images'] ?? [],
                link: $data['link'] ?? '',
                title: $data['title'] ?? '',
            );
            ?>
        </div>
    </div>

    <div class="product-card__pagination"></div>

    <div class="product-card__content">
        <div class="product-card__info">
            <div class="product-card__meta">
                <?php if ($data['category']): ?>
                    <span class="product-card__category" itemprop="category">
                        <?= $data['category'] ?>
                    </span>
                <?php endif; ?>
                <?php if ($data['sku']): ?>
                    <span class="product-card__part-number" itemprop="sku">
                        Код: <?= $data['sku'] ?>
                    </span>
                <?php endif; ?>
            </div>

            <h3 class="product-card__title" itemprop="name">
                <?= $data['title'] ?>
            </h3>

            <?php if ($data['desc']): ?>
                <p class="product-card__desc" itemprop="description"><?= $data['desc'] ?></p>
            <?php endif; ?>

            <div class="product-card__prices"
                 itemprop="offers"
                 itemscope
                 itemtype="https://schema.org/Offer"
            >
                <meta itemprop="priceCurrency" content="RUB">

                <?php /*if ($data['toOrder'] || !(int)$data['price']): ?>
                    <span class="product-card__price product-card__price--request">
                        Узнайте цену сейчас
                    </span>
                <?php endif;*/ ?>

                <?php if ((int)$data['price']): ?>
                    <span class="product-card__price product-card__price--current" itemprop="price">
                        от <?= $data['price'] ?> ₽
                    </span>
                <?php else: ?>
                    <span class="product-card__price product-card__price--request">
                        Узнайте цену сейчас
                    </span>
                <?php endif; ?>

                <?php if ($data['oldPrice'] && $data['oldPrice'] != $data['price']): ?>
                    <span class="product-card__price product-card__price--old">
                        <?= $data['oldPrice'] ?> ₽
                    </span>
                <?php endif; ?>
            </div>
        </div>

        <div class="product-card__actions">
            <?php
            $btnText = 'Оставить заявку';
            $btnType = 'order';

//            if ($data['toOrder'] || !(int)$data['price']) {
            if (!(int)$data['price']) {
                $btnText = 'Узнать цену';
                $btnType = 'request';
            }

            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'product-card__button-order',
                text: $btnText,
                attributes: [
                    'onclick' => 'modalManager.open("callback-modal"); tracker.track("' . $btnType . '_form_open");',
                ]
            );

            /*
            App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                className: 'product-card__button-about',
                text: 'Подробнее',
                link: $data['link'] ?? '',
                style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary
            );
            */

            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'product-card__button-lizing',
                text: 'Выгодный лизинг',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                attributes: [
                    'onclick' => 'modalManager.open("callback-modal", {
                    type: "leasing",
                    title: "Оформить заявку на лизинг",
                    desc: "Заполните форму, чтобы узнать о доступных условиях лизинга на выбранную технику."
                }); 
                tracker.track("leasing_form_open");',
                ]
            );
            ?>
        </div>
    </div>
</div>