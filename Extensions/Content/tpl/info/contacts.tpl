<?php
/** @var array $content */

$index = $content->loadFrom('/');

$anchors = [
    [
        'text' => 'Основные контакты',
        'link' => '#main-contacts',
        'icon' => 'phone',
    ],
    [
        'text' => 'Менеджеры',
        'link' => '#staff',
        'icon' => 'unique-face',
    ],
    [
        'text' => 'Реквизиты компании',
        'link' => '#credentials',
        'icon' => 'unique-file-search',
    ],
];

$credentials = self::getTableFrom('contacts_credentials', $content);
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'Контакты',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: 'Контакты',
            links: $anchors,
        );

        App\Layout\Components\Unique\ContactsSection\Layout::draw();

        App\Layout\Components\Unique\StaffSection\Layout::draw();

        if ($credentials) {
            App\Layout\Components\Unique\CredentialsSection\Layout::draw([
                'tableRows' => self::getTableFrom('contacts_credentials', $content),
                'file' => '/uf/files/' . $content['params']['contacts_file'],
            ]);
        }

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