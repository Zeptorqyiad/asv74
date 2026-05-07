<?php

namespace App\Layout\Components\UI\Other\ButtonCompare;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawButtonCompare(
        string             $class = '',
        int                $productId = 0,
        int                $variantId = 0,
        ButtonCompareStyle $style = ButtonCompareStyle::Minimal,
        array              $attributes = []
    ): void
    {
        static::draw(compact(
                'class',
                'productId',
                'variantId',
                'attributes'
            ) + [
                'style' => $style->value,
            ]
        );
    }
}