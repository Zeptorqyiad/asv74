<?php
/** @var array $data */
?>

<section class="blog-section">
    <div class="blog-section__container container">
        <?php
        foreach ($data['cards'] as $card) {
            $cat = $card->category->name;
            App\Layout\Components\Cards\BlogCard\Layout::drawBlogCard(
                link: '/blog/' . $card['alias'] . '/',
                title: $card['name'] ?? '',
                desc: $card['short'] ?? '',
                image: '/uf/images/source/' . $card['photo'] ?? '',
                date: $card['date'] ?? '',
                category: $cat ?? '',
            );
        }
        ?>
    </div>
</section>