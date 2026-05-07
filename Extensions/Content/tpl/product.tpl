<?php
/** @var array $content */
/** @var \App\Extensions\Site\Model\Product $prod */
$prod = $this->prod;

use App\Extensions\Services\Model\Services;

$index = $content->loadFrom('/');

$deliveryInfo = self::getTableFrom('delivery_blocks', $content->loadFrom('/info/delivery/'));
$paymentInfo = self::getTableFrom('payment_blocks', $content->loadFrom('/info/payment/'));

$product = [
    'productId' => $prod->product_id,
    'variantId' => $_REQUEST['v'] ?? 0,

    'title' => $prod->name,
    'file' => '/api/prod/doc/?productId=' . $prod->product_id . '&addonId=' . $prod->addon_id,
    'sku' => $prod->sku ? ('Код: ' . $prod->sku) : '',
    'price' => $prod->price . ' ₽',
    'oldPrice' => $prod->price_old . ' ₽',

    'toOrder' => $prod->is_popular,
    'isNew' => $prod->is_new,
    'inStock' => $prod->getAnyStockCount() > 0,
    'isSale' => $prod->inSale(),
    'fabric' => $prod->fabric,
    'chassisDep' => $prod->chassis_dependent,

    'images' => json_decode($prod->photo, true)['v'] ?? [],
    'video' => $prod->video ? ('/uf/files/' . $prod->video) : '',
    'side_video' => $prod->side_video ? ('/uf/files/' . $prod->side_video) : '',
    'tour' => json_decode($prod->visualizer, true)['v'] ?? [],

    'seo_title_1' => $prod->seo_title,
    'seo_text_1' => $prod->seo,
    'seo_title_2' => $prod->seo_title2,
    'seo_text_2' => $prod->seo2,
];

if (!$prod->product_id && !$product['images'] && $prod->image) {
    $product['images'] = [
        [
            'order' => 0,
            'img' => '/uf/images/source/' . $prod->image,
            'video' => '',
        ]
    ];
}

$mgr = $prod->manager;
if (!$mgr) {
    foreach ($prod->getAllCategories() as $cat) {
        $mgr = \Simflex\Core\Models\User::findOne(['user_id' => $cat->manager_id]);
        if ($mgr) {
            break;
        }

        $par = $cat->getParent();
        while ($par) {
            $mgr = \Simflex\Core\Models\User::findOne(['user_id' => $par->manager_id]);
            if ($mgr) {
                break;
            }

            $par = $par->getParent();
        }
    }
}

$manager = $mgr ? [
    'name' => implode(' ', [$mgr->name, $mgr->last_name]),
    'image' => '/uf/images/source/' . $mgr->avatar,
    'job' => $mgr->job,
    'phone' => $mgr->phones,
    'email' => $mgr->email,
] : [];

$carSection = $prod->product_id ? (new \Simflex\Core\DB\AQ())->from('catalog_tech')
    ->leftJoin('catalog_tech_product', 'tech_id')
    ->leftJoin('catalog_tech_category', 'tech_id')
    ->where('product_id = ' . $prod->product_id . ' or category_id in (' . implode(',', array_map(fn($c) => $c->category_id, $prod->getAllCategories())) . ')')
    ->setModelClass(\App\Extensions\Site\Model\Tech::class)
    ->all() : [];
$chassisSection = \App\Extensions\Site\Model\Chassis::findOne(['chassis_id' => $prod->chassis_id]);
$equipmentSection = \App\Extensions\Site\Model\Addon::findOne(['addon_id' => $prod->addon_id]);

$certCards = array_map(fn($r) => [
    'text' => $r['name'],
    'link' => '/uf/files/' . $r['file'],
    'size' => \Simflex\Core\Helpers\Str::sizeToStr('/uf/files/' . $r['file'])
], $prod->getDocs());

$ottsCards = array_map(fn($r) => [
    'text' => $r['name'],
    'link' => '/uf/files/' . $r['file'],
    'size' => \Simflex\Core\Helpers\Str::sizeToStr('/uf/files/' . $r['file'])
], json_decode($prod->otts, true)['v'] ?? []);

$services = Services::findAdv()
    ->where(['is_active' => 1])
    ->andWhere(['is_on_home' => 1])
    ->orderBy('npp')
    ->all();

$productCompectSlides = array_map(fn(\App\Extensions\Site\Model\Product $prod) => [
    'productId' => $prod->product_id,
    'variantId' => 0,
    'link' => '/' . $prod->path . '/',
    'title' => $prod->name,
    'desc' => $prod->card_desc ?? implode(', ', array_filter(array_unique(array_merge(
        $prod->product_id ? \App\Extensions\Catalog\Model\ParamValue::getList($prod->product_id) : \App\Extensions\Site\Model\Addon\ParamValue::getList($prod->addon_id),
        $prod->chassis_id ? \App\Extensions\Site\Model\Chassis\ParamValue::getList($prod->chassis_id) : [],
        $prod->product_id && $prod->addon_id ? \App\Extensions\Site\Model\Addon\ParamValue::getList($prod->addon_id) : [],
    )))),
    'category' => $prod->getFirstCategory() ? $prod->getFirstCategory()->name : null,
    'sku' => $prod->sku,
    'toOrder' => $prod->is_popular,
    'isNew' => $prod->is_new,
    'inStock' => $prod->getAnyStockCount() > 0,
    'isSale' => $prod->inSale(),
    'chassisDep' => $prod->chassis_dependent,
    'images' => $prod->getImages(),
    'specs' => $prod->getFullSpecs(),
], $prod->getLinked2());

