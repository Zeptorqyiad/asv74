<?php
/** @var array $data */
?>

<section class="services-section">
    <div class="services-section__container container">
        <?php
        foreach ($data['cards'] as $card) {
            App\Layout\Components\Cards\ServiceCard\Layout::drawServiceCard(
                className: 'services-section__card',
                link: $card->alias . '/',
                title: $card->title ?? '',
                desc: $card->fs_desciption ?? '',
                image: $card->fs_photo ?? '',
                badges: $card->getBadges() ?? [],
            );
        }
        ?>
    </div>
</section>