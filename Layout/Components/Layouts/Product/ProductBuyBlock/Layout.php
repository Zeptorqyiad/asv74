<?php

namespace App\Layout\Components\Layouts\Product\ProductBuyBlock;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawProductBuyBlock(
        string $className = '',
        string $price = '',
        string $oldPrice = '',
        string $sku = '',
        bool   $toOrder = false,
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'price',
                'oldPrice',
                'sku',
                'toOrder',
                'attributes',
            )
        );
    }
}