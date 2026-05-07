<?php
/** @var array $content */

$index = $content->loadFrom('/');
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'ОТТС',
); ?>

<main>
    <?php
    App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

    App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
        title: 'Одобрения типа транспортного средства',
    );

    App\Layout\Components\Common\MobileMenu\Layout::drawMobileMenu(
        tabs: [
            [
                'text' => 'Сертификаты',
                'link' => '/info/certificates/',
            ],
            [
                'text' => 'ОТТС',
                'link' => '/info/otts/',
            ],
        ]
    );

    App\Layout\Components\Unique\OttsSection\Layout::draw();

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
