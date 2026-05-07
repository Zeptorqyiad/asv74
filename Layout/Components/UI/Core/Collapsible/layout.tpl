<?php
/** @var array $data */

$collapsibleClasses = [
    'collapsible',
    $data['className'] ?? ''
];
?>

<div class="<?= implode(' ', $collapsibleClasses) ?>">
    <?php App\Layout\Components\UI\Core\TabImage\Layout::drawTabImage(
        className: 'collapsible__trigger',
        text: $data['text'] ?? '',
        image: $data['image'] ?? '',
        marker: $data['marker'] ?? '',
        iconRight: 'chevron-down-sm',
        badge: $data['badge'] ?? '',
        style: \App\Layout\Components\UI\Core\TabImage\TabImageStyle::Secondary,
        size: \App\Layout\Components\UI\Core\TabImage\TabImageSize::Medium,
        attributes: [

        ]
    ); ?>

    <ul class="collapsible__menu">
        <?php foreach ($data['options'] as $option): ?>
            <li class="collapsible__option" role="menuitem" data-value="<?= $option['value'] ?>">
                <?php App\Layout\Components\UI\Core\TabImage\Layout::drawTabImage(
                    className: 'collapsible__link',
                    text: $option['text'] ?? '',
                    link: $option['link'] ?? '',
                    image: $option['image'] ?? '',
                    marker: $option['marker'] ?? '',
                    iconRight: $option['iconRight'] ?? '',
                    badge: $option['badge'] ?? '',
                    style: \App\Layout\Components\UI\Core\TabImage\TabImageStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\TabImage\TabImageSize::Medium,
                    attributes: [

                    ]
                ); ?>
            </li>
        <?php endforeach; ?>

        <?php if ($data['link']): ?>
            <li class="collapsible__option">
                <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'collapsible__show-all',
                    text: 'Вся категория',
                    link: $data['link'],
                    icon: 'home',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                ); ?>
            </li>
        <?php endif; ?>
    </ul>
</div>
