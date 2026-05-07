<?php
/** @var array $data */

$buttonCloseClasses = [
    'btn-close',
    $data['className'] ?? ''
];
?>

<button type="<?= $data['attributes']['type'] ?? 'button' ?>"
        class="<?= implode(' ', $buttonCloseClasses) ?>" <?= buildAttrs($data['attributes'] ?? []) ?>
        aria-label="Закрыть"
>
    <?php if ($data['text']): ?>
        <span class="btn-close__text"><?= $data['text'] ?></span>
    <?php endif; ?>
    <?= renderIcon($data['icon'], 'btn-close__icon') ?>
</button>