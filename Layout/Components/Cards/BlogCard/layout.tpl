<?php
/** @var array $data */
?>

<?php if ($data['link']): ?>
    <div class="blog-card <?= $data['className'] ?>" title="<?= $data['title'] ?>">
        <a class="blog-card__link"
           href="<?= $data['link'] ?>"
           draggable="false"
           aria-label="<?= $data['title'] ?>"
        ></a>
        <div class="blog-card__container">
            <div class="blog-card__wrap">
                <div class="blog-card__badges">
                    <?php
                    if ($data['date']) {
                        App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                            className: 'blog-card__badge-date',
                            text: $data['date'],
                            style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::Secondary,
                            size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                        );
                    }

                    if ($data['category']) {
                        App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                            className: 'blog-card__badge-category',
                            text: $data['category'],
                            style: \App\Layout\Components\UI\Core\Badge\BadgeStyle::Dark,
                            size: \App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                        );
                    }
                    ?>
                </div>

                <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'blog-card__button',
                    text: 'Читать',
                    link: $data['link'],
                    icon: 'arrow-right',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                    iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                    attributes: [
                            'draggable' => 'false'
                    ]
                ); ?>
            </div>

            <img class="blog-card__image"
                 src="<?= $data['image'] ?>"
                 alt="<?= $data['title'] ?>"
                 draggable="false"
                 loading="lazy"
            >
        </div>

        <div class="blog-card__text">
            <h3 class="blog-card__title"><?= $data['title'] ?></h3>
        </div>
    </div>
<?php endif; ?>