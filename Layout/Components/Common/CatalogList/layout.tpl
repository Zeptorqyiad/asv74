<?php
/** @var array $data */

?>

<section class="catalog-list <?= $data['className'] ?? '' ?>">
    <div class="catalog-list__container container">
        <?php if ($data['title']): ?>
            <h2 class="catalog-list__title"><?= $data['title'] ?></h2>
        <?php endif; ?>

        <div class="catalog-list__group <?= $data['isExpandable'] ? '' : 'catalog-list__group--default' ?> <?= $data['collapsed'] ? 'collapsed' : '' ?>">
            <button class="catalog-list__group-top">
                <h3><?= $data['groupTitle'] ?></h3>
                <?= renderIcon('chevron-up') ?>
            </button>

            <div class="catalog-list__group-body">
                <div class="catalog-list__group-cards catalog-list__group-cards--desktop">
                    <?php foreach ($data['cards'] as $card) {
                        \App\Layout\Components\Cards\CatalogCard\Layout::drawCatalogCard(
                            productId: $card['productId'] ?? 0,
                            variantId: $card['variantId'] ?? 0,
                            className: 'catalog-list__card catalog-list__card--desktop',
                            link: $card['link'] ?? '',
                            title: $card['title'] ?? '',
                            desc: $card['desc'] ?? '',
                            category: $card['category'] ?? '',
                            sku: $card['sku'] ?? '',
                            price: $card['price'] ?? '',
                            oldPrice: $card['oldPrice'] ?? '',
                            toOrder: $card['toOrder'] ?? false,
                            isNew: $card['isNew'] ?? false,
                            inStock: $card['inStock'] ?? false,
                            isSale: $card['isSale'] ?? false,
                            fabric: $card['fabric'] ?? '',
                            chassisDep: $card['chassisDep'] ?? false,
                            images: $card['images'] ?? [],
                            specs: $card['specs'] ?? [],
                            attributes: [
                                'data-product-id' => $card['id'] ?? '',
                            ]
                        );
                        App\Layout\Components\UI\Core\Separator\Layout::drawSeparator();
                    } ?>
                </div>

                <div class="catalog-list__group-cards catalog-list__group-cards--mobile">
                    <?php foreach ($data['cards'] as $card) {
                        \App\Layout\Components\Cards\ProductCard\Layout::drawProductCard(
                            productId: $card['productId'] ?? 0,
                            variantId: $card['variantId'] ?? 0,
                            className: 'catalog-list__card catalog-list__card--mobile',
                            link: $card['link'] ?? '',
                            title: $card['title'] ?? '',
                            desc: $card['desc'] ?? '',
                            category: $card['category'] ?? '',
                            sku: $card['sku'] ?? '',
                            price: $card['price'] ?? '',
                            oldPrice: $card['oldPrice'] ?? '',
                            toOrder: $card['toOrder'] ?? false,
                            isNew: $card['isNew'] ?? false,
                            inStock: $card['inStock'] ?? false,
                            isSale: $card['isSale'] ?? false,
                            fabric: $card['fabric'] ?? '',
                            chassisDep: $card['chassisDep'] ?? false,
                            images: $card['images'] ?? [],
                            specs: $card['specs'] ?? [],
                            attributes: [
                                'data-product-id' => $card['id'] ?? '',
                            ]
                        );
                    } ?>
                </div>

                <?php /* if ($data['pagination']): ?>
                    <div class="catalog-list__pagination">
                        <?php
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'catalog-list__button-pagination',
                            text: 'Показать ещё',
                            icon: 'chevron-down-sm',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                            iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                        );
                        ?>
                    </div>
                <?php endif; */ ?>

                <?php if ($data['pagination']):
                    App\Layout\Components\UI\Other\Pagination\Layout::drawPages(...$data['pagination']);
                endif; ?>
            </div>
        </div>
    </div>
</section>