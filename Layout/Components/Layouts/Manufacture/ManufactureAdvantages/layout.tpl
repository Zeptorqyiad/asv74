<?php
/** @var array $data */

?>

<section class="manufacture-advantages" id="advantages-manufacture">
    <div class="manufacture-advantages__container container">
        <h2 class="section-title manufacture-advantages__title"><?= $data['title'] ?></h2>

        <div class="manufacture-advantages__image">
            <img src="<?= $data['image'] ?>"
                 alt=""
                 aria-hidden="true"
                 loading="lazy"
                 draggable="false"
            >
        </div>

        <div class="manufacture-advantages__list">
            <?php foreach ($data['cards'] as $card): ?>
                <div class="manufacture-advantages__card">
                    <div class="manufacture-advantages__card-icon">
                        <img src="<?= $card['icon'] ? '/uf/files/' . $card['icon'] : '/assets/images/placeholders/fallback-icon.svg' ?>"
                             alt=""
                             aria-hidden="true"
                             draggable="false"
                             loading="lazy"
                        >
                    </div>

                    <div class="manufacture-advantages__card-text">
                        <h3 class="manufacture-advantages__card-title"><?= $card['title'] ?></h3>
                        <p class="manufacture-advantages__card-desc"><?= $card['desc'] ?></p>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>