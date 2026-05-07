<?php
/** @var array $data */

?>

<div class="year-card <?= $data['class'] ?>">
    <span class="year-card__title"><?= $data['title'] ?></span>
    <span class="year-card__title-preview"><?= $data['title'] ?></span>

    <div class="year-card__content">
        <?php
        $rowKeys = ['descRowFirst', 'descRowSecond', 'descRowThird', 'descRowFourth', 'descRowFifth'];

        foreach ($rowKeys as $key):
            if (!empty($data[$key])):
                ?>
                <div class="year-card__row">
                    <?php
                    App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'year-card__row-marker',
                        icon: 'arrow-up-right',
                        size: \App\Layout\Components\UI\Core\Marker\MarkerSize::Small,
                    );
                    ?>
                    <p class="year-card__row-text"><?= $data[$key] ?></p>
                </div>
            <?php
            endif;
        endforeach;
        ?>
    </div>
</div>