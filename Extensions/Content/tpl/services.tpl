<?php
/** @var array $content */

use App\Extensions\Services\Model\Services;
$index = $content->loadFrom('/');

$cards = Services::findAdv()
    ->where(['is_active' => 1])
    ->orderBy('npp')
    ->all();

usort($cards, fn ($a, $b) => $b->npp <=> $a->npp);
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'Услуги',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: 'Услуги',
        );

        App\Layout\Components\Unique\ServicesSection\Layout::draw([
            'cards' => $cards,
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