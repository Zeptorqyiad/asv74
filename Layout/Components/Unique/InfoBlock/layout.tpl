<?php
/** @var array $data */
?>

<div class="info-block">
    <?php if ($data['title']): ?>
        <h3 class="info-block__title">
            <?= $data['title'] ?>
        </h3>
    <?php endif; ?>

    <?php if ($data['text']): ?>
        <div class="info-block__text content">
            <?= $data['text'] ?>
        </div>
    <?php endif; ?>
</div>