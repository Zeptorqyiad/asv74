<?php
/** @var array $data */

$linkPrefix = [
    'phone' => 'tel:',
    'email' => 'mailto:'
];
?>

<div class="staff-card <?= $data['className'] ?>">
    <img class="staff-card__image"
         src="<?= $data['image'] ?: '/assets/images/placeholders/fallback-img.webp' ?>"
         alt="<?= $data['name'] ?>"
         loading="lazy"
         draggable="false"
    >
    <h5 class="staff-card__name"><?= $data['name'] ?></h5>
    <span class="staff-card__job"><?= $data['job'] ?></span>
    <div class="staff-card__links">
        <?php foreach ($data['links'] as $l) {

            $link = ($linkPrefix[$l['type'] ?? ''] ?? '') . ($l['link'] ?? '');
            App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                className: 'staff-card__link',
                text: $l['link'] ?? '',
                link: $link,
                style: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactStyle::Filled,
                size: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactSize::ExtraSmall,
            );
        } ?>
    </div>
</div>