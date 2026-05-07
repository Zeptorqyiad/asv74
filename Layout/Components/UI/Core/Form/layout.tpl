<?php
/** @var array $data */

$formId = uniqid('form_');
?>

<form id="<?= $formId ?>"
      class="form <?= $data['className'] ?? '' ?>" <?= buildAttrs($data['attributes'] ?? []) ?>
      enctype="multipart/form-data"
      method="post"
>
    <?php if($data['form_placement']):
        App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
            className: 'form__text-input hidden',
            attributes: [
                'name' => 'placement',
                'type' => 'hidden',
                'value' => $data['form_placement']
            ]
        );
    endif; ?>

    <div class="form__inputs">
        <div class="form__input-row">
            <?php /*
            App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
                className: 'form__text-input form__text-input--name',
                labelText: 'Имя*',
                labelPos: \App\Layout\Components\UI\Core\TextInput\TextInputLabelPos::Standard,
                id: $formId . '_name',
                attributes: [
                    'name' => 'name',
                    'type' => 'text',
                    'placeholder' => 'Иван',
                    'required' => 'true',
                    'autocomplete' => 'given-name',
                ]
            );
            */
            App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
                className: 'form__text-input form__text-input--phone',
                labelText: 'Телефон*',
                labelPos: \App\Layout\Components\UI\Core\TextInput\TextInputLabelPos::Standard,
                id: $formId . '_phone',
                attributes: [
                    'name' => 'phone',
                    'type' => 'tel',
                    'placeholder' => '+7 (999) 999-99-99',
                    'required' => 'true',
                    'autocomplete' => 'tel',
                ]
            );
            ?>
        </div>
        <?php /*
        App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
            className: 'form__text-input form__text-input--email',
            labelText: 'E-mail*',
            labelPos: \App\Layout\Components\UI\Core\TextInput\TextInputLabelPos::Standard,
            id: $formId . '_email',
            attributes: [
                'name' => 'email',
                'type' => 'email',
                'placeholder' => 'example@example.ru',
                'required' => 'true',
                'autocomplete' => 'email',
            ]
        );
        App\Layout\Components\UI\Core\TextArea\Layout::drawTextArea(
            className: 'form__text-input form__text-input--message',
            labelText: 'Комментарий',
            labelPos: \App\Layout\Components\UI\Core\TextArea\TextAreaLabelPos::Standard,
            id: $formId . '_message',
            attributes: [
                'name' => 'message',
                'placeholder' => 'Что вас интересует?'
            ]
        );
        */
        ?>
    </div>

    <div class="form__controls">
        <?php
        App\Layout\Components\UI\Core\Checkbox\Layout::drawCheckbox(
            policy: true,
            attributes: [
                'id' => $formId . '_policy',
                'required' => 'true',
                'type' => 'checkbox'
            ]
        );
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'form__button-submit',
            text: 'Отправить заявку',
            loader: true,
            attributes: [
                'type' => 'submit',
                'onclick' => $data['nonModal'] ? 'tracker.track("promo_form_open");' : '',
            ]
        );
        ?>
    </div>
</form>