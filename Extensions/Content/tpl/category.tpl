<?php
/** @var array $content */

$index = $content->loadFrom('/');

//$pf = $this->makeFilter();
//$f = $this->makeSpecialFilter();
//if ($f && $pf[0]) {
//    $pf[0] = $f . ' AND ' . $pf[0];
//}
//
//$cnt = $this->cat->getProductCount($pf);
//
//$pag = $_REQUEST['page'] ?? 0;

$videoReviewsSlides = [
    [
        'title' => 'Мастерская "АСВ7721P4" на шасси Камаз 43118-3027-50',
        'src' => '/assets/videos/placeholders/video-mock-1.mp4',
        'poster' => '',
    ],
    [
        'title' => 'Мастерская передвижная Камаз 43118-3027-50 с жилым отсеком',
        'src' => '/assets/videos/placeholders/video-mock-2.mp4',
        'poster' => '',
    ],
    [
        'title' => 'Передвижная мастерская ПАРМ с токарным станком на шасси Камаз 43118',
        'src' => '/assets/videos/placeholders/video-mock-3.mp4',
        'poster' => '',
    ],
    [
        'title' => 'Передвижная мастерская Урал 4320-1912-60 (Евро-5) КМУ ИМ-50',
        'src' => '/assets/videos/placeholders/video-mock-4.mp4',
        'poster' => '',
    ],
    [
        'title' => 'Мастерская "АСВ7721P4" на шасси Камаз 43118-3027-50',
        'src' => '/assets/videos/placeholders/video-mock-1.mp4',
        'poster' => '',
    ],
    [
        'title' => 'Мастерская передвижная Камаз 43118-3027-50 с жилым отсеком',
        'src' => '/assets/videos/placeholders/video-mock-2.mp4',
        'poster' => '',
    ],
    [
        'title' => 'Передвижная мастерская ПАРМ с токарным станком на шасси Камаз 43118',
        'src' => '/assets/videos/placeholders/video-mock-3.mp4',
        'poster' => '',
    ],
    [
        'title' => 'Передвижная мастерская Урал 4320-1912-60 (Евро-5) КМУ ИМ-50',
        'src' => '/assets/videos/placeholders/video-mock-4.mp4',
        'poster' => '',
    ],
    [
        'title' => 'Передвижная мастерская ПАРМ с токарным станком на шасси Камаз 43118',
        'src' => '/assets/videos/placeholders/video-mock-3.mp4',
        'poster' => '',
    ],
    [
        'title' => 'Передвижная мастерская Урал 4320-1912-60 (Евро-5) КМУ ИМ-50',
        'src' => '/assets/videos/placeholders/video-mock-4.mp4',
        'poster' => '',
    ],
];
$catalogCards = [
    [
        'id' => 1,
        'link' => '/catalog/category/product/',
        'title' => 'Вахтовый автобус Урал NEXT 4320-6952-72 (Е5) Г38, 28 мест',
        'desc' => '6х6, 300 л.с., Евро-5, КПП 154, без КМУ, таль ручная, пассажирский отсек 3 места + рабочий отсек + отсек с дизель-генератором, 2 верстака, наждачно-обдирочный станок, сверлильный станок, тиски, сварочное оборудование',
        'category' => 'Вахтовые автобусы и ГПА',
        'sku' => 'Артикул',
        'toOrder' => true,
        'isNew' => true,
        'inStock' => true,
        'isSale' => true,
        'images' => [
            '/assets/images/products/product-mock-1.webp',
            '/assets/images/products/product-mock-2.webp',
            '/assets/images/products/product-mock-3.webp',
            '/assets/images/products/product-mock-1.webp',
            '/assets/images/products/product-mock-2.webp',
            '/assets/images/products/product-mock-3.webp',
        ],
    ],
    [
        'id' => 2,
        'link' => '/catalog/category/product/',
        'title' => 'Бортовой автомобиль FAW J6 c КМУ Sunhunk S-2106',
        'desc' => '6х6, 300 л.с., Евро-5, КПП 154, без КМУ, рабочий + жилой отсеки, станок точильно-шлифовальный, станок сверлильный, насос, сварочное оборудование',
        'category' => 'Спецтехника с КМУ',
        'sku' => 'Артикул',
        'price' => '12 900 000 ₽',
        'oldPrice' => '13 265 000 ₽',
        'isNew' => true,
        'inStock' => true,
        'isSale' => true,
        'images' => [
            '/assets/images/products/product-mock-2.webp',
            '/assets/images/products/product-mock-3.webp',
            '/assets/images/products/product-mock-1.webp',
            '/assets/images/products/product-mock-2.webp',
            '/assets/images/products/product-mock-3.webp',
            '/assets/images/products/product-mock-1.webp',
        ],
    ],
    [
        'id' => 3,
        'link' => '/catalog/category/product/',
        'title' => 'Вахтовый автобус Shacman X3000, 28 мест',
        'desc' => '6х6, 300 л.с., Евро-5, КПП 154, без КМУ, рабочий + жилой отсеки, станок точильно-шлифовальный, станок сверлильный, насос, сварочное оборудование',
        'category' => 'Вахтовые автобусы и ГПА',
        'sku' => 'Артикул',
        'price' => '14 099 999 ₽',
        'oldPrice' => '13 265 000 ₽',
        'isNew' => true,
        'inStock' => true,
        'isSale' => true,
        'images' => [
            '/assets/images/products/product-mock-3.webp',
        ],
    ],
    [
        'id' => 4,
        'link' => '/catalog/category/product/',
        'title' => 'Вахтовый автобус Урал NEXT 4320-6952-72 (Е5) Г38, 28 мест',
        'desc' => '6×6, 12,72 тн, дв. 300 л.с., КПП ZF9, фургон L=3750 мм, КМУ ИМ-50 (4,4 тн/м, 2000 кг на 2,2 м, 740 кг на 6,0 м), 6 мест, отсек для перевозки, платформа с откидным бортом, верстак, выпрямитель сварочный, насос НМШ-2-40, генератор',
        'category' => 'Вахтовые автобусы и ГПА',
        'sku' => 'Артикул',
        'toOrder' => true,
        'isNew' => true,
        'inStock' => true,
        'isSale' => true,
        'images' => [
            '/assets/images/products/product-mock-1.webp',
        ],
    ],
];
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: $this->cat->name ?? '',
); ?>

