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

$c = $_REQUEST['c'] ?? 0;

?>

<section class="category-grid">
    <div class="category-grid__container container">
        <?php
        if (!$c) {
            App\Layout\Components\UI\Core\TabList\Layout::drawTabList(
                className: 'category-grid__tab-list',
                tabs: $tabs,
            );
        } ?>

        <div class="category-grid__wrap">
            <?php if (!$c): ?>
                <?php foreach ($divs as $index => $div): ?>
                    <div class="category-grid__wrap-list <?= $index == 0 ? 'active' : '' ?>"
                         data-category="<?= $div->div_id ?>">
                        <?php
                        /** @var \App\Extensions\Site\Model\Category $category */
                        foreach ($div->getCategories() as $category) {
                            $children = $category->getChildren();
                            App\Layout\Components\Cards\CategoryCard\Layout::drawCategoryCard(
                                className: 'category-grid__card',
                                link: $children ? ('/categories/?c=' . $category->category_id) : ('/' . $category->path . '/'),
                                link2: $children ? ('/' . $category->path . '/') : '',
                                image: $category->photo ? '/uf/images/source/' . $category->photo : '',
                                title: $category->name ?? '',
                                subcategories: array_map(function ($sub) {
                                    return [
                                        'link' => $sub->path ?? '',
                                        'title' => $sub->name ?? '',
                                    ];
                                }, $children),
                                size: \App\Layout\Components\Cards\CategoryCard\CategoryCardSize::Large,
                            );
                        } ?>
                    </div>
                <?php endforeach; ?>
            <?php else: ?>
                <div class="category-grid__wrap-list active"
                     data-category="0">
                    <?php
                    $cat = \App\Extensions\Site\Model\Category::findOne(['category_id' => $c]);
                    /** @var \App\Extensions\Site\Model\Category $category */
                    foreach ($cat->getChildren() as $category) {
                        $children = $category->getChildren();
                        App\Layout\Components\Cards\CategoryCard\Layout::drawCategoryCard(
                            className: 'category-grid__card',
                            link: $children ? ('/categories/?c=' . $category->category_id) : ('/' . $category->path . '/'),
                            link2: $children ? ('/' . $category->path . '/') : '',
                            image: $category->photo ? '/uf/images/source/' . $category->photo : '',
                            title: $category->name ?? '',
                            subcategories: array_map(function ($sub) {
                                return [
                                    'link' => $sub->path ?? '',
                                    'title' => $sub->name ?? '',
                                ];
                            }, $children),
                            size: \App\Layout\Components\Cards\CategoryCard\CategoryCardSize::Large,
                        );
                    } ?>
                </div>
            <?php endif; ?>
        </div>

    </div>
</section>