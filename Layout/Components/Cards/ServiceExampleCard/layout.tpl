<?php
/** @var array $data */
$list = [
    $data['textRow1'],
    $data['textRow2'],
    $data['textRow3'],
    $data['textRow4'],
    $data['textRow5'],
];
$list = array_filter($list, fn($v) => $v !== '' && $v !== null);
?>

<div class="service-example-card <?= $data['class'] ?>">
    <div class="service-example-card__image">
        <img src="<?= $data['image'] ?>" alt="<?= $data['title'] ?>" loading="lazy">
    </div>

    <div class="service-example-card__text">
        <h3 class="service-example-card__title"><?= $data['title'] ?></h3>

        <div class="service-example-card__list">
            <?php foreach ($list as $item): ?>
                <div class="service-example-card__item">
                    <?php App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'service-example-card__item-marker',
                        icon: 'arrow-right',
                        size: \App\Layout\Components\UI\Core\Marker\MarkerSize::ExtraSmall,
                    ); ?>

                    <p class="service-example-card__item-text"><?= $item ?></p>
                </div>
            <?php endforeach; ?>
        </div>

        <p class="service-example-card__desc"><?= $data['desc'] ?></p>
    </div>
</div>
