<?php
/** @var array $data */

?>

<?php if ($data['contentText']): ?>
    <?php if ($data['isButton']): ?>
        <button class="tooltip <?= $data['class'] ?>"
                data-default-position="<?= $data['position'] ?>"
                data-tooltip="<?= $data['contentText'] ?>"
            <?= buildAttrs($data['attributes'] ?? []) ?>
        >
            <?php if ($data['icon']): ?>
                <svg class="tooltip__trigger-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 16">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                          d="M7.999 10.667V8m0-2.667h.006M14.665 8A6.667 6.667 0 1 1 1.332 8a6.667 6.667 0 0 1 13.333 0Z"/>
                </svg>
            <?php endif; ?>
            <?php if ($data['triggerText']): ?>
                <span class="tooltip__trigger-text"><?= $data['triggerText'] ?></span>
            <?php endif; ?>

            <span class="tooltip__content" role="tooltip" aria-hidden="true"></span>
        </button>
    <?php else: ?>
        <i class="tooltip <?= $data['class'] ?>"
           data-default-position="<?= $data['position'] ?>"
           data-tooltip="<?= $data['contentText'] ?>"
            <?= buildAttrs($data['attributes'] ?? []) ?>
        >
            <?php if ($data['icon']): ?>
                <svg class="tooltip__trigger-icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 16 16">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                          d="M7.999 10.667V8m0-2.667h.006M14.665 8A6.667 6.667 0 1 1 1.332 8a6.667 6.667 0 0 1 13.333 0Z"/>
                </svg>
            <?php endif; ?>
            <?php if ($data['triggerText']): ?>
                <span class="tooltip__trigger-text"><?= $data['triggerText'] ?></span>
            <?php endif; ?>

            <span class="tooltip__content" role="tooltip" aria-hidden="true"></span>
        </i>
    <?php endif; ?>
<?php endif; ?>