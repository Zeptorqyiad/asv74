<?php

$cats = App\Extensions\Site\Model\Category::find(['is_active' => 1, 'pid' => null, 'is_on_home' => 1], 'npp');

function renderPanel(array $cats, string $panelId, ?string $parentPanelId = null): void
{
    $hiddenClass = $parentPanelId ? ' hidden' : '';

    // 1) Render this level’s panel and close it immediately
    echo "<div class=\"catalog-modal__panel{$hiddenClass}\" id=\"{$panelId}\""
        . ($parentPanelId ? " data-parent=\"{$parentPanelId}\"" : "")
        . ">\n";

    foreach ($cats as $cat) {
        App\Layout\Components\UI\Core\TabImage\Layout::drawTabImage(
            className: 'catalog-modal__tab-category',
            text:      $cat->name,
            link:      empty($cat->path) ? '' : "/{$cat->path}/",
            image:     $cat->photo ? "/uf/images/source/{$cat->photo}" : '',
            style:     \App\Layout\Components\UI\Core\TabImage\TabImageStyle::Secondary,
        );
    }

    echo "</div>\n";
}

?>

<div id="catalog-modal" class="modal catalog-modal" role="dialog" aria-modal="true">
    <div class="catalog-modal__container">
        <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
            className: 'catalog-modal__button-close',
            attributes: [
                'onclick' => 'modalManager.close("catalog-modal");',
            ]
        );
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'catalog-modal__button-search',
            icon: 'search',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
            attributes: [
                'aria-label' => 'Поиск',
                'onclick' => 'modalManager.open("search-modal");',
            ]
        );
        ?>
        <div class="catalog-modal__top">
            <span class="catalog-modal__title">Каталог</span>
        </div>

        <div class="catalog-modal__body" data-simplebar>
            <div class="catalog-modal__body-wrap">
                <?php renderPanel($cats, 'panel-root'); ?>
            </div>
        </div>

        <div class="catalog-modal__actions">
            <div class="catalog-modal__actions-buttons">
                <?php
                App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                    className: 'catalog-modal__button-count w-full',
                    text: 'Весь каталог',
                    link: '/categories/',
                    badge: count($cats) ?? '',
                );

                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'catalog-modal__button-back w-full hidden',
                    text: 'Назад',
                    icon: 'arrow-left',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Flat,
                );
                ?>
            </div>
        </div>

    </div>
</div>