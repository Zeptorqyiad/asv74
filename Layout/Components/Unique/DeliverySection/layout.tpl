<?php
/** @var array $data */


?>

<section class="delivery-section">
    <div class="delivery-section__container container">
        <?php App\Layout\Components\Common\AsideMenu\Layout::drawAsideMenu(); ?>

        <div class="delivery-section__body info-container">
            <?php foreach ($data['blocks'] as $b) {
                App\Layout\Components\Unique\InfoBlock\Layout::drawInfoBlock(
                    title: $b['title'] ?? '',
                    text: $b['text'] ?? ''
                );
            } ?>
        </div>
    </div>
</section>