<?php
/** @var array $data */

$catalogCardClasses = [
    'catalog-card',
    $data['className'] ?? ''
];

$badgeConfigs = [
    [
        'condition' => $data['toOrder'] ?? false,
        'class' => 'catalog-card__badge--to-order',
        'text' => 'Под заказ'
    ],
    [
        'condition' => $data['isNew'] ?? false,
        'class' => 'catalog-card__badge--is-new',
        'text' => 'Новинка'
    ],
    [
        'condition' => $data['inStock'] ?? false,
        'class' => 'catalog-card__badge--in-stock',
        'text' => 'В наличии'
    ],
    [
        'condition' => $data['isSale'] ?? false,
        'class' => 'catalog-card__badge--sale',
        'text' => 'Акция'
    ],
    [
        'condition' => $data['fabric'] ?? false,
        'class' => 'catalog-card__badge--fabric',
        'text' => $data['fabric']
    ],
    [
        'condition' => $data['chassisDep'] ?? false,
        'class' => 'catalog-card__badge--chassis-dep',
        'text' => 'Собственное производство'
    ]
];

?>

<div class="<?= implode(' ', $catalogCardClasses) ?>"
    <?= buildAttrs($data['attributes'] ?? []) ?>
     title="<?= $data['title'] ?>"
     itemscope
     itemtype="https://schema.org/Product"
>
    <a class="catalog-card__link"
       href="<?= $data['link'] ?? '' ?>"
       draggable="false"
       aria-label="<?= $data['title'] ?? '' ?>"
    ></a>

    <div class="catalog-card__container">
        <div class="catalog-card__media">
            <div class="catalog-card__image-container">
                <?php
                App\Layout\Components\UI\Other\HoverImage\Layout::drawHoverImage(
                    class: 'catalog-card__image-gallery',
                    images: $data['images'] ?? [],
                    link: $data['link'] ?? '',
                    title: $data['title'] ?? '',
                );
                ?>

                <?php if (!empty($data['images']) && count($data['images']) > 1): ?>
                    <div class="catalog-card__images-aside">
                        <?php foreach ($data['images'] as $index => $img): ?>
                            <?php if ($index === 0 || $index > 4) {
                                continue;
                            } ?>

                            <img src="<?= $img ?>"
                                 alt="<?= $data['title'] . ' ' . $index ?>"
                                 draggable="false"
                                 itemprop="image"
                                 loading="lazy"
                            >
                        <?php endforeach; ?>
                    </div>
                <?php endif; ?>
            </div>
        </div>

        <div class="catalog-card__content">
            <div class="catalog-card__info">
                <h4 class="catalog-card__title" itemprop="name"><?= $data['title'] ?></h4>
                <span class="catalog-card__sku">Код: <?= $data['sku'] ?></span>
                <div class="catalog-card__status-badges">
                    <?php foreach ($badgeConfigs as $config) {
                        if ($config['condition']) {
                            App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                                className: "catalog-card__badge {$config['class']}",
                                text: $config['text'],
                                style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::White,
                                size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                            );
                        }
                    }
                    ?>
                </div>
                <p class="catalog-card__desc" itemprop="description"><?= $data['desc'] ?></p>
            </div>
        </div>

        <div class="catalog-card__actions">
            <div class="catalog-card__prices"
                 itemprop="offers"
                 itemscope
                 itemtype="https://schema.org/Offer"
            >
                <meta itemprop="priceCurrency" content="RUB">

                <?php /* if ($data['toOrder'] || !(int)$data['price']): ?>
                    <span class="catalog-card__price catalog-card__price--request">
                        Узнайте цену сейчас
                    </span>
                <?php endif; */?>

                <?php if ($data['oldPrice'] && $data['oldPrice'] != $data['price']): ?>
                    <span class="catalog-card__price catalog-card__price--old">
                        <?= $data['oldPrice'] ?> ₽
                    </span>
                <?php endif; ?>

                <?php if ((int)$data['price']): ?>
                    <span class="catalog-card__price catalog-card__price--current" itemprop="price">
                        от <?= $data['price'] ?> ₽
                    </span>
                <?php else: ?>
                    <span class="catalog-card__price catalog-card__price--request">
                        Узнайте цену сейчас
                    </span>
                <?php endif; ?>
            </div>

            <div class="catalog-card__action-buttons">
                <div class="catalog-card__control-buttons">
                    <?php /* ?>
                    <button class="catalog-card__button-specification"
                            onclick="modalManager.open('specs-modal', {
                                    title: '<?= $data['title'] ?>',
                                    link: '<?= $data['link'] ?>',
                                    price: '<?= $data['price'] ?>',
                                    priceOld: '<?= $data['oldPrice'] ?>',
                                    toOrder: <?= $data['toOrder'] ? 'true' : 'false' ?>,
                                    image: '<?= $data['images'][0] ?? '/assets/images/placeholders/fallback-img.webp' ?>',
                                    specs: '<?= htmlspecialchars(json_encode($data['specs'])) ?>'
                                    })">
                        <?= renderIcon('specs') ?>
                        <span>Характеристики</span>
                    </button>
                    <?php */ ?>

                    <?php App\Layout\Components\UI\Other\ButtonCompare\Layout::drawButtonCompare(
                        class: 'catalog-card__button-compare',
                        productId: $data['productId'] ?? 0,
                        variantId: $data['variantId'] ?? 0,
                        style: \App\Layout\Components\UI\Other\ButtonCompare\ButtonCompareStyle::Full,
                    ); ?>

                </div>
                <?php
                /*
                 * toOrder - под заказ
                if ($data['toOrder'] || !(int)$data['price']) {
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'catalog-card__button-order',
                        text: 'Узнать цену',
                        attributes: [
                            'onclick' => 'modalManager.open("callback-modal"); tracker.track("request_form_open");',
                        ]
                    );
                }
                */

                if ((int)$data['price']) {
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'catalog-card__button-order',
                        text: 'Оставить заявку',
                        attributes: [
                            'onclick' => 'modalManager.open("callback-modal"); tracker.track("order_form_open");',
                        ]
                    );
                } else {
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'catalog-card__button-order',
                        text: 'Узнать цену',
                        attributes: [
                            'onclick' => 'modalManager.open("callback-modal"); tracker.track("request_form_open");',
                        ]
                    );
                }

                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'catalog-card__button-order w-full',
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
</div>