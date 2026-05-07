<?php
/** @var array $content */

$index = $content->loadFrom('/');

$cases = App\Extensions\Site\Model\CaseDetail::findAdv()
    ->where(['is_active' => 1])
    ->orderBy('npp DESC')
    ->all();
?>

<?php
App\Layout\Components\Common\Header\Layout::drawHeader();
?>

    <main>
        <?php
        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: 'История поставок',
            desc: 'Здесь представлены фотографии наших клиентов, которые приобрели у нас технику, фото сделаны с согласия покупателей на территории нашей базы в г. Миасс или на площадке заказчика при доставке.',
        );

        App\Layout\Components\Unique\CasesSection\Layout::draw([
            'cards' => $cases,
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