<?php
/** @var array $data */

?>

<div class="service-card <?= $data['className'] ?>">
    <a class="service-card__link"
       href="<?= $data['link'] ?>"
       draggable="false"
       aria-label="<?= $data['title'] ?>"
    ></a>

    <div class="service-card__left">
        <img src="/uf/images/source/<?= $data['image'] ?>"
             alt="<?= $data['title'] ?>"
             draggable="false"
             loading="lazy"
        >
        <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'service-card__button',
            text: 'Подробнее',
            link: $data['link'] ?? '',
            icon: 'arrow-right',
            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
            iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
        ); ?>
    </div>

    <div class="service-card__right">
        <div class="service-card__wrap">
            <h3 class="service-card__title"><?= $data['title'] ?></h3>
            <p class="service-card__desc"><?= $data['desc'] ?></p>
        </div>
        <?php if ($data['badges']): ?>
            <div class="service-card__badges">
                <?php foreach ($data['badges'] as $badge) {
                    App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                        className: 'service-card__badge',
                        text: $badge['text'],
                        style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::White,
                        size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Small,
                    );
                } ?>
            </div>
        <?php endif; ?>
    </div>
</div>