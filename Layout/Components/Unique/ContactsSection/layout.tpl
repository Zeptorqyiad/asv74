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

$map = Simflex\Core\Core::siteParam('map');
?>

<section class="contacts-section" id="main-contacts">
    <div class="contacts-section__container container">
        <h3 class="contacts-section__title">Основные контакты:</h3>

        <div class="contacts-section__wrap">
            <div class="contacts-section__info">
                <div class="contacts-section__info-wrap">
                    <div class="contacts-section__info-row">
                        <?php
                        App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                            className: 'contacts-section__info-marker',
                            icon: 'phone',
                            size: \App\Layout\Components\UI\Core\Marker\MarkerSize::Small
                        );

                        App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                            className: 'contacts-section__info-button',
                            text: '{phone}',
                            link: 'tel:{phone}',
                            style: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactStyle::Monochrome,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactSize::Small,
                        );
                        ?>
                    </div>

                    <div class="contacts-section__info-row">
                        <?php
                        App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                            className: 'contacts-section__info-marker',
                            icon: 'mail',
                            size: \App\Layout\Components\UI\Core\Marker\MarkerSize::Small,
                        );

                        App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                            className: 'contacts-section__info-button',
                            text: '{email}',
                            link: 'mailto:{email}',
                            style: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactStyle::Monochrome,
                            size: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactSize::Small,
                        );
                        ?>
                    </div>

                    <div class="contacts-section__info-row">
                        <?php App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                            className: 'contacts-section__info-marker',
                            icon: 'marker',
                            size: \App\Layout\Components\UI\Core\Marker\MarkerSize::Small
                        ); ?>
                        <span class="contacts-section__info-text">{address}</span>
                    </div>

                    <div class="contacts-section__info-row">
                        <?php App\Layout\Components\UI\Core\Marker\Layout::drawMarker(
                            className: 'contacts-section__info-marker',
                            icon: 'clock',
                            size: \App\Layout\Components\UI\Core\Marker\MarkerSize::Small
                        ); ?>
                        <span class="contacts-section__info-text">{workhours}</span>
                    </div>

                    <div class="contacts-section__info-row contacts-section__info-row--social">
                        <?php
                        if ($vk) {
                            App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                                className: 'contacts-section__button-social',
                                link: $vk,
                                type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Vkontakte,
                                size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
                            );
                        }

                        if ($tg) {
                            App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                                className: 'contacts-section__button-social',
                                link: $tg,
                                type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Telegram,
                                size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
                            );
                        }

                        if ($max_social) {
                            App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                                className: 'contacts-section__button-social',
                                link: $max_social,
                                type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Max,
                                size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
                            );
                        }

                        if ($ya) {
                            App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                                className: 'contacts-section__button-social',
                                link: $ya,
                                type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Yandex,
                                size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
                            );
                        }

                        if ($go) {
                            App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                                className: 'contacts-section__button-social',
                                link: $go,
                                type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Google,
                                size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
                            );
                        }

                        if ($in) {
                            App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                                className: 'contacts-section__button-social',
                                link: $in,
                                type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Instagram,
                                size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
                            );
                        }

                        if ($rt) {
                            App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                                className: 'contacts-section__button-social',
                                link: $rt,
                                type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::RuTube,
                                size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
                            );
                        }

                        if ($yt) {
                            App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
                                className: 'contacts-section__button-social',
                                link: $yt,
                                type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::YouTube,
                                size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
                            );
                        }
                        ?>
                    </div>
                </div>

                <a class="contacts-section__info-link" href="/asv/ASV2022.html">
                    <?= renderIcon('unique-cube-outline') ?>
                    <span>3D экскурсия</span>
                </a>
            </div>

            <?php if ($map): ?>
                <div class="contacts-section__map">
                    <iframe src="<?= $map ?>" frameborder="0"></iframe>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>