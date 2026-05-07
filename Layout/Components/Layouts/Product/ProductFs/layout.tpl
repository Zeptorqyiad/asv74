<?php
/** @var array $data */

$badgeConfigs = [
    [
        'condition' => $data['toOrder'] ?? false,
        'class' => 'product-fs__badge--to-order',
        'text' => 'Под заказ'
    ],
    [
        'condition' => $data['isNew'] ?? false,
        'class' => 'product-fs__badge--is-new',
        'text' => 'Новинка'
    ],
    [
        'condition' => $data['inStock'] ?? false,
        'class' => 'product-fs__badge--in-stock',
        'text' => 'В наличии'
    ],
    [
        'condition' => $data['isSale'] ?? false,
        'class' => 'product-fs__badge--sale',
        'text' => 'Акция'
    ],
    [
        'condition' => $data['fabric'] ?? false,
        'class' => 'product-fs__badge--fabric',
        'text' => $data['fabric']
    ],
    [
        'condition' => $data['chassisDep'] ?? false,
        'class' => 'product-fs__badge--chassis-dep',
        'text' => 'Собственное производство'
    ]
];
?>

<section class="product-fs">
    <?php if ($data['images']): ?>
        <div class="product-fs__media">

            <div class="product-fs__image-container">
                <!------- Thumbs ------->
                <div class="product-fs__images-aside">
                    <div class="swiper-wrapper">
                        <?php foreach ($data['images'] as $index => $img): ?>
                            <?php if (!($img['video'] ?? '')): ?>
                                <img class="product-fs__slide-thumb swiper-slide"
                                     src="<?= $img['img'] ?>"
                                     alt="<?= $data['title'] . ' ' . $index ?>"
                                     data-index="<?= $index ?>"
                                     loading="lazy"
                                     draggable="false"
                                >
                            <?php else: ?>
                                <video class="product-fs__slide-thumb swiper-slide"
                                       playsinline
                                       muted
                                       preload="metadata"
                                       data-index="<?= $index ?>"
                                       loading="lazy"
                                >
                                    <source src="/uf/files/<?= $img['video'] ?>"
                                            type="video/<?= pathinfo($img['video'], PATHINFO_EXTENSION) ?>">
                                    Ваш браузер не поддерживает видео.
                                </video>
                            <?php endif; ?>
                        <?php endforeach; ?>
                    </div>
                    <?php
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'product-fs__slider-button-prev',
                        icon: 'chevron-up',
                        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    );

                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'product-fs__slider-button-next',
                        icon: 'chevron-down',
                        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    );
                    ?>
                </div>
                <!------- Main ------->
                <div class="product-fs__image-gallery">
                    <div class="product-fs__main-slider">
                        <div class="swiper-wrapper">
                            <?php foreach ($data['images'] as $index => $img): ?>
                                <div class="product-fs__main-slide swiper-slide">
                                    <?php if (!($img['video'] ?? '')): ?>
                                        <img class="product-fs__main-image"
                                             src="<?= $img['img'] ?>"
                                             alt="<?= $data['title'] . ' ' . $index ?>"
                                             data-index="<?= $index ?>"
                                             loading="lazy"
                                             draggable="false"
                                             data-fancybox="prod-gallery-desktop"
                                        >
                                    <?php else: ?>
                                        <video class="product-fs__main-image"
                                               data-index="<?= $index ?>"
                                               playsinline
                                               muted
                                               controls
                                               preload="metadata"
                                               loading="lazy"
                                        >
                                            <source src="/uf/files/<?= $img['video'] ?>"
                                                    type="video/<?= pathinfo($img['video'], PATHINFO_EXTENSION) ?>">
                                            Ваш браузер не поддерживает видео.
                                        </video>
                                    <?php endif; ?>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    </div>

                    <div class="product-fs__status-badges">
                        <?php foreach ($badgeConfigs as $config) {
                            if ($config['condition']) {
                                App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                                    className: "product-fs__badge {$config['class']}",
                                    text: $config['text'],
                                    style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::White,
                                    size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                                );
                            }
                        }
                        ?>
                    </div>
                </div>
            </div>

            <!------- Mobile ------->
            <div class="product-fs__slider">
                <div class="product-fs__slider-wrap">
                    <div class="swiper-wrapper">
                        <?php foreach ($data['images'] as $index => $img): ?>
                            <div class="product-fs__slide swiper-slide">
                                <?php if (!($img['video'] ?? '')): ?>
                                    <img src="<?= $img['img'] ?>"
                                         alt="<?= $data['title'] . ' ' . $index ?>"
                                         loading="lazy"
                                         draggable="false"
                                         data-fancybox="prod-gallery-mobile"
                                    >
                                <?php else: ?>
                                    <video class="product-fs__slide"
                                           data-index="<?= $index ?>"
                                           playsinline
                                           muted
                                           controls
                                           preload="metadata"
                                           loading="lazy"
                                    >
                                        <source src="/uf/files/<?= $img['video'] ?>"
                                                type="video/<?= pathinfo($img['video'], PATHINFO_EXTENSION) ?>">
                                        Ваш браузер не поддерживает видео.
                                    </video>
                                <?php endif; ?>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
                <div class="product-fs__slider-pagination"></div>
            </div>
        </div>
    <?php endif; ?>

    <div class="product-fs__badges-mobile">
        <?php foreach ($badgeConfigs as $config) {
            if ($config['condition']) {
                App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                    className: "product-fs__badge {$config['class']}",
                    text: $config['text'],
                    style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::White,
                    size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                );
            }
        }
        ?>
    </div>

    <div class="product-fs__info">
        <h2 class="product-fs__info-title"><?= $data['title'] ?></h2>
        <span class="product-fs__info-sku"><?= $data['sku'] ?></span>
    </div>

    <div class="product-fs__actions">
        <?php
        if ($data['productId']) {
            App\Layout\Components\UI\Other\ButtonCompare\Layout::drawButtonCompare(
                class: 'product-fs__button product-fs__button-compare',
                productId: $data['productId'] ?? 0,
                variantId: $data['variantId'] ?? 0,
                style: \App\Layout\Components\UI\Other\ButtonCompare\ButtonCompareStyle::Full
            );
        }

        if ($data['file']) {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'product-fs__button product-fs__button-download',
                text: 'Скачать PDF',
                link: $data['file'],
                icon: 'download',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                attributes: [
                    'download' => $data['title'],
                ]
            );

            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'product-fs__button product-fs__button-print',
                text: 'Распечатать',
                link: $data['file'] . '&print=1',
                icon: 'unique-printer',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                attributes: [
                    'onclick' => 'window.open(this.href); return false;',
                ]
            );
        }

        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'product-fs__button product-fs__button-share share-button',
            text: 'Поделиться',
            icon: 'share',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
        );
        ?>
    </div>
</section>