<?php
/** @var array $data */

use Simflex\Core\Container;

$asideMenuLinks = [
    [
        'text' => 'Оплата',
        'link' => '/info/payment/',
    ],
    [
        'text' => 'Доставка',
        'link' => '/info/delivery/',
    ],
    [
        'text' => 'Гарантия',
        'link' => '/info/guarantee/',
    ],
    [
        'text' => 'Лизинг',
        'link' => '/info/leasing/',
    ],
    [
        'text' => 'Частые вопросы',
        'link' => '/info/faq/',
    ],
    [
        'text' => 'Политика конфиденциальности',
        'link' => '/info/privacy/',
    ],
];

$tabs = !empty($data['tabs']) ? $data['tabs'] : $asideMenuLinks;

usort($tabs, static function ($a, $b) {
    $aActive = str_contains(Container::getRequest()->getPath(), $a['link']);
    $bActive = str_contains(Container::getRequest()->getPath(), $b['link']);

    return $aActive ? -1 : ($bActive ? 1 : 0);
});
?>

<aside class="mobile-menu <?= $data['className'] ?? '' ?>">
    <div class="mobile-menu__container container">
        <div class="mobile-menu__tabs">
            <?php foreach ($tabs as $tab) {
                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'mobile-menu__tab ' . ($tab['className']) . (str_contains($_SERVER['REQUEST_URI'], $tab['link']) ? ' active' : ''),
                    text: $tab['text'] ?? '',
                    link: $tab['link'] ?? '',
                    icon: $tab['icon'] ?? '',
                    chevron: $tab['chevron'] ? \App\Layout\Components\UI\Core\Tab\TabChevron::Right : \App\Layout\Components\UI\Core\Tab\TabChevron::None,
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                );
            }
            ?>
        </div>
    </div>
</aside>