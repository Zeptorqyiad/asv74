<?php
/** @var array $data */
/** @var array $content */

$index = $content->loadFrom('/');

$case = $this->case;
?>

<?php
App\Layout\Components\Common\Header\Layout::drawHeader(
    title: $case->title ?? '',
);
?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Layouts\Case\CaseFs\Layout::drawCaseFs(
            title: $case->title ?? '',
            images: $case->getImages(),
        );

        App\Layout\Components\Layouts\Case\CaseContent\Layout::drawCaseContent(
            location: $case->location ?? '',
            date: $case->date ?? '',
            content: $case->content ?? '',
            link: $case->link ?? '',
        );

        App\Layout\Components\Common\SliderSections\CasesSlider\Layout::draw([
            'title' => 'Другие поставки',
            'link' => '/cases/',
            'case_id' => $this->case_asv_id,
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