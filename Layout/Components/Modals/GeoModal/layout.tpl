<?php
$currentCity = App\Extensions\GeoIp\GeoIp::getCurrentCity()
?>

<div id="geo-modal" class="modal geo-modal" role="dialog" aria-modal="true">
    <div class="geo-modal__container">
        <div class="geo-modal__top">
            <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
                className: 'geo-modal__button-close',
                attributes: [
                    'onclick' => 'modalManager.close("geo-modal");',
                ]
            ); ?>
        </div>

        <!-- Entry block -->
        <div class="geo-modal__block geo-modal__block--entry">
            <h5 class="geo-modal__title">
                Ваш город: <span><?= $currentCity ?>?</span>
            </h5>

            <div class="geo-modal__actions">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'geo-modal__button-confirm w-full',
                    text: 'Верно',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                );

                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'geo-modal__button-change w-full',
                    text: 'Другой',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                );
                ?>
            </div>
        </div>

        <!-- Change block -->
        <div class="geo-modal__block geo-modal__block--change hidden">
            <div class="geo-modal__block-body">
                <h5 class="geo-modal__title">
                    Укажите город:
                </h5>

                <div class="geo-modal__dropdown">
                    <?php App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
                        className: 'geo-modal__dropdown-input',
                        size: \App\Layout\Components\UI\Core\TextInput\TextInputSize::Small,
                        icon: 'search',
                        attributes: [
                            'placeholder' => 'Введите город',
                            'name' => 'city',
                            'autocomplete' => 'off',
                        ]
                    ); ?>

                    <div class="geo-modal__dropdown-list-wrap">
                        <ul class="geo-modal__dropdown-list">

                        </ul>
                    </div>
                </div>
            </div>


            <?php
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'geo-modal__button-save w-full',
                text: 'Сохранить',
                loader: true,
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                attributes: [
                    'disabled' => 'true'
                ]
            );
            ?>
        </div>
    </div>
</div>