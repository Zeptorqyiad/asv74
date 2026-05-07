<?php
/** @var array $content */

$index = $content->loadFrom('/');

$c = $_REQUEST['c'] ?? 0;

?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'Каталог',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: $c ? (\Simflex\Core\DB::result('select name from catalog_category where category_id = ?', 0, [$c])) : 'Каталог спецтехники',
        );

        App\Layout\Components\Unique\CategoryGrid\Layout::draw();

        App\Layout\Components\Common\PromoSections\AboutPromo\Layout::draw([
            'className' => 'about-promo--links',
        ]);

        App\Layout\Components\Common\PromoSections\ConsultationPromo\Layout::draw([
            'title' => $index['params']['index_form_title'],
            'desc' => $index['params']['index_form_desc'],
            'image' => $index['params']['index_form_image'],
        ]);

        App\Layout\Components\Common\PromoSections\SeoPromo\Layout::draw([
            'seo_title_1' => $content['params']['catalog_seo_title_1'],
            'seo_text_1' => $content['params']['catalog_seo_text_1'],
            'seo_title_2' => $content['params']['catalog_seo_title_2'],
            'seo_text_2' => $content['params']['catalog_seo_text_2'],
        ]);
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]); ?>