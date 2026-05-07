<?php
/** @var array $data */
$cats = App\Extensions\Blog\Model\BlogCategory::findAdv()->all();
$totalCount = App\Extensions\Blog\Model\BlogCategory::getTotalCount();

?>

<div class="blog-filter">
    <div class="blog-filter__container container">
        <div class="blog-filter__tabs">
            <?php
            App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                className: 'blog-filter__tab' . (!$data['cats'] ? ' active' : ''),
                text: 'Все',
                link: '/blog/',
                icon: 'unique-menu-line',
                size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
            );

            foreach ($cats as $cat) {
                if ($cat->getCount()) {
                    App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                        className: 'blog-filter__tab' . ($data['cats'] == $cat->bc_id ? ' active' : ''),
                        text: $cat->name,
                        link: '/blog/?c=' . $cat->bc_id,
                        size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                    );
                }
            }
            ?>
        </div>
    </div>
</div>