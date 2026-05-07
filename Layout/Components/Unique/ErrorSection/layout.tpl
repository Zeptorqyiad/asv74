<?php
/** @var array $data */
?>

<section class="error-section <?= $data['className'] ?>">
    <div class="error-section__container container">
        <?php if ($data['errorText']): ?>
            <h1 class="error-section__error-text"><?= $data['errorText'] ?></h1>
        <?php endif; ?>
        <?php if ($data['icon']) {
           echo renderIcon($data['icon'], 'error-section__icon');
        } ?>
        <p class="error-section__title"><?= $data['title'] ?? 'Произошла ошибка' ?></p>
        <p class="error-section__desc">
            <?= $data['description'] ?>
        </p>
        <div class="error-section__buttons">
            <?php
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'error-section__button-home',
                text: 'На главную',
                link: '/',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
            );

            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'error-section__button-catalog',
                text: 'В каталог',
                link: '/categories/',
                icon: 'unique-dots',
            );
            ?>
        </div>
    </div>
</section>