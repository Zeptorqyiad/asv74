<?php
/** @var array $content */

$index = $content->loadFrom('/');
$c = $this->cat;

$listCache = [];
$excludeP = [0];

if ($c->category_id) {
    $lists = \App\Extensions\Site\Model\ProductList::findAdv()
        ->leftJoin('catalog_product_list_c', 'list_id')
        ->where('category_id = ?')
        ->bind([$c->category_id])
        ->all();

    $lists = array_merge($lists, \App\Extensions\Site\Model\ProductList::findAdv()
        ->where('(select count(*) from catalog_product_list_c lc where lc.list_id = catalog_product_list.list_id) = 0')
        ->all());
}

$pf = $this->makeFilter();
$f = $this->makeSpecialFilter();
if ($f && $pf[0]) {
    $pf[0] = $f . ' AND ' . $pf[0];
}

if ($c->category_id) {
    foreach ($lists as $list) {
        $p2 = \App\Extensions\Site\Model\Product::listLookup($list->getId(), $pf, $this->sort, '10 offset ' . ((int)($_REQUEST['p_' . $list->id] ?? 0) * 10), array_merge([$c->category_id], $c->getAllChildren()));
        $p2Cnt = \App\Extensions\Site\Model\Product::listLookupCount($list->getId(), $pf, array_merge([$c->category_id], $c->getAllChildren()));

        if (!$p2Cnt) {
            continue;
        }

        foreach ($p2 as $p) {
            $excludeP[] = $p->getId();
        }

        $listCache[] = [
            'list' => $list,
            'p2' => $p2,
            'p2Cnt' => $p2Cnt,
        ];
    }
}

$hasFilters = true;
if (!trim($pf[0])) {
    $hasFilters = false;
    $pf[0] = ' t.is_primary = 1 AND t.product_id NOT IN (' . implode(',', $excludeP) . ')';
    $pf[6] = ' t.is_primary = 1';
}

if ($_REQUEST['stock'] == '1') {
    $pf[2] .= '1=0';
}

$cnt = $c->getProductCount($pf);
$pag = (int)($_REQUEST['page'] ?? 0);

$videoReviewsSlides = [];
$prods = $c->getProducts('10 offset ' . ($pag * 10), $this->sort, $pf);
foreach ($prods as $prod) {
    if ($prod->video) {
        $videoReviewsSlides[] = [
            'title' => $prod->name,
            'src' => '/uf/files/' . $prod->video,
            'poster' => ''
        ];
    }
}

$makeCardDesc = function ($p) {
    if ($p->card_desc) {
        return $p->card_desc;
    }

    $parts = [];
    $seen  = [];

    $specs = $p->getFullSpecs() ?: [];

    foreach (['c', 'a', 'p'] as $section) {
        if (empty($specs[$section])) {
            continue;
        }

        foreach ($specs[$section] as $group) {
            $groupName = $group['name'] ?? '';

            foreach ($group['values'] ?? [] as $item) {
                $name  = $item['name']  ?? '';
                $value = $item['value'] ?? '';

                if ($name === '' || $value === '') {
                    continue;
                }

                $value = trim(str_replace(['&nbsp;', "\xc2\xa0", "\u00A0"], ' ', $value));

                // Добавляем "л.с." к мощности
                if (stripos($name, 'мощность') !== false &&
                        stripos($value, 'л.с.') === false &&
                        stripos($value, 'кВт') === false) {
                    $value .= ' л.с.';
                }

                // Убираем дубли параметров
                $key = mb_strtolower(trim($name));
                if (isset($seen[$key])) {
                    continue;
                }
                $seen[$key] = true;

                $parts[] = $name . ': ' . '<strong>' . $value . '</strong>';
            }
        }
    }

    if ($parts) {
        return implode(' · ', array_slice($parts, 0, 14));
    }

    $fallback = array_filter(array_unique(array_merge(
            $p->product_id ? \App\Extensions\Catalog\Model\ParamValue::getList($p->product_id) : [],
            $p->chassis_id ? \App\Extensions\Site\Model\Chassis\ParamValue::getList($p->chassis_id) : [],
            $p->product_id && $p->addon_id ? \App\Extensions\Site\Model\Addon\ParamValue::getList($p->addon_id) : []
    )));

    return implode(', ', $fallback);
};

$catalogCards = array_map(fn($p) => [
    'productId' => $p->product_id,
    'variantId' => 0,
    'link' => '/' . $p->path . '/',
    'title' => $p->name,
    'category' => $p->getFirstCategory()->name,
    'sku' => $p->sku,
    'toOrder' => $p->is_popular,
    'isNew' => $p->is_new,
    'inStock' => $p->getAnyStockCount() > 0,
    'isSale' => $p->inSale(),
    'fabric' => $p->fabric,
    'chassisDep' => $p->chassis_dependent,
    'images' => $p->getImages(),
    'price' => $p->price,
    'oldPrice' => $p->price_old,
    'desc' => $makeCardDesc($p),
    'specs' => $p->getFullSpecs(),
], $prods);

$q = $_REQUEST['q'] ?? 0;
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: $this->cat->name ?? '',
); ?>

