<?php
/** @var array $content */

$index = $content->loadFrom('/');

$blocks = self::getTableFrom('guarantee_blocks', $content);
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'Гарантия',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: 'Информация о гарантии',
            button: false
        );

        App\Layout\Components\Common\MobileMenu\Layout::drawMobileMenu();

        App\Layout\Components\Unique\GuaranteeSection\Layout::draw([
            'blocks' => $blocks
        ]);

        App\Layout\Components\Common\PromoSections\ConsultationPromo\Layout::draw([
            'title' => $index['params']['index_form_title'],
            'desc' => $index['params']['index_form_desc'],
            'image' => $index['params']['index_form_image'],
            'contacts' => true,
        ]);
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]); ?>