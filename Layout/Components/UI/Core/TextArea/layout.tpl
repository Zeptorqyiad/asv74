<?php
/** @var array $data */

$textareaClasses = [
    'textarea-input',
    "textarea-input-pos_{$data['labelPos']}",
    "textarea-input-style_{$data['style']}",
    "textarea-input-size_{$data['size']}",
    "textarea-input-theme_{$data['theme']}",
    $data['className'] ?? ''
];
?>

<div class="<?= implode(' ', $textareaClasses) ?>">
    <div class="textarea-input__wrapper">
        <?php if ($data['labelPos'] === 'standard'): ?>
            <label class="textarea-input__label" for="<?= $data['id'] ?>"><?= $data['labelText'] ?></label>
        <?php endif; ?>

        <div class="textarea-input__input-container">
            <textarea
                    id="<?= $data['id'] ?>"
                    class="textarea-input__field"
                <?= buildAttrs($data['attributes'] ?? []) ?>
            ></textarea>
        </div>
        <span class="textarea-input__error-message hidden"></span>
    </div>
</div>