<?php
/** @var array $data */

$badgeConfigs = [
    [
        'condition' => $data['toOrder'] ?? false,
        'class' => 'new-model-banner__status-badge--to-order',
        'text' => 'Под заказ'
    ],
    [
        'condition' => $data['isNew'] ?? false,
        'class' => 'new-model-banner__status-badge--is-new',
        'text' => 'Новинка'
    ],
    [
        'condition' => $data['inStock'] ?? false,
        'class' => 'new-model-banner__status-badge--in-stock',
        'text' => 'В наличии'
    ],
    [
        'condition' => $data['isSale'] ?? false,
        'class' => 'new-model-banner__status-badge--sale',
        'text' => 'Акция'
    ],
    [
        'condition' => $data['fabric'] ?? false,
        'class' => 'new-model-banner__status-badge--fabric',
        'text' => $data['fabric']
    ]
];
?>

<div class="new-model-banner <?= $data['className'] ?>" <?= buildAttrs($data['attributes'] ?? []) ?>>
    <?php if ($data['background']): ?>
        <img class="new-model-banner__background"
             src="<?= $data['background'] ?>"
             alt=""
             draggable="false"
             loading="lazy"
             aria-hidden="true"
        >
    <?php else: ?>
        <div class="new-model-banner__background new-model-banner__background--color"></div>
    <?php endif; ?>

    <div class="new-model-banner__body">
        <div class="new-model-banner__media">
            <img class="new-model-banner__product-image"
                 src="<?= $data['image'] ?>"
                 alt="<?= $data['title'] ?>"
                 draggable="false"
                 loading="lazy"
            >

            <div class="new-model-banner__status-badges">
                <?php foreach ($badgeConfigs as $config) {
                    if ($config['condition']) {
                        App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                            className: "new-model-banner__status-badge {$config['class']}",
                            text: $config['text'],
                            style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::White,
                            size: \App\Layout\Components\UI\Core\Badge\BadgeSize::ExtraLarge
                        );
                    }
                }
                ?>
            </div>
        </div>

        <div class="new-model-banner__content">
            <div class="new-model-banner__text">
                <h3 class="new-model-banner__title"><?= $data['title'] ?></h3>
                <p class="new-model-banner__desc"><?= $data['desc'] ?></p>
            </div>

            <?php if ($data['badges']): ?>
                <div class="new-model-banner__spec-badges">
                    <?php foreach ($data['badges'] as $badge): ?>
                        <span class="new-model-banner__spec-badge"><?= $badge['text'] ?></span>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

            <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'new-model-banner__button-more',
                text: 'Подробнее',
                link: $data['link'] ?? '',
            ); ?>
        </div>
    </div>
</div>
