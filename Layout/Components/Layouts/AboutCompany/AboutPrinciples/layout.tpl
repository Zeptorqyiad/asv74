<?php
/** @var array $data */

?>

<section class="about-principles">
    <div class="about-principles__container container">
        <h2 class="section-title about-principles__title"><?= $data['title'] ?></h2>

        <div class="about-principles__grid">

            <div class="about-principles__card large">
                <img class="about-principles__card-image" src="<?= $data['card_img_1'] ?>" alt="" loading="lazy" draggable="false" aria-hidden="true">

                <div class="about-principles__card-content">
                    <?php
                    App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'about-principles__card-marker',
                        icon: 'unique-chip',
                    );
                    ?>

                    <div class="about-principles__card-text">
                        <h3 class="about-principles__card-title"><?= $data['card_title_1'] ?></h3>
                        <p class="about-principles__card-desc"><?= $data['card_desc_1'] ?></p>
                    </div>
                </div>
            </div>

            <div class="about-principles__card wide">
                <div class="about-principles__card-content">
                    <?php
                    App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'about-principles__card-marker',
                        icon: 'unique-certificate',
                    );
                    ?>

                    <div class="about-principles__card-text">
                        <h3 class="about-principles__card-title"><?= $data['card_title_2'] ?></h3>
                        <p class="about-principles__card-desc"><?= $data['card_desc_2'] ?></p>
                    </div>
                </div>
            </div>

            <div class="about-principles__card small">
                <div class="about-principles__card-content">
                    <?php
                    App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'about-principles__card-marker',
                        icon: 'unique-flow',
                    );
                    ?>

                    <div class="about-principles__card-text">
                        <h3 class="about-principles__card-title"><?= $data['card_title_3'] ?></h3>
                        <p class="about-principles__card-desc"><?= $data['card_desc_3'] ?></p>
                    </div>
                </div>
            </div>

            <div class="about-principles__card small-img">
                <img class="about-principles__card-image" src="<?= $data['card_img_4'] ?>" alt="" loading="lazy" draggable="false" aria-hidden="true">

                <div class="about-principles__card-content">
                    <?php
                    App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'about-principles__card-marker',
                        icon: 'unique-microscope',
                    );
                    ?>

                    <div class="about-principles__card-text">
                        <h3 class="about-principles__card-title"><?= $data['card_title_4'] ?></h3>
                        <p class="about-principles__card-desc"><?= $data['card_desc_4'] ?></p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>