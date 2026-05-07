<?php
/** @var array $data */

?>

<section class="work-process-promo">
    <div class="work-process-promo__container container">
        <h2 class="section-title work-process-promo__title"><?= $data['title'] ?? 'Процесс работы' ?></h2>
        <div class="work-process-promo__list">
            <?php foreach ($data['cards'] as $card) {
                App\Layout\Components\Cards\WorkCard\Layout::drawWorkCard(
                    title: $card['title'] ?? '',
                    desc: $card['desc'] ?? '',
                    image: $card['image'] ?? ''
                );
            } ?>
        </div>
    </div>
</section>