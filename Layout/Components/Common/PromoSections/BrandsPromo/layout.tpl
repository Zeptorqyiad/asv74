<?php
/** @var array $data */
?>

<section class="brands-promo">
    <div class="brands-promo__container container">
        <div class="brands-promo__text">
            <h2 class="section-title brands-promo__title"><?= $data['title'] ?></h2>
            <p class="brands-promo__desc"><?= $data['desc'] ?></p>
        </div>
        <div class="brands-promo__list">
            <?php foreach ($data['cards'] as $card) {
                App\Layout\Components\Cards\BrandCard\Layout::drawBrandCard(
                    className: 'brands-promo__card',
                    link: '/catalog/?brand[]=' . $card->brand_id,
                    name: $card->name ?? '',
                    image: $card->photo ? '/uf/images/source/' . $card->photo : '',
                    badge: $card->is_official ?? false,
                );
            } ?>
        </div>
    </div>
</section>