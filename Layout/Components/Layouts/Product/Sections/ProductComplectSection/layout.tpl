<?php
/** @var array $data */

$productSlides = $data['slides']
?>

<div class="product-complect-section">
    <?php if ($productSlides): ?>
        <div class="product-complect-section__container wrapper-sm">
            <h4 class="product-complect-section__title"><?= $data['title'] ?></h4>

            <div class="product-complect-section__variants product-complect-section__variants--desktop">
                <?php foreach ($productSlides as $slide) {
                    App\Layout\Components\Cards\ComplectCard\Layout::drawComplectCard(
                        productId: $slide['id'] ?? 0,
                        variantId: $slide['variantId'] ?? 0,
                        link: $slide['link'] ?? '',
                        title: $slide['title'] ?? '',
                        desc: $slide['desc'] ?? '',
                        category: $slide['category'] ?? '',
                        sku: $slide['sku'] ?? '',
                        price: $slide['price'] ?? '',
                        oldPrice: $slide['oldPrice'] ?? '',
                        toOrder: $slide['toOrder'] ?? false,
                        isNew: $slide['isNew'] ?? false,
                        inStock: $slide['isStock'] ?? false,
                        isSale: $slide['isSale'] ?? false,
                        images: $slide['images'] ?? [],
                        specs: $slide['specs'] ?? [],
                    );
                } ?>
            </div>

            <div class="product-complect-section__variants product-complect-section__variants--mobile js--product-variant-slider">
                <div class="swiper-wrapper">
                    <?php foreach ($productSlides as $slide) {
                        \App\Layout\Components\Cards\ProductCard\Layout::drawProductCard(
                            productId: $slide['id'] ?? 0,
                            variantId: $slide['variantId'] ?? 0,
                            className: 'swiper-slide',
                            link: $slide['link'] ?? '',
                            title: $slide['title'] ?? '',
                            desc: $slide['desc'] ?? '',
                            category: $slide['category'] ?? '',
                            sku: $slide['sku'] ?? '',
                            price: $slide['price'] ?? '',
                            oldPrice: $slide['oldPrice'] ?? '',
                            toOrder: $slide['toOrder'] ?? false,
                            isNew: $slide['isNew'] ?? false,
                            inStock: $slide['isStock'] ?? false,
                            isSale: $slide['isSale'] ?? false,
                            fabric: $slide['fabric'] ?? '',
                            images: $slide['images'] ?? [],
                            specs: $slide['specs'] ?? [],
                        );
                    } ?>
                </div>
            </div>
        </div>
    <?php endif; ?>
</div>