<main>
    <?php
    App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

    if ($cnt) {
        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: $this->cat->name ?? '',
            desc: 'Реализуем бортовые автомобили FAW с манипуляторами Инман, Palfinger, Kanglim, Sunhunk, АНТ. Предлагаем готовые варианты техники из наличия. Также вы можете составить свою комплектацию - проведем необходимые доработки и установим дополнительное оборудование.',
        );

        if ($videoReviewsSlides) {
            App\Layout\Components\Common\SliderSections\VideoReviewsSlider\Layout::draw([
                'title' => 'Видео-обзоры нашей техники',
                'slides' => $videoReviewsSlides
            ]);
        }

        App\Layout\Components\Unique\FastFilter\Layout::drawFastFilter(
            className: 'categories-filter'
        );

        if ($catalogCards) {
            App\Layout\Components\Common\CatalogList\Layout::drawCatalogList(
                title: 'Основные модели',
                cards: $catalogCards,
            );
        }

        if ($catalogCards) {
            App\Layout\Components\Common\CatalogList\Layout::drawCatalogList(
                title: 'Полный каталог',
                groupTitle: 'АРОК с КМУ Sunhunk',
                cards: $catalogCards,
                isExpandable: true
            );
        }
    } else {
        App\Layout\Components\Unique\ErrorSection\Layout::drawErrorSection(
            icon: 'unique-error-colored',
            title: 'В категории нет товаров',
            description: 'Вернитесь в каталог, чтобы посмотреть другие категории',
        );
    }

    App\Layout\Components\Common\SliderSections\CasesSlider\Layout::draw([
        'title' => 'История поставок',
        'link' => '/cases/',
    ]);

    App\Layout\Components\Common\PromoSections\ContactsPromo\Layout::draw();

    App\Layout\Components\Common\PromoSections\ConsultationPromo\Layout::draw([
        'title' => $index['params']['index_form_title'],
        'desc' => $index['params']['index_form_desc'],
        'image' => $index['params']['index_form_image'],
    ]);

    App\Layout\Components\Common\PromoSections\SeoPromo\Layout::draw([
        'seo_title_1' => $content['params']['category_seo_title_1'],
        'seo_text_1' => $content['params']['category_seo_text_1'],
        'seo_title_2' => $content['params']['category_seo_title_2'],
        'seo_text_2' => $content['params']['category_seo_text_2'],
    ]);
    ?>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]);

App\Layout\Components\Modals\SortModal\Layout::draw();
App\Layout\Components\Modals\FilterModal\Layout::draw();
?>


