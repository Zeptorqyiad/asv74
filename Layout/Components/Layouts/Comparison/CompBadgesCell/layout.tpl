<?php
/** @var array $data */

$badgeConfigs = [
    [
        'condition' => $data['toOrder'] ?? true,
        'class' => 'comp-badges-cell__badge--to-order',
        'text' => 'Под заказ'
    ],
    [
        'condition' => $data['isNew'] ?? true,
        'class' => 'comp-badges-cell__badge--is-new',
        'text' => 'Новинка'
    ],
    [
        'condition' => $data['inStock'] ?? true,
        'class' => 'comp-badges-cell__badge--in-stock',
        'text' => 'В наличии'
    ],
    [
        'condition' => $data['isSale'] ?? true,
        'class' => 'comp-badges-cell__badge--sale',
        'text' => 'Акция'
    ]
];

?>

<div class="comp-badges-cell swiper-slide">
    <?php foreach ($badgeConfigs as $config) {
        if ($config['condition']) {
            App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                className: "comp-badges-cell__badge {$config['class']}",
                text: $config['text'],
                style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::White,
                size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
            );
        }
    }
    ?>
</div>