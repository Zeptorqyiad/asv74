<?php

namespace App\Layout\Components\Layouts\Product\ProductHeading;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawProductHeading(
        int    $productId = 0,
        int    $variantId = 0,
        string $className = '',
        string $title = '',
        string $file = '',
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'productId',
                'variantId',
                'className',
                'title',
                'file',
                'attributes',
            )
        );
    }
}