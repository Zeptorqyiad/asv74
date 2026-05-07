<?php

$sortTabs = [
    [
        'text' => 'По умолчанию',
        'value' => 'default',
    ],
    [
        'text' => 'Под заказ',
        'value' => 'popular',
    ],
    [
        'text' => 'Дешевле',
        'value' => 'pmin',
    ],
    [
        'text' => 'Дороже',
        'value' => 'pmax',
    ],
    [
        'text' => 'Размер скидки',
        'value' => 'discount',
    ],
]
?>

<div id="sort-modal" class="modal sort-modal" role="dialog" aria-modal="true">
    <div class="sort-modal__container">
        <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
            className: 'sort-modal__button-close',
            attributes: [
                'onclick' => 'modalManager.close("sort-modal")',
            ]
        );
        ?>
        <div class="sort-modal__top">
            <span class="sort-modal__title">Сортировать</span>
        </div>

        <div class="sort-modal__body" data-simplebar>
            <div class="sort-modal__body-wrap">
                <?php
                foreach ($sortTabs as $tab) {
                    App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                        className: 'sort-modal__tab w-full',
                        text: $tab['text'] ?? '',
                        link: './?sort=' . $tab['value'],
                        style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                        attributes: [
                            'data-value' => $tab['value']
                        ]
                    );
                }
                ?>
            </div>
        </div>
    </div>
</div>