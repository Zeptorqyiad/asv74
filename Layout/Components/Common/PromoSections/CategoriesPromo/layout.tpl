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

$subCats = [
    [
        'title' => 'Штанговые дизельные сваебойные молоты DD',
        'link' => '/catalog/',
        'image' => 'assets/images/categories/subcategory-mock-1.webp'
    ],
    [
        'title' => 'Запчасти для грузовых автомобилей MAN',
        'link' => '/catalog/',
        'image' => 'assets/images/categories/subcategory-mock-2.webp'
    ],
    [
        'title' => 'Крано-манипуляторные установки',
        'link' => '/catalog/',
        'image' => 'assets/images/categories/subcategory-mock-3.webp'
    ],
];
?>

<section class="categories-promo">
    <div class="categories-promo__container container">
        <h2 class="section-title categories-promo__title"><?= $data['title'] ?></h2>

        <div class="categories-promo__main">
            <?php App\Layout\Components\UI\Core\TabList\Layout::drawTabList(
                className: 'categories-promo__tab-list',
                tabs: $tabs,
            ); ?>

            <?php foreach ($divs as $index => $div): ?>
                <div class="categories-promo__cat-list <?= $index == 0 ? 'active' : '' ?>"
                     data-category="<?= $div->div_id ?>">
                    <?php foreach ($div->getCategories() as $category) {
                        App\Layout\Components\Cards\CategoryCard\Layout::drawCategoryCard(
                            className: 'categories-promo__card',
                            link: !!$category->getChildren() ? ('/categories/?c=' . $category->category_id) : ('/' . $category->path . '/'),
                            image: $category->photo ? '/uf/images/source/' . $category->photo : '',
                            title: $category->name ?? '',
                        );
                    } ?>
                </div>
            <?php endforeach; ?>
        </div>

    </div>
</section>