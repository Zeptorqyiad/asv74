<?php
/** @var array $data */

?>

<section class="manufacture-gallery">
    <div class="manufacture-gallery__container container">
        <h2 class="section-title manufacture-gallery__title"><?= $data['title'] ?></h2>

        <div class="manufacture-gallery__grid">
            <?php foreach ($data['cards'] as $card): ?>
                <div class="manufacture-gallery__card">
                    <img src="<?= $card['image'] ?>"
                         alt="<?= $card['title'] ?>"
                         loading="lazy"
                         data-fancybox="manufacture-gallery"
                         data-caption="<?= $card['title'] ?>"
                    >

                    <?php if ($card['title']): ?>
                        <span><?= $card['title'] ?></span>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>