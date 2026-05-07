<?php
/** @var array $data */

?>

<section class="fs-main">
    <div class="fs-main__top container">
        <h1 class="fs-main__title"><?= $data['title'] ?></h1>
        <div class="fs-main__wrap">
            <p class="fs-main__desc"><?= $data['desc'] ?></p>
            <div class="fs-main__buttons">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'fs-main__button-catalog',
                    text: 'В каталог',
                    link: '/categories/',
                    icon: 'unique-dots',
                );

                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'fs-main__button-callback',
                    text: 'Консультация',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    attributes: [
                        'onclick' => 'modalManager.open("callback-modal")',
                    ]
                );
                ?>
            </div>
        </div>
    </div>

    <?php if ($data['slides']): ?>
        <div class="fs-main__carousel">
            <?php App\Layout\Components\Unique\Carousel\Layout::draw([
                'slides' => $data['slides'],
            ]); ?>
        </div>
    <?php endif; ?>
</section>