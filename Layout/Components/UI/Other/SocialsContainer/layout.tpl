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

$theme = $data['theme'] == 'light' ? App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialTheme::Light : App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialTheme::Dark;
?>

<div class="socials-container <?= $data['className'] ?>">
    <?php
    if ($vk) {
        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
            link: $vk,
            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Vkontakte,
            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
            theme: $theme,
        );
    }

    if ($tg) {
        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
            link: $tg,
            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Telegram,
            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
            theme: $theme,
        );
    }

    if ($max_social) {
        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
            link: $max_social,
            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Max,
            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
            theme: $theme,
        );
    }

    if ($ya) {
        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
            link: $ya,
            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Yandex,
            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
            theme: $theme,
        );
    }

    if ($go) {
        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
            link: $go,
            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Google,
            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
            theme: $theme,
        );
    }

    if ($in) {
        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
            link: $in,
            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::Instagram,
            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
            theme: $theme,
        );
    }

    if ($rt) {
        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
            link: $rt,
            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::RuTube,
            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
            theme: $theme,
        );
    }

    if ($yt) {
        App\Layout\Components\UI\Core\Buttons\ButtonSocial\Layout::drawButtonSocial(
            link: $yt,
            type: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialType::YouTube,
            size: \App\Layout\Components\UI\Core\Buttons\ButtonSocial\ButtonSocialSize::Small,
            theme: $theme,
        );
    }
    ?>
</div>