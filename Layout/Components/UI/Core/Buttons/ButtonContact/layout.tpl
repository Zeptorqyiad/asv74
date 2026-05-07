<?php
/** @var array $data */

$buttonContactClasses = [
    'btn-contact',
    "btn-contact-{$data['style']}",
    "btn-contact-size_{$data['size']}",
    "btn-contact-theme_{$data['theme']}",
    $data['className'] ?? ''
];
?>

<a href="<?= $data['type'] . $data['link'] ?>"
   class="<?= implode(' ', $buttonContactClasses) ?>" <?= buildAttrs($data['attributes'] ?? []) ?>>
    <?php if ($data['text']): ?>
        <span class="btn-contact__text"><?= $data['text'] ?></span>
    <?php endif; ?>
</a>