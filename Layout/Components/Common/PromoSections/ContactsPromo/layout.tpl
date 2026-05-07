<?php
/** @var array $data */

$vk = Simflex\Core\Core::siteParam('vk');
$tg = Simflex\Core\Core::siteParam('tg');
//$wt = Simflex\Core\Core::siteParam('whats_app');
$max_social = Simflex\Core\Core::siteParam('max_social');
$ya = Simflex\Core\Core::siteParam('ya');
$go = Simflex\Core\Core::siteParam('go');
$in = Simflex\Core\Core::siteParam('inst');
$rt = Simflex\Core\Core::siteParam('rt');
$yt = Simflex\Core\Core::siteParam('yt');
?>

<section class="contacts-promo" id="contacts-promo">
    <div class="contacts-promo__container container">
        <div class="contacts-promo__info">
            <h3 class="contacts-promo__info-title">Контакты:</h3>
            <div class="contacts-promo__info-wrap">
                <div class="contacts-promo__info-row">
                    <?php
                    App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'contacts-promo__info-marker',
                        icon: 'phone',
                        size: \App\Layout\Components\UI\Core\Marker\MarkerSize::Small
                    );

                    App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                        className: 'contacts-promo__info-button',
                        text: '{phone}',
                        link: 'tel:{phone}',
                        style: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactStyle::Monochrome,
                        size: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactSize::Small,
                    );
                    ?>
                </div>

                <div class="contacts-promo__info-row">
                    <?php
                    App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'contacts-promo__info-marker',
                        icon: 'mail',
                        size: \App\Layout\Components\UI\Core\Marker\MarkerSize::Small,
                    );

                    App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                        className: 'contacts-promo__info-button',
                        text: '{email}',
                        link: 'mailto:{email}',
                        style: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactStyle::Monochrome,
                        size: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactSize::Small,
                    );
                    ?>
                </div>

                <div class="contacts-promo__info-row">
                    <?php App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'contacts-promo__info-marker',
                        icon: 'marker',
                        size: \App\Layout\Components\UI\Core\Marker\MarkerSize::Small
                    ); ?>
                    <span class="contacts-promo__info-text">{address}</span>
                </div>

                <div class="contacts-promo__info-row">
                    <?php App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                        className: 'contacts-promo__info-marker',
                        icon: 'clock',
                        size: \App\Layout\Components\UI\Core\Marker\MarkerSize::Small
                    ); ?>
                    <span class="contacts-promo__info-text">{workhours}</span>
                </div>

                <div class="contacts-promo__info-row contacts-promo__info-row--social">
                    <?php

                    if ($vk) {
                        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                            link: $vk,
                            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Vkontakte,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,

                        );
                    }

                    if ($tg) {
                        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                            link: $tg,
                            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Telegram,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,

                        );
                    }

                    if ($max_social) {
                        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                            link: $max_social,
                            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Max,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,

                        );
                    }

                    if ($ya) {
                        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                            link: $ya,
                            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Yandex,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,

                        );
                    }

                    if ($go) {
                        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                            link: $go,
                            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Google,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
                        );
                    }

                    if ($in) {
                        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                            link: $in,
                            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Instagram,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,

                        );
                    }

                    if ($rt) {
                        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                            link: $rt,
                            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::RuTube,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,

                        );
                    }

                    if ($yt) {
                        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                            link: $yt,
                            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::YouTube,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,

                        );
                    }

                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'contacts-promo__button-callback',
                        text: 'Оставить заявку',
                        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                        size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                        attributes: [
                            'onclick' => 'modalManager.open("callback-modal")',
                        ]
                    );
                    ?>
                </div>
            </div>
        </div>

        <a href="/info/faq/" class="contacts-promo__card contacts-promo__card--faq">
            <div class="contacts-promo__card-wrap">
                <h4 class="contacts-promo__card-title">Частые вопросы</h4>
                <p class="contacts-promo__card-desc">Ответили на самые популярные вопросы</p>
            </div>
            <img class="contacts-promo__card-image" src="/assets/images/info/info-faq.webp" alt="Частые вопросы" draggable="false" loading="lazy">
        </a>

        <a href="/info/delivery/" class="contacts-promo__card contacts-promo__card--delivery">
            <div class="contacts-promo__card-wrap">
                <h4 class="contacts-promo__card-title">Доставка и оплата</h4>
                <p class="contacts-promo__card-desc">Как оплатить и получить технику</p>
            </div>
            <img class="contacts-promo__card-image" src="/assets/images/info/info-delivery.webp" alt="Доставка и оплата" draggable="false" loading="lazy">
        </a>

        <a href="/info/guarantee/" class="contacts-promo__card contacts-promo__card--guarantee">
            <div class="contacts-promo__card-wrap">
                <h4 class="contacts-promo__card-title">О гарантии</h4>
                <p class="contacts-promo__card-desc">Все про условия гарантии</p>
            </div>
            <img class="contacts-promo__card-image" src="/assets/images/info/info-guarantee.webp" alt="О гарантии" draggable="false" loading="lazy">
        </a>

        <a href="/info/leasing/" class="contacts-promo__card contacts-promo__card--leasing">
            <div class="contacts-promo__card-wrap">
                <h4 class="contacts-promo__card-title">Лизинг</h4>
                <p class="contacts-promo__card-desc">Почему лизинг - это выгодно</p>
            </div>
            <img class="contacts-promo__card-image" src="/assets/images/info/info-leasing.webp" alt="Лизинг" draggable="false" loading="lazy">
        </a>
    </div>
</section>