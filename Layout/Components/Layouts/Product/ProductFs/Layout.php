<?php

namespace App\Layout\Components\Layouts\Product\ProductFs;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawProductFs(
        int    $productId = 0,
        int    $variantId = 0,
        string $className = '',
        string $title = '',
        string $sku = '',
        string $price = '',
        string $oldPrice = '',
        bool   $toOrder = false,
        bool   $isNew = false,
        bool   $inStock = false,
        bool   $isSale = false,
        bool   $chassisDep = false,
        string $fabric = '',
        string $file = '',
        array  $images = [],
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'productId',
                'variantId',
                'className',
                'title',
                'sku',
                'price',
                'oldPrice',
                'toOrder',
                'isNew',
                'inStock',
                'isSale',
                'chassisDep',
                'fabric',
                'file',
                'images',
                'attributes',
            )
        );
    }
}