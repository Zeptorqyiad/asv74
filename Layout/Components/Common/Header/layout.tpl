<?php
/** @var array $data */

$compareCount = \App\Extensions\Catalog\SessionAssist::$compare->getProductCount();
?>

    <script>
        const currentCity = <?= json_encode(App\Extensions\GeoIp\GeoIp::getCurrentCity(), JSON_THROW_ON_ERROR) ?>;

        if (typeof localStorage !== 'undefined') {
            try {
                localStorage.setItem('currentCity', currentCity);
            } catch (error) {
                console.error('Error saving city:', error);
            }
        }
    </script>

    <header class="header <?= $data['className'] ?>">
        <div class="header__container">
            <div class="header__top">
                <?php App\Layout\Components\Common\HeaderNav\Layout::draw(); ?>
            </div>

            <div class="header__bottom">
                <div class="header__bottom-container container">

                    <div class="header__bottom-wrap header__bottom-wrap--left <?= $data['title'] ? 'with-title' : '' ?>">
                        <?php
                        App\Layout\Components\UI\Other\LogoButton\Layout::draw([
                            'className' => 'header__logo',
                        ]);

                        App\Layout\Components\UI\Core\Separator\Layout::drawSeparator(
                            className: 'header__separator',
                            orientation: \App\Layout\Components\UI\Core\Separator\SeparatorOrientation::Vertical,
                        );
                        ?>

                        <p class="header__subtitle">Производство и поставка автоспецтехники</p>

                        <div class="header__page-title-wrap">
                            <?php
                            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                                className: 'header__button-back',
                                icon: 'arrow-left',
                                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                                attributes: [
                                    'onclick' => 'event.preventDefault(); history.back();',
                                    'aria-label' => 'Вернуться назад',
                                ]
                            );
                            ?>

                            <p class="header__page-title"><?= $data['title'] ?></p>
                        </div>
                    </div>

                    <div class="header__bottom-wrap header__bottom-wrap--center">
                        <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'header__button-catalog',
                            text: 'Каталог',
                            icon: 'unique-dots',
                        );

                        App\Layout\Components\UI\Other\SearchInput\Layout::draw();
                        ?>
                    </div>

                    <div class="header__bottom-wrap header__bottom-wrap--right">
                        <?php
                        App\Layout\Components\UI\Core\Buttons\ButtonMenu\Layout::drawButtonMenu(
                            className: 'header__button-compare',
                            link: '/compare/',
                            icon: 'chart',
                            badge: $compareCount ?? '',
                            style: \App\Layout\Components\UI\Core\Buttons\ButtonMenu\ButtonMenuStyle::Secondary,
                        );

                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'header__button-callback',
                            text: 'Обратная связь',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                            attributes: [
                                'onclick' => 'modalManager.open("callback-modal"); tracker.track("callback_form_open");',
                            ]
                        );

                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'header__button-search',
                            icon: 'search',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                            attributes: [
                                'onclick' => 'modalManager.open("search-modal");',
                                'aria-label' => 'Поиск',
                            ]
                        );

                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'header__button-menu',
                            icon: 'unique-menu-line',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                            attributes: [
                                'onclick' => 'modalManager.open("menu-modal");',
                                'aria-label' => 'Меню',
                            ]
                        );
                        ?>
                    </div>
                </div>

                <?php App\Layout\Components\Modals\Sheet\Layout::draw(); ?>
            </div>
        </div>
    </header>


    <!-------------------- Modals -------------------->
    <div class="sheet-overlay" id="sheet-overlay" aria-hidden="true"></div>
    <div class="search-overlay" id="search-overlay" aria-hidden="true"></div>
<?php
App\Layout\Components\Modals\GeoModal\Layout::draw();
App\Layout\Components\Modals\CatalogModal\Layout::draw();
App\Layout\Components\Modals\CallbackModal\Layout::draw();
App\Layout\Components\Modals\SpecsModal\Layout::draw();
App\Layout\Components\Modals\MenuModal\Layout::draw();
App\Layout\Components\Modals\SuccessModal\Layout::draw();
App\Layout\Components\Modals\ErrorModal\Layout::draw();
if (isset($data['extra']['prodToCat'])) {
    App\Layout\Components\Modals\ComparisonModal\Layout::draw([
        'cats' => $data['extra']['cats'],
    ]);
}
App\Layout\Components\Modals\SearchModal\Layout::draw();
App\Layout\Components\Modals\ToastManager\Layout::draw();
App\Layout\Components\Modals\NotFoundModal\Layout::draw();

App\Layout\Components\UI\Other\TapBar\Layout::draw([
    'type' => $data['tapBarType'],
    'productMenu' => $data['tapBarMenu']
]);
App\Layout\Components\UI\Other\ButtonScroll\Layout::draw();
App\Layout\Components\UI\Other\SocialsSticky\Layout::draw();

if (!Simflex\Core\Container::getRequest()->cookie('cookieConsent')) {
    App\Layout\Components\Modals\CookieModal\Layout::draw();
}
?>