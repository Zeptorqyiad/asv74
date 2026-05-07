<?php
/** @var array $data */
?>

<section class="reviews-section">
    <div class="reviews-section__container container">
        <?php foreach ($data['cards'] as $card) {
            App\Layout\Components\Cards\ReviewCard\Layout::drawReviewCard(
                className: 'review-section__card',
                type: $card->getCategoryType(),
                badgeText: $card->getCategoryName(),
                title: $card->title ?? '',
                file: $card->file ?? '',
            );
        }
        ?>
    </div>
</section>