<?php

namespace App\Layout\Components\Cards\CatalogCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCatalogCard(
        int    $productId = 0,
        int    $variantId = 0,
        string $className = '',
        string $link = '',
        string $title = '',
        string $desc = '',
        string $list = '',
        string $category = '',
        string $sku = '',
        string $price = '',
        string $oldPrice = '',
        bool   $toOrder = false,
        bool   $isNew = false,
        bool   $inStock = false,
        bool   $isSale = false,
        string $fabric = '',
        bool   $chassisDep = false,
        array  $images = [],
        array  $specs = [],
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'productId',
                'variantId',
                'className',
                'link',
                'title',
                'desc',
                'list',
                'category',
                'sku',
                'price',
                'oldPrice',
                'toOrder',
                'isNew',
                'inStock',
                'isSale',
                'fabric',
                'chassisDep',
                'images',
                'specs',
                'attributes'
            ) + [

            ]
        );
    }
}