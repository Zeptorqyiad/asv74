<?php
/** @var array $data */
?>

<section class="advantages-promo" id="advantages-promo">
    <h2 class="section-title advantages-promo__title container"><?= $data['title'] ?></h2>
    <div class="advantages-promo__list wrapper">
        <?php foreach ($data['cards'] as $card): ?>
            <div class="advantages-promo__card">
                <?php
                if ($card['marker']) {
                    App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'advantages-promo__card-marker',
                        icon: $card['marker'],
                    );
                }

                if ($card['icon']) {
                    echo renderIcon($card['icon'], 'advantages-promo__card-icon');
                }

                App\Layout\Components\UI\Core\Separator\Layout::drawSeparator(
                    className: 'advantages-promo__card-separator',
                );
                ?>

                <div class="advantages-promo__card-text">
                    <h3 class="advantages-promo__card-title"><?= $card['title'] ?></h3>
                    <div class="advantages-promo__card-desc"><?= $card['desc'] ?></div>
                </div>
            </div>
        <?php endforeach; ?>
    </div>
</section>