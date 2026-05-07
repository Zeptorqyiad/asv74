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
        'className' => 'with-separator',
        'text' => 'Политика конфиденциальности',
        'link' => '/info/privacy/',
        'chevron' => true,
    ],
];

$tabs = !empty($data['tabs']) ? $data['tabs'] : $asideMenuLinks;

if (!$data['noFollow']) {
    usort($tabs, static function ($a, $b) {
        $aActive = str_contains(Container::getRequest()->getPath(), $a['link']);
        $bActive = str_contains(Container::getRequest()->getPath(), $b['link']);

        return $bActive <=> $aActive;
    });
}
?>

<aside class="aside-menu <?= $data['className'] ?? '' ?>">
    <div class="aside-menu__container">
        <div class="aside-menu__tabs">
            <?php foreach ($tabs as $tab) {
                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'aside-menu__tab ' . ($tab['className']) . (str_contains($_SERVER['REQUEST_URI'], $tab['link']) ? ' active' : ''),
                    text: $tab['text'] ?? '',
                    link: $tab['link'] ?? '',
                    chevron: $tab['chevron'] ? \App\Layout\Components\UI\Core\Tab\TabChevron::Right : \App\Layout\Components\UI\Core\Tab\TabChevron::None,
                    style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                );
            }
            ?>
        </div>
    </div>
</aside>