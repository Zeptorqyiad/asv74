<?php
/** @var array $data */

?>

<section class="manufacture-fs">
    <div class="manufacture-fs__container container">
        <div class="manufacture-fs__top">
            <h1 class="manufacture-fs__title"><?= $data['title'] ?></h1>
            <div class="manufacture-fs__text">
                <p class="manufacture-fs__desc"><?= $data['desc'] ?></p>
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    text: 'Узнать подробнее',
                    link: '#advantages-manufacture',
                    icon: 'arrow-down',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                );
                ?>
            </div>
        </div>

        <div class="manufacture-fs__image-container">

            <img class="manufacture-fs__image"
                 src="<?= $data['image'] ?>"
                 alt="<?= $data['title'] ?>"
                 draggable="false"
                 loading="lazy"
            >

            <a class="manufacture-fs__info-link" href="/asv/ASV2022.html">
                <?= renderIcon('unique-cube-outline') ?>
                <span>3D экскурсия</span>
            </a>
        </div>
    </div>
</section>