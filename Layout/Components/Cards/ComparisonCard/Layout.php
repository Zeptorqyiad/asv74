<?php

namespace App\Layout\Components\Cards\ComparisonCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawComparisonCard(
        int    $productId = 0,
        int    $variantId = 0,
        string $className = '',
        string $link = '',
        string $title = '',
        string $price = '',
        string $oldPrice = '',
        bool   $toOrder = false,
        array  $images = [],
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'productId',
                'variantId',
                'className',
                'link',
                'title',
                'price',
                'oldPrice',
                'toOrder',
                'images',
                'attributes'
            ) + [

            ]
        );
    }
}