$arrSectionsAll = [
    'car' => [
        'title' => 'Основное',
        'is_show' => ($prod->desc ?: $prod->description) ||
            ($prod->product_id
                ? \App\Extensions\Catalog\Model\ParamValue::getList($prod->product_id)
                : \App\Extensions\Site\Model\Addon\ParamValue::getList($prod->addon_id)
            ) ||
            $prod->plan ||
            $prod->video ||
            $prod->getLinked2() ||
            $carSection
    ],
    'equipment' => [
        'title' => 'Оборудование',
        'is_show' => $equipmentSection && $prod->product_id
    ],
    'chassis' => [
        'title' => 'Шасси',
        'is_show' => $chassisSection
    ],
    'video' => [
        'title' => 'Видео-обзор',
        'is_show' => $product['video']
    ],
    'visualization' => [
        'title' => '3D-визуализация',
        'is_show' => $product['tour'] && !empty($product['tour'])
    ],
    'documents' => [
        'title' => 'Документы',
        'is_show' => $certCards || $ottsCards
    ],
    'complect' => [
        'title' => 'Другие комплектации',
        'is_show' => !empty($productCompectSlides)
    ],
    'delivery' => [
        'title' => 'Доставка и оплата',
        'is_show' => $deliveryInfo || $paymentInfo
    ],
];

$arrSections = array_filter($arrSectionsAll, fn($item) => $item['is_show']);
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: $product['title'] ?? '',
    tapBarType: 'product',
    tapBarMenu: $arrSections,
); ?>

