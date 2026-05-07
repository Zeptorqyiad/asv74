<?php
/** @var array $data */
?>

<div class="product-video-section">
    <div class="product-video-section__container wrapper-sm">
        <?php App\Layout\Components\UI\Other\VideoPlayer\Layout::drawVideoPlayer(
            className: 'product-video-section__player',
            src: $data['src']
        ); ?>

        <span class="product-video-section__title"><?= $data['title'] ?></span>
    </div>
</div>