<main>
    <?php
    App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

    App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
        title: $this->cat->name ?? '',
        desc: $this->cat->short ?? '',
        promoHD: $content['params']['catalog_promo-image'],
        promoMob: $content['params']['catalog_promo-image_mob'],
    );

    if ($cnt && $videoReviewsSlides) {
        App\Layout\Components\Common\SliderSections\VideoReviewsSlider\Layout::draw([
            'title' => 'Видео-обзоры нашей техники',
            'slides' => $videoReviewsSlides
        ]);
    }

    if (!$q) {
        App\Layout\Components\Unique\FastFilter\Layout::draw([
            'className' => 'categories-filter',
            'attributes' => [],
            'c' => $c
        ]);
    }

    if ($cnt || ($lists && !$this->isSearch) || $c->category_id) {
        if ($catalogCards) {
            App\Layout\Components\Common\CatalogList\Layout::drawCatalogList(
                title: $this->isSearch ? '' : 'Основные модели',
                cards: $catalogCards,
                collapsed: false,
            );

            App\Layout\Components\UI\Other\Pagination\Layout::drawPages($pag, ceil($cnt / 10));
        }

        $isFirst = true;
        if ($c->category_id && !$hasFilters) {
            $pf[0] = ' t.is_primary = 0 AND t.product_id NOT IN (' . implode(',', $excludeP) . ')';
            $pf[6] = ' t.is_primary = 0';

            $p2 = $c->getProducts('10 offset ' . ((int)($_REQUEST['p_0'] ?? 0) * 10), $this->sort, $pf);
            $p2Cnt = $c->getProductCount($pf);
            $pageTabNum = (int)($_REQUEST['p_0'] ?? 0);

            if ($p2 && $p2Cnt) {
                App\Layout\Components\Common\CatalogList\Layout::drawCatalogList(
                    title: $isFirst ? 'Полный каталог' : '',
                    groupTitle: 'Вся продукция',
                    cards: array_map(fn(\App\Extensions\Site\Model\Product $p) => [
                        'productId' => $p->product_id,
                        'variantId' => 0,
                        'link' => '/' . $p->path . '/',
                        'title' => $p->name,
                        'desc' => $makeCardDesc($p),
                        'category' => $p->getFirstCategory()->name,
                        'sku' => $p->sku,
                        'toOrder' => $p->is_popular,
                        'isNew' => $p->is_new,
                        'inStock' => $p->getAnyStockCount() > 0,
                        'isSale' => $p->inSale(),
                        'fabric' => $p->fabric,
                        'chassisDep' => $p->chassis_dependent,
                        'images' => $p->getImages(),
                        'price' => $p->price,
                        'oldPrice' => $p->price_old,
                        'specs' => $p->getFullSpecs(),
                    ], $p2),
                    pagination: array($pageTabNum, $p2Cnt / 10, 'p_0'),
                    isExpandable: true,
                    collapsed: false,
                );

                $isFirst = false;
            }
        }

        if ($lists && !$hasFilters && !$this->isSearch) {
            foreach ($listCache as $lc) {
                [$list, $p2, $p2Cnt] = $lc;
                if (!$p2 || !$p2Cnt) {
                    continue;
                }

                $pageTabNum = (int)($_REQUEST['p_' . $list->id] ?? 0);

                App\Layout\Components\Common\CatalogList\Layout::drawCatalogList(
                    title: $isFirst ? 'Полный каталог' : '',
                    groupTitle: $list->name,
                    cards: array_map(fn(\App\Extensions\Site\Model\Product $p) => [
                        'productId' => $p->product_id,
                        'variantId' => 0,
                        'link' => '/' . $p->path . '/',
                        'title' => $p->name,
                        'desc' => $makeCardDesc($p),
                        'category' => $p->getFirstCategory()->name,
                        'sku' => $p->sku,
                        'toOrder' => $p->is_popular,
                        'isNew' => $p->is_new,
                        'inStock' => $p->getAnyStockCount() > 0,
                        'fabric' => $p->fabric,
                        'isSale' => $p->inSale(),
                        'chassisDep' => $p->chassis_dependent,
                        'images' => $p->getImages(),
                        'price' => $p->price,
                        'oldPrice' => $p->price_old,
                        'specs' => $p->getFullSpecs(),
                    ], $p2),
                    pagination: array($pageTabNum , $p2Cnt / 10, 'p_' . $list->id),
                    isExpandable: true,
                    collapsed: !$p2Cnt || $pageTabNum == 0,
                );

                $isFirst = false;
            }
        }
    } else {
        $emptyParams = array(
            'title' => 'В категории нет товаров',
            'description' => 'Вернитесь в каталог, чтобы посмотреть другие категории',
        );

        if ($q) {
            $emptyParams['title'] = 'По вашему запросу ничего не найдено';
            $emptyParams['description'] = 'Попробуйте ввести другой запрос или перейдите в каталог, чтобы ознакомиться с доступными товарами';
        }

        App\Layout\Components\Unique\ErrorSection\Layout::drawErrorSection(
            icon: 'unique-error-colored',
            title: $emptyParams['title'],
            description: $emptyParams['description'],
        );
    }

    App\Layout\Components\Common\SliderSections\CasesSlider\Layout::draw([
        'title' => 'История поставок',
        'link' => '/cases/',
        'c' => $c->category_id,
    ]);

    App\Layout\Components\Common\PromoSections\ContactsPromo\Layout::draw();

    App\Layout\Components\Common\PromoSections\ConsultationPromo\Layout::draw([
        'title' => $index['params']['index_form_title'],
        'desc' => $index['params']['index_form_desc'],
        'image' => $index['params']['index_form_image'],
    ]);

    App\Layout\Components\Common\PromoSections\SeoPromo\Layout::draw([
        'seo_title_1' => $c->seo_title,
        'seo_text_1' => $c->seo,
        'seo_title_2' => $c->seo_title2,
        'seo_text_2' => $c->seo2,
    ]);
    ?>
</main>

<?php
App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]);

App\Layout\Components\Modals\SortModal\Layout::draw();
App\Layout\Components\Modals\FilterModal\Layout::draw([
    'c' => $c,
    'cnt' => $cnt,
    'minp' => $this->min_price,
    'maxp' => $this->max_price,
    'th' => $this,
]);
?>


