<?php
/** @var array $content */

$index = $content->loadFrom('/');
$about = $content->loadFrom('/about/');

$advantagesCards = self::getTableFrom('manufacture_advantages_cards', $content);
$workshopCards = self::getTableFrom('manufacture_workshops_cards', $content);
$workProcessCards = self::getTableFrom('about_process_cards', $about);

$galleryCards = self::getTableFrom('manufacture_gallery_cards', $content);

?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'О производстве',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Layouts\Manufacture\ManufactureFs\Layout::draw([
            'title' => $content['params']['manufacture_fs_title'],
            'desc' => $content['params']['manufacture_fs_desc'],
            'image' => $content['params']['manufacture_fs_image'] ? '/uf/images/source/' . $content['params']['manufacture_fs_image'] : '',
        ]);

        if ($advantagesCards) {
            App\Layout\Components\Layouts\Manufacture\ManufactureAdvantages\Layout::draw([
                'title' => $content['params']['manufacture_advantages_title'],
                'image' => $content['params']['manufacture_advantages_image'] ? '/uf/images/source/' . $content['params']['manufacture_advantages_image'] : '',
                'cards' => $advantagesCards,
            ]);
        }

        if ($workshopCards) {
            App\Layout\Components\Layouts\Manufacture\ManufactureWorkshops\Layout::draw([
                'title' => $content['params']['manufacture_workshops_title'],
                'desc' => $content['params']['manufacture_workshops_desc'],
                'cards' => $workshopCards,
            ]);
        }

        if ($workProcessCards) {
            App\Layout\Components\Common\PromoSections\WorkProcessPromo\Layout::draw([
                'title' => 'Процесс работы',
                'cards' => $workProcessCards
            ]);
        }

        if ($galleryCards) {
            App\Layout\Components\Layouts\Manufacture\ManufactureGallery\Layout::draw([
                'title' => $content['params']['manufacture_gallery_title'],
                'cards' => $galleryCards,
            ]);
        }

        App\Layout\Components\Common\PromoSections\AboutPromo\Layout::draw([
            'title' => $index['params']['index_about_title'],
            'desc' => $index['params']['index_about_desc'],
            'img' => $index['params']['index_about_image'] ? '/uf/images/source/' . $index['params']['index_about_image'] : '',
            'cards' => self::getTableFrom('index_about_cards', $index),
            'quote' => $index['params']['index_about_quote'],
            'badge' => $index['params']['index_about_badge'] ?? '',
        ]);

        App\Layout\Components\Common\PromoSections\ContactsPromo\Layout::draw();

        App\Layout\Components\Common\PromoSections\ConsultationPromo\Layout::draw([
            'title' => $index['params']['index_form_title'],
            'desc' => $index['params']['index_form_desc'],
            'image' => $index['params']['index_form_image'],
        ]);
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]); ?>