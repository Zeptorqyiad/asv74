<?php
/** @var array $data */

?>

<section class="about-fs">
    <div class="about-fs__container container">
        <div class="about-fs__top">
            <h1 class="about-fs__title"><?= $data['title'] ?></h1>
            <div class="about-fs__text">
                <p class="about-fs__desc"><?= $data['desc'] ?></p>
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    text: 'Узнать подробнее',
                    link: '#advantages-promo',
                    icon: 'arrow-down',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                );
                ?>
            </div>
        </div>

        <div class="about-fs__image-container">

            <img class="about-fs__image"
                 src="<?= $data['image'] ?>"
                 alt="<?= $data['title'] ?>"
                 draggable="false"
                 loading="lazy"
            >

            <a class="about-fs__info-link" href="/asv/ASV2022.html">
                <?= renderIcon('unique-cube-outline') ?>
                <span>3D экскурсия</span>
            </a>
        </div>

        <?php if ($data['cards']): ?>
            <div class="about-fs__info-list">
                <?php foreach ($data['cards'] as $card): ?>
                    <div class="about-fs__info-card">
                        <h3 class="about-fs__info-card-title"><?= $card['title'] ?></h3>
                        <?php App\Layout\Components\UI\Core\Separator\Layout::drawSeparator(
                            className: 'about-fs__info-card-separator',
                        ); ?>
                        <p class="about-fs__info-card-desc"><?= $card['desc'] ?></p>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
</section>