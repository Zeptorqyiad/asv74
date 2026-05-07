<?php

$cats = array_map(fn($c) => [
    'title' => $c->name,
    'badge' => $c->getProductCount(),
    'has_children' => $c->getProductCount() > 0,
    'link' => '/' . $c->path . '/',
], $data['cats']);
?>

<div id="comparison-modal" class="modal comparison-modal" role="dialog" aria-modal="true">
    <div class="comparison-modal__container">
        <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
            className: 'comparison-modal__button-close',
            attributes: [
                'onclick' => 'modalManager.close("comparison-modal")',
            ]
        );
        ?>
        <div class="comparison-modal__top">
            <span class="comparison-modal__title">Сравнение</span>
        </div>

        <div class="comparison-modal__body" data-simplebar>
            <div class="comparison-modal__body-wrap">
                <?php
                foreach ($cats as $cat) {
                    App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                        className: 'comparison-modal__tab-category',
                        text: $cat['title'] ?? '',
                        link: $cat['link'] ?? '',
                        badge: $cat['badge'] ?? '',
                        chevron: $cat['has_children'] ? \App\Layout\Components\UI\Core\Tab\TabChevron::Right : \App\Layout\Components\UI\Core\Tab\TabChevron::None,
                        style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                    );
                }
                ?>
            </div>
        </div>

        <div class="comparison-modal__actions">
            <div class="comparison-modal__actions-buttons">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'comparison-modal__button-back w-full',
                    text: 'Очистить сравнение',
                    link: '/compare/?action=clear&c=' . ($_REQUEST['c'] ?? 0),
                    icon: 'close',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                );
                ?>
            </div>
        </div>

    </div>
</div>