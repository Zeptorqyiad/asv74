<?php
/** @var array $content */

$index = $content->loadFrom('/');
$prods = $this->prodToCat[$this->cur];
$productSlides = [];

if($prods):
    $productSlides = array_map(fn($prod) => [
        'productId' => $prod->product_id,
        'variantId' => 0,
        'link' => '/' . $prod->path . '/',
        'title' => $prod->name,
        'category' => $prod->getFirstCategory()->name,
        'sku' => $prod->sku,
        'toOrder' => $prod->is_popular,
        'isNew' => $prod->is_new,
        'inStock' => $prod->getAnyStockCount() > 0,
        'isSale' => $prod->inSale(),
        'images' => $prod->getImages(),
    ], $prods);
endif;
?>

<?php
App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'Сравнение',
    extra: [
        'cats' => $this->cats,
        'prodToCat' => $this->prodToCat,
    ]
);
App\Layout\Components\Layouts\Comparison\ComparisonSheet\Layout::draw([
    'slides' => $productSlides,
    'cats' => $this->cats,
    'prodToCat' => $this->prodToCat,
]);
?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: 'Сравнение',
        );

        if ($prods) {
            App\Layout\Components\Layouts\Comparison\ComparisonSection\Layout::draw([
                'slides' => $productSlides,
                'cats' => $this->cats,
                'prodToCat' => $this->prodToCat,
                'cp' => $this->cp,
                'cur' => $this->cur,
                'chcp' => $this->chcp,
                'acp' => $this->acp,
            ]);
        } else {
            App\Layout\Components\Unique\ErrorSection\Layout::drawErrorSection(
                icon: 'unique-error-colored',
                title: 'В сравнении пусто',
                description: 'Перейдите в каталог и добавьте товары в сравнение. Тогда они сохранятся на этой странице.',
            );
        }
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]); ?>