<?php if ($product['side_video']) {
    App\Layout\Components\UI\Other\FloatingVideo\Layout::draw([
        'src' => $product['side_video'],
        'linkTo' => '#video-section'
    ]);
}
?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Layouts\Product\ProductHeading\Layout::drawProductHeading(
            productId: $product['productId'] ?? 0,
            variantId: $product['variantId'] ?? 0,
            title: $product['title'] ?? '',
            file: $product['file'] ?? '',
        );
        ?>

        <div class="product-layout container">
            <div class="product-layout__content">
                <?php
                App\Layout\Components\Layouts\Product\ProductFs\Layout::drawProductFs(
                    productId: $product['productId'] ?? 0,
                    variantId: $product['variantId'] ?? 0,
                    title: $product['title'] ?? '',
                    sku: $product['sku'] ?? '',
                    price: $product['price'] ?? 0,
                    oldPrice: $product['oldPrice'] ?? 0,
                    toOrder: $product['toOrder'] ?? true,
                    isNew: $product['isNew'] ?? false,
                    inStock: $product['inStock'] ?? false,
                    isSale: $product['isSale'] ?? false,
                    chassisDep: $product['chassisDep'] ?? false,
                    fabric: $product['fabric'] ?? '',
                    file: $product['file'] ?? '',
                    images: $product['images'] ?? [],
                );

                App\Layout\Components\Layouts\Product\ProductBuyBlock\Layout::drawProductBuyBlock(
                    className: 'product-layout__buy-block',
                    price: $product['price'] ?? 0,
                    oldPrice: $product['oldPrice'] ?? 0,
                    sku: $product['sku'] ?? '',
                    toOrder: $product['toOrder'] ?? true,
                );

                if ($manager) {
                    App\Layout\Components\Layouts\Product\ProductManagerInfo\Layout::drawProductMangerInfo(
                        className: 'product-layout__manager-info',
                        name: $manager['name'] ?? '',
                        image: $manager['image'] ?? '',
                        job: $manager['job'] ?? '',
                        phone: $manager['phone'] ?? '',
                        email: $manager['email'] ?? '',
                    );
                }
                ?>

                <?php if($arrSections):
                    foreach ($arrSections as $key => $value):
                        $className = 'product-layout__group js--prod-group';

                        switch ($key):
                            case 'car': $className .= ' product-layout__group--top'; break;
                            case 'equipment': $className .= ''; break;
                            default: $className .= ' collapsed';
                        endswitch;
                        ?>
                        <section
                            class="<?= $className ?>"
                            id="<?= $key . '-section' ?>"
                        >
                            <button class="product-layout__group-top">
                                <h3><?= $value['title'] ?></h3>
                                <?= renderIcon('chevron-up') ?>
                            </button>
                            <div class="product-layout__group-body">
                                <?php switch ($key):
                                    case 'car':
                                        App\Layout\Components\Layouts\Product\Sections\ProductCarSection\Layout::draw([
                                            'prod' => $prod,
                                            'o' => $carSection
                                        ]); break;
                                    case 'chassis':
                                        App\Layout\Components\Layouts\Product\Sections\ProductChassisSection\Layout::draw([
                                            'prod' => $prod,
                                            'c' => $chassisSection,
                                        ]); break;
                                    case 'equipment':
                                        App\Layout\Components\Layouts\Product\Sections\ProductEquipSection\Layout::draw([
                                            'a' => $equipmentSection,
                                            'o' => $prod->product_id ? (new \Simflex\Core\DB\AQ())->from('catalog_option')
                                                ->leftJoin('catalog_option_addon', 'option_id')
                                                ->leftJoin('catalog_option_product', 'option_id')
                                                ->leftJoin('catalog_option_category', 'option_id')
                                                ->where('addon_id = ' . $equipmentSection->addon_id . ' or ' . 'product_id = ' . $prod->product_id . ' or category_id in (' . implode(',', array_map(fn($c) => $c->category_id, $prod->getAllCategories())) . ')')
                                                ->setModelClass(\App\Extensions\Site\Model\Option::class)
                                                ->all() : []
                                        ]); break;
                                    case 'video':
                                        App\Layout\Components\Layouts\Product\Sections\ProductVideoSection\Layout::drawProdVideo(
                                            title: $product['title'] ?? '',
                                            src: $product['video'] ?? '',
                                        ); break;
                                    case 'visualization':
                                        App\Layout\Components\Layouts\Product\Sections\ProductVisualSection\Layout::drawProdVisual(
                                            items: $product['tour'],
                                        ); break;
                                    case 'documents':
                                        App\Layout\Components\Layouts\Product\Sections\ProductDocsSection\Layout::draw([
                                            'certCards' => $certCards,
                                            'ottsCards' => $ottsCards,
                                        ]); break;
                                    case 'complect':
                                        App\Layout\Components\Layouts\Product\Sections\ProductComplectSection\Layout::draw([
                                            'title' => $arrSections[$key]['title'],
                                            'slides' => $productCompectSlides,
                                        ]); break;
                                    case 'delivery':
                                        App\Layout\Components\Layouts\Product\Sections\ProductDeliverySection\Layout::draw([
                                            'delivery' => $deliveryInfo,
                                            'payment' => $paymentInfo
                                        ]); break;
                                endswitch; ?>
                            </div>
                        </section>
                    <?php endforeach;
                endif; ?>
            </div>

            <aside class="product-layout__aside">
                <?php
                App\Layout\Components\Layouts\Product\ProductBuyBlock\Layout::drawProductBuyBlock(
                    className: 'product-layout__aside-buy-block',
                    price: $product['price'] ?? 0,
                    oldPrice: $product['oldPrice'] ?? 0,
                    sku: $product['sku'] ?? '',
                    toOrder: $product['toOrder'] ?? true,
                );

                if ($manager) {
                    App\Layout\Components\Layouts\Product\ProductManagerInfo\Layout::drawProductMangerInfo(
                        className: 'product-layout__aside-manager-info',
                        name: $manager['name'] ?? '',
                        image: $manager['image'] ?? '',
                        job: $manager['job'] ?? '',
                        phone: $manager['phone'] ?? '',
                        email: $manager['email'] ?? '',
                    );
                }
                ?>
            </aside>
        </div>

        <?php
        if ($services) {
            App\Layout\Components\Common\PromoSections\ServicesPromo\Layout::draw([
                'title' => 'Услуги',
                'cards' => $services,
            ]);
        }

        if ($prod->product_id) {
            $products = $prod->getFirstCategory()->getProducts('10', 'npp', 't.product_id <> ' . $prod->product_id);
        } else {
            $products = $prod->getFirstCategory()->getProducts('10', 'npp', 't.product_id is null and t.addon_id <> ' . $prod->addon_id);
        }

        if ($products) {
            App\Layout\Components\Common\SliderSections\ProductsSlider\Layout::draw([
                'title' => 'Похожая техника',
                'slides' => $products
            ]);
        }

        App\Layout\Components\Common\PromoSections\ConsultationPromo\Layout::draw([
            'title' => $index['params']['index_form_title'],
            'desc' => $index['params']['index_form_desc'],
            'image' => $index['params']['index_form_image'],
        ]);

        if ($product['seo_title_1'] || $product['seo_text_1'] || $product['seo_title_2'] || $product['seo_text_2']) {
            App\Layout\Components\Common\PromoSections\SeoPromo\Layout::draw([
                'seo_title_1' => $product['seo_title_1'] ?? '',
                'seo_text_1' => $product['seo_text_1'] ?? '',
                'seo_title_2' => $product['seo_title_2'] ?? '',
                'seo_text_2' => $product['seo_text_2'] ?? '',
            ]);
        }
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]); ?>