<?php
/** @var array $content */

$index = $content->loadFrom('/');
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'Частые вопросы',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: 'Частые вопросы',
            button: false
        );

        App\Layout\Components\Common\MobileMenu\Layout::drawMobileMenu();

        App\Layout\Components\Unique\FaqSection\Layout::draw();

        App\Layout\Components\Common\PromoSections\ConsultationPromo\Layout::draw([
            'contacts' => true,
        ]);
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]); ?>