<?php
/** @var array $data */

?>

<section class="promo-slider">
    <div class="promo-slider__slider-wrap">
        <div class="promo-slider__slider swiper">
            <div class="swiper-wrapper">
                <!--    ПК версия     -->
                <?php foreach ($data['promoHD'] as $i): ?>
                    <a class="promo-slider__image swiper-slide" href="<?= $i['link'] ?>" data-link="<?= $i['link'] ?>">
                        <img src="<?= $i['img'] ?>" alt="">
                    </a>
                <?php endforeach; ?>

                <!--    Моб.версия     -->
                <?php foreach ($data['promoMob'] as $i): ?>
                    <a class="promo-slider__image--mob swiper-slide" href="<?= $i['link'] ?>" data-link="<?= $i['link'] ?>">
                        <img src="<?= $i['img'] ?>" alt="">
                    </a>
                <?php endforeach; ?>
            </div>
        </div>
    </div>

    <div class="promo-slider__buttons">
        <?php
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'promo-slider__button-link',
                text: 'Подробнее',
                link: '#',
                icon: 'arrow-up-right',
                style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                iconPos: App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
            );
        ?>
        <div class="promo-slider__btn">
            <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'promo-slider__button-prev',
                    icon: 'arrow-left',
                    style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
                );
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'promo-slider__button-next',
                    icon: 'arrow-right',
                    style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
                );
            ?>
        </div>
    </div>
</section>
