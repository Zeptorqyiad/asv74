<div class="modal filter-modal subfilter-modal js--subfilter-modal">
    <div class="filter-modal__container">
        <div class="filter-modal__top">
            <span class="filter-modal__title"><?= $data['title'] ?></span>
            <button class="filter__button-reset" type="button" data-reset-group="<?= $data['group'] ?>">сбросить</button>
            <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
                className: 'filter-modal__button-close js--hide-subfilter',
            ); ?>
        </div>

        <?php App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
            className: 'filter-modal__search js--search-subfilter',
            icon: 'search',
            attributes: [
                'type' => 'search',
                'placeholder' => 'Я ищу...',
            ]
        ); ?>

        <div class="filter-modal__body">
            <fieldset class="filter__fieldset" >
                <?php foreach ($data['items'] as $c):
                    App\Layout\Components\UI\Core\Checkbox\Layout::drawCheckbox(
                        className: 'js--item-more',
                        text: $c['text'],
                        style: $c['style'] ?? App\Layout\Components\UI\Core\Checkbox\CheckboxStyle::Line,
                        attributes: [
                            'name' => $c['name'],
                            'id' => $c['id'],
                            'value' => $c['value'],
                            'type' => $data['type'],
                        ] + ($c['checked'] ? ['checked' => 'checked'] : [])
                    );
                endforeach; ?>
            </fieldset>
            <span class="subfilter-modal__empty-text">Не найдено</span>
            <button class="filter__button-more" type="button">Показать все</button>
        </div>

        <div class="filter-modal__actions">
            <div class="filter-modal__actions-buttons">
                <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'w-full js--confirm-subfilter',
                    text: 'Применить',
                    attributes: [ 'type' => 'button' ]
                ); ?>
            </div>
            <span class="filter-modal__count js--filter-available-count">Товаров подходит: <?= $data['cnt'] ?></span>
        </div>
    </div>
</div>