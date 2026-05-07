<?php
/** @var array $data */

?>

<div class="department-card <?= $data['class'] ?>">
    <h3 class="department-card__title"><?= $data['title'] ?></h3>

    <ul class="department-card__list">
        <?php foreach ($data['list'] as $item): ?>
            <li class="department-card__item">
                <?php
                App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                    className: 'department-card__item-marker',
                    icon: 'arrow-up-right',
                    size: \App\Layout\Components\UI\Core\Marker\MarkerSize::ExtraSmall,
                );
                ?>

                <p class="department-card__item-text"><?= $item['text'] ?></p>
            </li>
        <?php endforeach; ?>
    </ul>
</div>