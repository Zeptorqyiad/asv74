<?php
/** @var array $data */

$checkboxClasses = [
    'checkbox',
    "checkbox-{$data['style']}",
    "checkbox-size_{$data['size']}",
    "checkbox-position_{$data['position']}",
    "checkbox-theme_{$data['theme']}",
    $data['className'] ?? ''
];
?>

<label class="<?= implode(' ', $checkboxClasses) ?>">
    <input class="checkbox__input" <?= buildAttrs($data['attributes'] ?? []) ?>>
    <span class="checkbox__custom" aria-hidden="true">
        <svg class="checkbox__icon" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path d="M5 12l5 5 9-9"
                  stroke="currentColor"
                  fill="none"
                  stroke-width="3"
                  stroke-linecap="round"
                  stroke-linejoin="round"
            />
        </svg>
    </span>
    <?php if ($data['text']): ?>
        <span class="checkbox__text"><?= $data['text'] ?></span>
    <?php endif; ?>
    <?php if ($data['policy'] && !$data['text']): ?>
        <span class="checkbox__policy">
            Я соглашаюсь с <a href="/info/privacy/">политикой обработки персональных данных</a>
        </span>
    <?php endif; ?>
</label>