<?php
/** @var array $data */

$email = Simflex\Core\Core::siteParam('email');
$phone = Simflex\Core\Core::siteParam('phone');

$currentCity = App\Extensions\GeoIp\GeoIp::getCurrentCity();
?>

<div class="header-nav <?= $data['cn'] ?>">
    <div class="header-nav__container container">
        <div class="header-nav__wrap">
            <?php App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                className: 'header-nav__button-geo',
                text: $currentCity,
                icon: 'marker',
                style: \App\Layout\Components\UI\Core\Tab\TabStyle::Flat,
                size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                theme: \App\Layout\Components\UI\Core\Tab\TabTheme::Dark,
                attributes: [
                    'onclick' => 'modalManager.open("geo-modal")'
                ]
            ); ?>

            <nav class="header-nav__nav-list">
                <?php App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'header-nav__link',
                    text: 'В наличии',
                    link: '/catalog/?stock=1',
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Primary,
                    size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                    theme: \App\Layout\Components\UI\Core\Tab\TabTheme::Dark,
                );

                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'header-nav__link',
                    text: 'Услуги',
                    link: '/services/',
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                    theme: \App\Layout\Components\UI\Core\Tab\TabTheme::Dark,

                );

                App\Layout\Components\UI\Core\DropdownTab\Layout::drawDropdownTab(
                    className: 'header-nav__dropdown',
                    text: 'Компания',
                    pointerPos: 'left',
                    style: \App\Layout\Components\UI\Core\DropdownTab\DropdownTabStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\DropdownTab\DropdownTabSize::Small,
                    theme: \App\Layout\Components\UI\Core\DropdownTab\DropdownTabTheme::Dark,
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
                    className: 'header-nav__link',
                    text: 'История поставок',
                    link: '/cases/',
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                    theme: \App\Layout\Components\UI\Core\Tab\TabTheme::Dark,
                );

                App\Layout\Components\UI\Core\DropdownTab\Layout::drawDropdownTab(
                    className: 'header-nav__dropdown',
                    text: 'Заказчикам',
                    pointerPos: 'left',
                    style: \App\Layout\Components\UI\Core\DropdownTab\DropdownTabStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\DropdownTab\DropdownTabSize::Small,
                    theme: \App\Layout\Components\UI\Core\DropdownTab\DropdownTabTheme::Dark,
                    options: [
                        ['text' => 'Доставка', 'link' => '/info/delivery/'],
                        ['text' => 'Оплата', 'link' => '/info/payment/'],
                        ['text' => 'Гарантии', 'link' => '/info/guarantee/'],
                        ['text' => 'Лизинг', 'link' => '/info/leasing/'],
                        ['text' => 'Частые вопросы', 'link' => '/info/faq/'],
                    ]
                );

                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'header-nav__link',
                    text: 'Контакты',
                    link: '/info/contacts/',
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                    theme: \App\Layout\Components\UI\Core\Tab\TabTheme::Dark,
                );
                ?>
            </nav>
        </div>

        <div class="header-nav__contacts">
            <?php
            if ($phone) {
                App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                    className: 'header-nav__button-contact',
                    text: '{phone}',
                    link: '{phone}',
                    style: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactStyle::Monochrome,
                    size: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactSize::ExtraSmall,
                    theme: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactTheme::Dark,
                    type: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactType::Tel,
                );
            }

            if ($email) {
                App\Layout\Components\UI\Core\Separator\Layout::drawSeparator(
                    className: 'header-nav__separator',
                    orientation: \App\Layout\Components\UI\Core\Separator\SeparatorOrientation::Vertical,
                    theme: \App\Layout\Components\UI\Core\Separator\SeparatorTheme::Dark,
                );

                App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                    className: 'header-nav__button-contact',
                    text: '{email}',
                    link: '{email}',
                    style: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactStyle::Monochrome,
                    size: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactSize::ExtraSmall,
                    theme: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactTheme::Dark,
                    type: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactType::Mail,
                );
            }
            ?>
        </div>
    </div>
</div>