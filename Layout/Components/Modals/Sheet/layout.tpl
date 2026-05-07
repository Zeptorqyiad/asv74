<?php
/** @var array $data */

$divs = \App\Extensions\Site\Model\CategoryDiv::find(['is_active' => 1]);
$tabs = array_map(fn(\App\Extensions\Site\Model\CategoryDiv $div) => [
    'icon' => $div->icon,
    'title' => $div->name,
    'attributes' => [
        'data-category' => $div->div_id
    ]
], $divs);

$addCats = [];
if (\App\Extensions\Catalog\Model\Stock::findOne('available > 0')) {
    $addCats[] = [
        'title' => 'Техника в наличии',
        'link' => '/catalog/?stock=1',
        'image' => '/assets/images/icons/icon-unique-check.svg'
    ];
}

if (\App\Extensions\Site\Model\Product::findOne('is_new = 1')) {
    $addCats[] = [
        'title' => 'Новые модели',
        'link' => '/catalog/?new=1',
        'image' => '/assets/images/icons/icon-unique-sale.svg'
    ];
}

if (\Simflex\Core\DB::result('select count(*) from catalog_sale where is_active = 1 and is_running = 1', 0) > 0) {
    $addCats[] = [
        'title' => 'Акции и специальные предложения',
        'link' => '/catalog/?discount=1',
        'image' => '/assets/images/icons/icon-unique-star.svg'
    ];
}
?>

<div class="sheet" id="sheet" role="dialog" aria-modal="true" aria-labelledby="sheet-title" aria-label="Каталог">
    <div class="sheet__container container">
        <div class="sheet__body">
            <div class="sheet__nav">
                <?php App\Layout\Components\UI\Core\TabList\Layout::drawTabList(
                    className: 'sheet__tab-list',
                    tabs: $tabs,
                ); ?>
            </div>

            <div class="sheet__categories" data-simplebar>
                <?php foreach ($divs as $index => $div): ?>
                    <div class="sheet__cat-list <?= $index == 0 ? 'active' : '' ?>" data-category="<?= $div->div_id ?>">
                        <?php foreach ($div->getCategories() as $category) {
                            App\Layout\Components\Cards\CategoryCard\Layout::drawCategoryCard(
                                className: 'sheet__card',
                                link: !!$category->getChildren() ? ('/categories/?c=' . $category->category_id) : ('/' . $category->path . '/'),
                                image: $category->photo ? '/uf/images/source/' . $category->photo : '',
                                title: $category->name ?? '',
                                size: \App\Layout\Components\Cards\CategoryCard\CategoryCardSize::Small,
                            );
                        } ?>
                    </div>
                <?php endforeach; ?>

            </div>
        </div>

        <div class="sheet__aside">
            <?php foreach ($addCats as $cat) {
                App\Layout\Components\Cards\CategoryCard\Layout::drawCategoryCard(
                    className: 'sheet__card-cat',
                    link: $cat['link'] ?? '',
                    image: $cat['image'] ?? '',
                    title: $cat['title'] ?? '',
                    size: \App\Layout\Components\Cards\CategoryCard\CategoryCardSize::ExtraSmall,
                );
            } ?>
        </div>
    </div>
</div>