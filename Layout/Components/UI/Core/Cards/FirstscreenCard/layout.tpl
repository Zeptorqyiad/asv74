<?php
/** @var array $data */

?>

<button class="firstscreen-card <?= $data['className'] ?>" <?= buildAttrs($data['attributes'] ?? []) ?>>
    <span class="firstscreen-card__top">
        <?= $data['title'] ?>

        <?= renderIcon('arrow-up-right') ?>
    </span>
    <span class="firstscreen-card__text">
        <?= $data['text'] ?>
    </span>
</button>