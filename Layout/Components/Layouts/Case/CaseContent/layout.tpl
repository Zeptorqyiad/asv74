<?php
/** @var array $data */
?>

<section class="case-content container <?= $data['class'] ?>">
    <div class="case-content__container info-container">
        <div class="case-content__badges">
            <?php
            if ($data['location']) {
                App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                    className: 'case-content__badge case-content__location',
                    text: $data['location'],
                    style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                );
            }

            if ($data['date']) {
                App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                    className: 'case-content__badge case-content__date',
                    text: $data['date'],
                    style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                );
            }
            ?>
        </div>

        <div class="case-content__content content">
            <?= $data['content'] ?>
        </div>

        <?php if ($data['link']): ?>
            <div class="case-content__actions">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    text: 'Посмотреть в каталоге',
                    link: $data['link'],
                    icon: 'arrow-up-right',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                    iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                );
                ?>
            </div>
        <?php endif; ?>
    </div>
</section>