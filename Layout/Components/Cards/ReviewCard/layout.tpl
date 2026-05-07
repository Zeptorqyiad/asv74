<?php
/** @var array $data */
?>

<div class="review-card <?= $data['className'] ?>"
    <?= buildAttrs($data['attributes'] ?? []) ?>
     title="<?= $data['title'] ?>"
     data-type="<?= $data['type'] ?>"
>

    <?php
    App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
        className: 'review-card__badge',
        text: $data['badgeText'],
        style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::Gray,
        size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
    );
    ?>

    <div class="review-card__media">
        <?php if ($data['type'] == 'photo_v'): ?>
            <img class="review-card__photo review-card__photo--vertical"
                 src="<?= '/uf/files/' . $data['file'] ?>"
                 alt="<?= $data['title'] ?>"
                 draggable="false"
                 loading="lazy"
                 data-fancybox="review-photos"
                 data-caption="<?= $data['title'] ?>"
            >
        <?php endif; ?>

        <?php if ($data['type'] == 'photo_h'): ?>
            <img class="review-card__photo review-card__photo--horizontal"
                 src="<?= '/uf/files/' . $data['file'] ?>"
                 alt="<?= $data['title'] ?>"
                 draggable="false"
                 loading="lazy"
                 data-fancybox="review-photos"
                 data-caption="<?= $data['title'] ?>"
            >
        <?php endif; ?>

        <?php if ($data['type'] == 'document'): ?>
            <img class="review-card__photo review-card__photo--certificate"
                 src="<?= '/uf/files/' . $data['file'] ?>"
                 alt="<?= $data['title'] ?>"
                 draggable="false"
                 loading="lazy"
                 data-fancybox="review-photos"
                 data-caption="<?= $data['title'] ?>"
            >
        <?php endif; ?>

        <?php if ($data['type'] == 'video') {
            App\Layout\Components\UI\Other\VideoPlayer\Layout::drawVideoPlayer(
                className: 'review-card__video',
                src: '/uf/files/' . $data['file'],
            );
        } ?>
    </div>

    <?php if ($data['title']): ?>
        <h4 class="review-card__title"><?= $data['title'] ?></h4>
    <?php endif; ?>
</div>