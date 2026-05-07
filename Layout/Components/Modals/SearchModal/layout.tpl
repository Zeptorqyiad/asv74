<?php
$formId = uniqid('search-modal_');

$products = [
    [
        'title' => 'Тестовый товар',
        'desc' => '0123456789',
        'image' => '/assets/images/products/product-mock-1.webp',
        'link' => '/catalog/category/product/',
    ],
    [
        'title' => 'Тестовый товар 2',
        'desc' => '0123456789',
        'image' => '/assets/images/products/product-mock-2.webp',
        'link' => '/catalog/category/product/',
    ],
    [
        'title' => 'Тестовый товар 3',
        'desc' => '0123456789',
        'image' => '/assets/images/products/product-mock-3.webp',
        'link' => '/catalog/category/product/',
    ],
    [
        'title' => 'Тестовый товар 4',
        'desc' => '0123456789',
        'image' => '/assets/images/products/product-mock-4.webp',
        'link' => '/catalog/category/product/',
    ],
];
?>

<template id="search-card-template">
    <?php App\Layout\Components\Cards\SearchCard\Layout::drawSearchCard(); ?>
</template>

<div id="search-modal" class="modal search-modal" role="dialog" aria-modal="true">
    <form action="/search/" id="<?= $formId ?>" class="search-modal__container">
        <div class="search-modal__top">
            <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
                className: 'search-modal__button-close',
                icon: 'arrow-left',
                attributes: [
                    'onclick' => 'modalManager.close("search-modal");',
                ]
            );

            App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
                className: 'search-modal__input-search',
                icon: 'search',
                id: $formId . '_search-input',
                attributes: [
                    'name' => 'q',
                    'type' => 'search',
                    'placeholder' => 'Найти технику',
                    'value' => $_REQUEST['q'] ?? '',
                ]
            );

            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'search-modal__button-submit',
                icon: 'search',
                loader: true,
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                attributes: [
                    'aria-label' => 'Подтвердить поиск',
                    'type' => 'submit',
                ]
            );
            ?>
        </div>

        <div class="search-modal__body" data-simplebar>
            <div class="search-modal__body-wrap">

                <span class="search-modal__info-text js--info-text">Начните вводить запрос</span>

                <div class="search-modal__list-wrap hidden js--products">
                    <h5 class="search-modal__list-title">Товары:</h5>
                    <div class="search-modal__list">

                    </div>
                </div>

                <div class="search-modal__list-wrap hidden js--categories">
                    <h5 class="search-modal__list-title">Категории:</h5>
                    <div class="search-modal__list">

                    </div>
                </div>
            </div>
        </div>

        <div class="search-modal__actions js--actions">
            <div class="search-modal__actions-buttons">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'search-modal__button-count w-full',
                    text: 'Показать все 0 товаров',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                    attributes: [
                        'type' => 'submit',
                    ]
                );
                ?>
            </div>
        </div>

    </form>
</div>