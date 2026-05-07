<?php
/** @var array $data */
?>

<section class="services-promo">
    <div class="services-promo__container container">
        <h2 class="section-title services-promo__title"><?= $data['title'] ?></h2>
        <div class="services-promo__list">
            <?php foreach ($data['cards'] as $i) {
                App\Layout\Components\Cards\ServiceCard\Layout::drawServiceCard(
                    className: 'services-promo__card',
                    link: '/services/' . $i->alias . '/',
                    title: $i->title ?? '',
                    image: $i->fs_photo ?? '',
                    badges: $i->getBadges() ?? [],
                );
            } ?>
        </div>
    </div>
</section>
