<?php
/** @var array $data */
?>

<div class="case-card <?= $data['className'] ?>">
    <a class="case-card__link"
       href="<?= $data['link'] ?>"
       draggable="false"
       aria-label="<?= $data['title'] ?>"
    ></a>

    <div class="case-card__media">
        <div class="case-card__badges">
            <?php if ($data['date']): ?>
                <span class="case-card__date"><?= $data['date'] ?></span>
            <?php endif; ?>
        </div>

        <?php
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'case-card__button',
            text: 'Подробнее',
            link: $data['link'],
            icon: 'arrow-right',
            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
            iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
        );
        ?>


        <img class="case-card__image"
             src="<?= $data['image'] ?>"
             alt="<?= $data['title'] ?>"
             draggable="false"
             loading="lazy"
        >
    </div>

    <div class="case-card__text">
        <h5 class="case-card__title"><?= $data['title'] ?></h5>
        <p class="case-card__desc"><?= $data['location'] ?></p>
    </div>
</div>