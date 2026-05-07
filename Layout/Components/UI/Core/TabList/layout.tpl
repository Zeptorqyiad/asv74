<?php
/** @var array $data */
?>

<div class="tab-list <?= $data['className'] ?>">
    <?php foreach ($data['tabs'] as $index => $tab): ?>
        <button class="tab-list__tab <?= $tab['className'] ?> <?= $index == 0 ? 'active' : '' ?>"
            <?= buildAttrs($tab['attributes'] ?? []) ?>
                data-index="<?= $index ?>"
        >
            <?= renderIcon($tab['icon']) ?>
            <span><?= $tab['title'] ?></span>
        </button>
    <?php endforeach; ?>
</div>