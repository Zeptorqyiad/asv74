<?php
/** @var array $data */
?>

<div class="video-review-card <?= $data['className'] ?>">
    <?php App\Layout\Components\UI\Other\VideoPlayer\Layout::drawVideoPlayer(
        className: 'video-review-card__player',
        link: $data['link'],
        src: $data['src'],
        poster: $data['poster'],
    ); ?>
    <p class="video-review-card__title"><?= $data['title'] ?></p>
</div>