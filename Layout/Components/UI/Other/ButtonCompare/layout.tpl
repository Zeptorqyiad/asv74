<?php
/** @var array $data */

if (!$data['productId']) {
    return;
}

$in = \App\Extensions\Catalog\SessionAssist::$compare->inList($data['productId'], $data['variantId'] ?: null);
if ($in) {
    $data['class'] = 'active';
}

$buttonCompareClasses = [
    'compare-button',
    "compare-button--{$data['style']}",
    $data['class'] ?? ''
];

?>

<button class="<?= implode(' ', $buttonCompareClasses) ?> "
        type="button"
    <?= buildAttrs($data['attributes'] ?? []) ?>
        data-product-id="<?= $data['productId'] ?>"
        data-variant-id="<?= $data['variantId'] ?>"
        aria-label="<?= $in ? 'Убрать из сравнения' : 'Добавить в сравнение' ?>"
>
    <?= renderIcon('chart', "compare-button__icon") ?>

    <span class="compare-button__text">В <?= $in ? 'сравнении' : 'сравнение' ?></span>

    <span class="compare-button__loader">
        <?php App\Layout\Components\UI\Other\LoaderIcon\Layout::draw(); ?>
    </span>

    <?php App\Layout\Components\Modals\Tooltip\Layout::drawTooltip(
        class: 'compare-button__tooltip',
        contentText: $in ? 'Убрать из сравнения' : 'Добавить в сравнение',
        icon: false,
        isButton: false,
        position: \App\Layout\Components\Modals\Tooltip\TooltipPos::Left
    ); ?>
</button>