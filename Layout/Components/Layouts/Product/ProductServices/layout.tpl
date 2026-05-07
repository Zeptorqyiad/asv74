<?php
/** @var array $data */
?>

<section class="product-services">
    <div class="product-services__container container">
        <h2 class="product-services__title"><?= $data['title'] ?></h2>
        <div class="product-services__list">
            <?php foreach ($data['cards'] as $card) {
                \App\Layout\Components\Cards\AddServiceCard\Layout::drawAddServiceCard(
                    className: 'product-services__card',
                    link: $card['link'] ?? '',
                    title: $card['title'] ?? '',
                    desc: $card['desc'] ?? '',
                    image: $card['image'] ?? '',
                    badges: $card['badges'] ?? [],
                );
            } ?>
        </div>
    </div>
</section>