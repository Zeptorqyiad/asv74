<?php
/** @var array $data */

?>

<section class="service-slider <?= $data['className'] ?>">
    <?php if ($data['title']): ?>
        <h2 class="section-title service-slider__title">
            <?= $data['title'] ?>
        </h2>
    <?php endif; ?>

    <div class="service-slider__buttons">
        <?php if ($data['link']) {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'service-slider__button-link',
                text: 'Показать все',
                link: $data['link'],
                style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
            );
        }
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'service-slider__button-prev',
            icon: 'arrow-left',
            style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        );
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'service-slider__button-next',
            icon: 'arrow-right',
            style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        ); ?>
    </div>

    <div class="service-slider__slider-wrap">
        <div class="service-slider__slider">
            <div class="swiper-wrapper">
                <?php foreach ($data['cards'] as $i) {
                    App\Layout\Components\Cards\ServiceCard\Layout::drawServiceCard(
                        className: 'service-section__card swiper-slide',
                        link: '/services/'.$i->alias.'/' ?? '',
                        title: $i->title ?? '',
                        desc: $i->fs_desciption ?? '',
                        image: $i->fs_photo ?? '',
                        badges: $i->getBadges() ?? [],
                    );
                } ?>
            </div>
        </div>
    </div>
</section>
