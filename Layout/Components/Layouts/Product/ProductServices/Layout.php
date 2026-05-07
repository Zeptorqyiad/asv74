<?php

namespace App\Layout\Components\Layouts\Product\ProductServices;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawProductServices(
        string $className = '',
        string $title = '',
        array $cards = [],
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'cards',
                'attributes',
            )
        );
    }
}