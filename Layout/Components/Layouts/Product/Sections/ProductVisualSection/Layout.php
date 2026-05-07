<?php

namespace App\Layout\Components\Layouts\Product\Sections\ProductVisualSection;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawProdVisual(
        string $title = '',
        array  $items = [],
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'title',
                'items',
                'attributes',
            )
        );
    }
}