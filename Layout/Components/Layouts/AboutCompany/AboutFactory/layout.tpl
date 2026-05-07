<?php
/** @var array $data */

?>

<section class="about-factory">
    <div class="about-factory__top container">
        <h2 class="section-title about-factory__title"><?= $data['title'] ?></h2>

        <div class="about-factory__controls">
            <?php
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'about-factory__button-prev',
                icon: 'arrow-left',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            );
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'about-factory__button-next',
                icon: 'arrow-right',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            );
            ?>
        </div>
    </div>

    <div class="about-factory__body">
        <div class="about-factory__body-wrap">
            <div class="about-factory__info">
                <p class="about-factory__info-desc"><?= $data['desc'] ?></p>
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    text: 'Подробнее',
                    link: '/manufacture/',
                    icon: 'arrow-up-right',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                    iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                );
                ?>
            </div>

            <div class="about-factory__slider">
                <div class="swiper-wrapper">
                    <?php foreach ($data['cards'] as $index => $card): ?>
                        <div class="about-factory__card swiper-slide">
                            <?php if ($card['img']): ?>
                                <img src="<?= $card['img'] ?>"
                                     class="about-factory__card-image"
                                     alt="Изображение <?= $index ?>"
                                     loading="lazy"
                                     draggable="false"
                                >
                            <?php endif; ?>

                            <?php if (!$card['img']): ?>
                                <div class="about-factory__card-text">
                                    <span class="about-factory__card-count"><?= $card['count'] ?></span>
                                    <p class="about-factory__card-desc"><?= $card['desc'] ?></p>
                                </div>
                            <?php endif; ?>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>
    </div>
</section>