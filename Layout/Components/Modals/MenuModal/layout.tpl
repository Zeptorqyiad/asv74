<?php
$currentCity = App\Extensions\GeoIp\GeoIp::getCurrentCity();

$compareCount = \App\Extensions\Catalog\SessionAssist::$compare->getProductCount();
?>

<div id="menu-modal" class="modal menu-modal" role="dialog" aria-modal="true">
    <div class="menu-modal__container">
        <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
            className: 'menu-modal__button-close',
            attributes: [
                'onclick' => 'modalManager.close("menu-modal")',
            ]
        ); ?>
        <div class="menu-modal__top">
            <?php App\Layout\Components\UI\Other\LogoButton\Layout::draw(); ?>
        </div>

        <div class="menu-modal__body" data-simplebar>
            <div class="menu-modal__body-wrap">
                <?php
                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'menu-modal__button menu-modal__button-geo ',
                    text: $currentCity,
                    icon: 'marker',
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                    attributes: [
                        'onclick' => 'modalManager.open("geo-modal")',
                    ]
                );

                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'menu-modal__button',
                    text: 'В наличии',
                    link: '/catalog/?stock=1',
                );

                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'menu-modal__button',
                    text: 'Услуги',
                    link: '/services/',
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                );

                App\Layout\Components\UI\Core\Collapsible\Layout::drawCollapsible(
                    text: 'Компания',
                    options: [
                        ['text' => 'О компании', 'link' => '/about/'],
                        ['text' => 'О производстве', 'link' => '/manufacture/'],
                        ['text' => 'Сертификаты и ОТТС', 'link' => '/info/certificates/'],
                        ['text' => 'Отзывы', 'link' => '/info/reviews/'],
                        ['text' => 'Блог', 'link' => '/blog/'],
                        ['text' => '3D-экскурсия', 'link' => '/asv/ASV2022.html'],
                    ]
                );

                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'menu-modal__button',
                    text: 'История поставок',
                    link: '/cases/',
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                );

                App\Layout\Components\UI\Core\Collapsible\Layout::drawCollapsible(
                    text: 'Заказчикам',
                    options: [
                        ['text' => 'Доставка', 'link' => '/info/delivery/'],
                        ['text' => 'Оплата', 'link' => '/info/payment/'],
                        ['text' => 'Лизинг', 'link' => '/info/leasing/'],
                        ['text' => 'Гарантия', 'link' => '/info/guarantee/'],
                        ['text' => 'Частые вопросы', 'link' => '/info/faq/'],
                    ]
                );

                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'menu-modal__button',
                    text: 'Контакты',
                    link: '/info/contacts/',
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                );
                ?>

                <div class="menu-modal__actions">
                    <div class="menu-modal__actions-buttons">
                        <?php
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'menu-modal__button-catalog',
                            text: 'Каталог',
                            link: '/categories/',
                            icon: 'unique-dots',
                        );

                        App\Layout\Components\UI\Core\Buttons\ButtonMenu\Layout::drawButtonMenu(
                            className: 'menu-modal__button-compare',
                            link: '/compare/',
                            icon: 'chart',
                            badge: $compareCount ?? '',
                            style: \App\Layout\Components\UI\Core\Buttons\ButtonMenu\ButtonMenuStyle::Secondary,
                        );

                        App\Layout\Components\UI\Core\Separator\Layout::drawSeparator(
                            className: 'menu-modal__separator',
                        );

                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'menu-modal__button-callback',
                            text: 'Обратная связь',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                            attributes: [
                                'onclick' => 'modalManager.open("callback-modal");',
                            ]
                        );
                        ?>
                    </div>

                    <div class="menu-modal__info">
                        <?php
                        App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                            className: 'menu-modal__info-button',
                            text: '{phone}',
                            link: 'tel:{phone}',
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactSize::Small,
                        );

                        App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                            className: 'menu-modal__info-button',
                            text: '{email}',
                            link: 'mailto:{email}',
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactSize::Small,
                        );

                        App\Layout\Components\UI\Other\SocialsContainer\Layout::draw([
                            'className' => 'menu-modal__socials',
                            'theme' => 'light',
                        ]);
                        ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>