<?php
/** @var array $data */


?>

<section class="leasing-section">
    <div class="leasing-section__container container">
        <?php App\Layout\Components\Common\AsideMenu\Layout::drawAsideMenu(); ?>

        <div class="leasing-section__body info-container">
            <?php foreach ($data['blocks'] as $b) {
                App\Layout\Components\Unique\InfoBlock\Layout::drawInfoBlock(
                    title: $b['title'] ?? '',
                    text: $b['text'] ?? ''
                );
            } ?>

            <div class="leasing-section__cards">
                <?php foreach ($data['cards'] as $card): ?>
                    <div class="leasing-section__card">
                        <?= renderIcon($card['icon']) ?>
                        <p>
                            <?= $card['text'] ?>
                        </p>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</section>