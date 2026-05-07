<?php
/** @var array $data */
?>

<div class="add-service-card <?= $data['className'] ?>">
    <a class="add-service-card__link" href="<?= $data['link'] ?>" draggable="false"></a>

    <div class="add-service-card__left">
        <img src="<?= $data['image'] ?>"
             alt="<?= $data['title'] ?>"
             draggable="false"
             loading="lazy"
        >
        <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'add-service-card__button',
            text: 'Подробнее',
            link: $data['link'] ?? '',
            icon: 'arrow-right',
            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
            iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
        ); ?>
    </div>

    <div class="add-service-card__right">
        <div class="add-service-card__wrap">
            <h5 class="add-service-card__title"><?= $data['title'] ?></h5>
            <p class="add-service-card__desc"><?= $data['desc'] ?></p>
        </div>
        <?php if ($data['badges']): ?>
            <div class="add-service-card__badges">
                <?php foreach ($data['badges'] as $badge) {
                    App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                        className: 'add-service-card__badge',
                        text: $badge['text'],
                        style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::White,
                        size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Small,
                    );
                } ?>
            </div>
        <?php endif; ?>
        <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'add-service-card__button-more',
            text: 'Подробнее',
            link: $data['link'] ?? '',
            icon: 'arrow-right',
            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::ExtraSmall,
            iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
        ); ?>
    </div>
</div>