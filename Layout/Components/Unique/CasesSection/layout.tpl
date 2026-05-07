<?php
/** @var array $data */

?>

<section class="cases-section">
    <div class="cases-section__container container">
        <?php
        foreach ($data['cards'] as $card) {
            \App\Layout\Components\Cards\CaseCard\Layout::drawCaseCard(
                title: $card->title ?? '',
                link: '/cases/' . $card->alias . '/',
                location: $card->location ?? '',
                date: $card->date ?? '',
                image: $card->getFirstImage(),
            );
        }
        ?>
    </div>
</section>