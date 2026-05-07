<?php
/** @var array $data */


?>

<section class="privacy-section">
    <div class="privacy-section__container container info-container">
        <h1 class="privacy-section__title"><?= $data['title'] ?></h1>

        <div class="privacy-section__body">
            <?php foreach ($data['blocks'] as $block): ?>
                <div class="privacy-section__block content">
                    <h3 class="privacy-section__block-title"><?= $block['title'] ?></h3>
                    <div class="privacy-section__block-text">
                        <?= $block['text'] ?>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>