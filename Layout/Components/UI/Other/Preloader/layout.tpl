<?php
/** @var array $data */
?>

<div class="preloader <?= $data['className'] ?>" <?= buildAttrs($data['attributes'] ?? []) ?>>
    <?php
    App\Layout\Components\UI\Other\LoaderIcon\Layout::draw([
        'className' => 'preloader__icon',
    ]);
    ?>
</div>