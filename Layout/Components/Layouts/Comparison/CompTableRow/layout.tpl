<?php
/** @var array $data */

?>

<div class="comp-table-row">
    <div class="comp-table-row__title">
        <?= $data['title'] ?>
    </div>

    <div class="comp-table-row__content swiper-wrapper">
        <?php foreach ($data['columns'] as $col): ?>
            <span class="comp-table-row__column swiper-slide"><?= $col['text'] ?></span>
        <?php endforeach; ?>
    </div>
</div>