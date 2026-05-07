<?php
/** @var array $data */
?>

<?php if ($data['link']): ?>
    <a class="brand-card <?= $data['className'] ?>"
       href="<?= $data['link'] ?>"
       title="<?= $data['name'] ?>"
       aria-label="<?= $data['name'] ?>"
    >
        <?php if ($data['image']): ?>
            <img class="brand-card__image"
                 src="<?= $data['image'] ?>"
                 alt="<?= $data['name'] ?>"
                 draggable="false"
                 loading="lazy"
            >
        <?php endif; ?>

        <?php if ($data['name'] && !$data['image']): ?>
            <span class="brand-card__name"><?= $data['name'] ?></span>
        <?php endif; ?>

        <svg class="brand-card__icon" xmlns="http://www.w3.org/2000/svg" stroke="currentColor" fill="none" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="4" d="m7.05 16.95 9.9-9.9m0 0h-9.9m9.9 0v9.9"/>
        </svg>

        <?php if ($data['badge']): ?>
            <span class="brand-card__badge">Официальный дилер</span>
        <?php endif; ?>
    </a>
<?php endif; ?>