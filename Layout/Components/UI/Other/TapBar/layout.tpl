<?php
/** @var array $data */

?>

<?php if ($data['type'] === 'product' && $data['productMenu']): ?>
    <div class="tap-bar tap-bar--product <?= $data['className'] ?>">
        <div class="tap-bar__container">
            <?php
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'tap-bar__button--prod-catalog',
                text: 'Каталог',
                icon: 'unique-dots',
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                theme: \App\Layout\Components\UI\Core\Buttons\Button\ButtonTheme::Dark,
                attributes: [
                    'onclick' => 'modalManager.open("catalog-modal");',
                ]
            );

            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'tap-bar__button--feedback',
                text: 'Оставить заявку',
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                attributes: [
                    'onclick' => 'modalManager.open("callback-modal"); tracker.track("callback_form_open");',
                ]
            );

            foreach ($data['productMenu'] as $key => $link):
                App\Layout\Components\UI\Core\DropdownTab\Layout::drawDropdownTab(
                    className: 'tap-bar__button--anchor',
                    text: $link['title'],
                    link: '#'. $key .'-section',
                    pointerPos: 'left',
                    style: \App\Layout\Components\UI\Core\DropdownTab\DropdownTabStyle::Primary,
                    size: \App\Layout\Components\UI\Core\DropdownTab\DropdownTabSize::Small,
                    theme: \App\Layout\Components\UI\Core\DropdownTab\DropdownTabTheme::Dark,
                );
            endforeach; ?>
        </div>
    </div>
<?php else: ?>
    <div class="tap-bar <?= $data['className'] ?>">
        <div class="tap-bar__container">
            <?php
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'tap-bar__button tap-bar__button--catalog',
                text: 'Каталог',
                icon: 'unique-dots',
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                attributes: [
                    'onclick' => 'modalManager.open("catalog-modal");',
                ]
            );

            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'tap-bar__button tap-bar__button--feedback',
                text: 'Обратная связь',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                attributes: [
                    'onclick' => 'modalManager.open("callback-modal"); tracker.track("callback_form_open");',
                ]
            ); ?>
        </div>
    </div>
<?php endif; ?>
