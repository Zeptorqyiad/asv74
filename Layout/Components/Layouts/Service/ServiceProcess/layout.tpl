<?php
/** @var array $data */
?>

<section class="service-process <?= $data['class'] ?>" id="service-process">
    <div class="service-process__container container">
        <h2 class="section-title service-process__title"><?= $data['title'] ?></h2>

        <div class="service-process__steps">
            <?php foreach ($data['steps'] as $step): ?>
                <div class="service-process__step">
                    <?php
                    App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                        className: 'service-process__step-badge',
                        text: $step['badge'],
                        style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::Gray,
                        size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                    );
                    ?>

                    <h3 class="service-process__step-title"><?= $step['title'] ?></h3>
                    <p class="service-process__step-desc"><?= $step['desc'] ?></p>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
</section>