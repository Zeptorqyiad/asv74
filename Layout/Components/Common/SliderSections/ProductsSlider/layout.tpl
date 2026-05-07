<?php
/** @var array $data */
?>

<section class="products-slider <?= $data['className'] ?>">

    <h2 class="section-title products-slider__title"><?= $data['title'] ?? 'Техника в наличии' ?></h2>

    <div class="products-slider__buttons">
        <?php if ($data['link']) {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'products-slider__button-link',
                text: 'Показать все',
                link: $data['link'],
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
            );
        }
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'products-slider__button-prev',
            icon: 'arrow-left',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        );
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'products-slider__button-next',
            icon: 'arrow-right',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        ); ?>
    </div>

    <div class="products-slider__slider-wrap">
        <div class="products-slider__slider">
            <div class="swiper-wrapper">
                <?php foreach ($data['slides'] as $s) {
                    App\Layout\Components\Cards\ProductCard\Layout::drawProductCard(
                        productId: $s->product_id ?? 0,
                        variantId: $s->variantId ?? 0,
                        className: 'swiper-slide',
                        link: '/' . $s->path . '/',
                        title: $s->name ?? '',
                        desc: '', // $s->desc
                        list: 'Слайдер продуктов',
                        category: $s->getFirstCategory() ? $s->getFirstCategory()->name : '',
                        sku: $s->sku ?? '',
                        price: $s->price,
                        oldPrice: $s->price_old,
                        toOrder: $s->is_popular ?? false,
                        isNew: $s->is_new ?? false,
                        inStock: $s->getAnyStockCount() > 0,
                        isSale: $s->inSale(),
                        fabric: $s->fabric ?? '',
                        chassisDep: $s->chassis_dependent ?? false,
                        images: $s->getImages(),
                        specs: $s->getFullSpecs(),
                    );
                } ?>
            </div>
        </div>
    </div>
</section>