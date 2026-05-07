<?php
/** @var array $data */

$tabImageClasses = [
    'tab-image',
    "tab-image-{$data['style']}",
    "tab-image-size_{$data['size']}",
    "tab-image-theme_{$data['theme']}",
    $data['className'] ?? ''
];
?>

<?php if ($data['link']): ?>
    <a href="<?= $data['link'] ?>"
       class="<?= implode(' ', $tabImageClasses) ?>" <?= buildAttrs($data['attributes'] ?? []) ?>>
        <?php if ($data['image'] && !$data['marker']): ?>
            <img src="<?= $data['image'] ?>"
                 class="tab-image__image"
                 alt="<?= $data['text'] ?>"
                 loading="lazy"
                 onerror="this.src=null;this.src='/assets/images/placeholders/fallback-img.webp'"
            >
        <?php endif; ?>

        <?php if ($data['marker'] && !$data['image']): ?>
            <div class="tab-image__marker" <?= buildAttrs($data['attributes'] ?? []) ?>>
                <?= renderIcon($data['marker'], 'tab-image__marker-icon') ?>
            </div>
        <?php endif; ?>

        <div class="tab-image__text-wrap">
            <span class="tab-image__text"><?= $data['text'] ?></span>

            <?php if ($data['description']): ?>
                <span class="tab-image__desc"><?= $data['description'] ?></span>
            <?php endif; ?>
        </div>

        <?php if ($data['badge']): ?>
            <span class="tab-image__badge"><?= $data['badge'] ?></span>
        <?php endif; ?>

        <?php if ($data['iconRight']): ?>
            <?= renderIcon($data['iconRight'], 'tab-image__icon-right') ?>
        <?php endif; ?>
    </a>
<?php else: ?>
    <button class="<?= implode(' ', $tabImageClasses) ?>" <?= buildAttrs($data['attributes'] ?? []) ?>>
        <?php if ($data['image'] && !$data['marker']): ?>
            <img src="<?= $data['image'] ?>"
                 class="tab-image__image"
                 alt="<?= $data['text'] ?>"
                 loading="lazy"
                 onerror="this.src=null;this.src='/assets/images/placeholders/fallback-img.webp'"
            >
        <?php endif; ?>

        <?php if ($data['marker'] && !$data['image']): ?>
            <div class="tab-image__marker" <?= buildAttrs($data['attributes'] ?? []) ?>>
                <?= renderIcon($data['marker'], 'tab-image__marker-icon') ?>
            </div>
        <?php endif; ?>

        <div class="tab-image__text-wrap">
            <span class="tab-image__text"><?= $data['text'] ?></span>

            <?php if ($data['description']): ?>
                <span class="tab-image__desc"><?= $data['description'] ?></span>
            <?php endif; ?>
        </div>

        <?php if ($data['badge']): ?>
            <span class="tab-image__badge"><?= $data['badge'] ?></span>
        <?php endif; ?>

        <?php if ($data['iconRight']): ?>
            <?= renderIcon($data['iconRight'], 'tab-image__icon-right') ?>
        <?php endif; ?>
    </button>
<?php endif; ?>