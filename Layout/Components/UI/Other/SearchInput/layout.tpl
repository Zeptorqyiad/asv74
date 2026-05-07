<?php
/** @var array $data */

$formId = uniqid('search-form_');
?>

<form action="/search/" id="<?= $formId ?>" class="search-form <?= $data['className'] ?>">
    <?php
    App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
        className: 'search-form__input-search',
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
        className: 'search-form__button-submit',
        text: 'Найти',
        loader: true,
        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
        attributes: [
            'type' => 'submit',
        ]
    );
    ?>

    <div class="search-form__results">
        <div class="search-form__results-wrap" data-simplebar>
            <span class="search-form__info-text js-info-text">Начните вводить запрос</span>

            <div class="search-form__list-wrap hidden js--products">
                <h5 class="search-form__list-title">Товары:</h5>
                <div class="search-form__list">

                </div>
            </div>

            <div class="search-form__list-wrap hidden js--categories">
                <h5 class="search-form__list-title">Категории:</h5>
                <div class="search-form__list">

                </div>
            </div>
        </div>

        <div class="search-form__actions js--actions">
            <div class="search-form__actions-buttons">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'search-form__button-count w-full',
                    text: 'Показать все 0 товаров',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                    attributes: [
                        'type' => 'submit',
                    ]
                );
                ?>
            </div>
        </div>
    </div>
</form>