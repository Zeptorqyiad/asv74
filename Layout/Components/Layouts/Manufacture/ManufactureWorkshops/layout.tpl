<?php
/** @var array $data */

?>

<section class="manufacture-workshops">
    <div class="manufacture-workshops__container container">
        <div class="manufacture-workshops__top">
            <h2 class="section-title manufacture-workshops__title"><?= $data['title'] ?></h2>
            <p class="manufacture-workshops__desc"><?= $data['desc'] ?></p>
        </div>

        <div class="manufacture-workshops__list">
            <?php foreach ($data['cards'] as $card): ?>
                <div class="manufacture-workshops__card">
                    <div class="manufacture-workshops__card-left">
                        <?= renderIcon('dot-xl', 'manufacture-workshops__card-dot') ?>

                        <div class="manufacture-workshops__card-text">
                            <h3 class="manufacture-workshops__card-title"><?= $card['title'] ?></h3>
                            <p class="manufacture-workshops__card-desc"><?= $card['desc'] ?></p>
                        </div>
                    </div>

                    <div class="manufacture-workshops__card-right">
                        <img src="<?= $card['image'] ?>"
                             alt="<?= $card['title'] ?>"
                             loading="lazy"
                             data-fancybox="manufacture-workshops"
                             data-caption="<?= $card['title'] ?>"
                        >
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>