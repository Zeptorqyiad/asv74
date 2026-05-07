<?php
/** @var array $content */

$index = $content->loadFrom('/');

$blocks = self::getTableFrom('privacy_blocks', $content);
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'Политика конфиденциальности',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Unique\PrivacySection\Layout::draw([
            'title' => $content['params']['privacy_title'],
            'blocks' => $blocks,
        ]);
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]); ?>