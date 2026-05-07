<?php
/** @var array $content */

$index = $content->loadFrom('/');

$q = App\Extensions\Site\Model\Review::findAdv()->where(['is_active' => 1]);

$pag = $_REQUEST['page'] ?? 0;

$count = $q->select('count(*)')->fetchScalar();
$cards = $q->select('*')->limit('16 offset ' . ($pag * 16))->orderBy('npp DESC')->all();
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'Отзывы',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: 'Отзывы',
        );

        App\Layout\Components\Unique\ReviewsSection\Layout::draw([
            'cards' => $cards,
        ]);

        App\Layout\Components\UI\Other\Pagination\Layout::drawPages($pag, ceil($count / 15));

        App\Layout\Components\Common\PromoSections\ContactsPromo\Layout::draw();

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