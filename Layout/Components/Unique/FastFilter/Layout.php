<?php

namespace App\Layout\Components\Unique\FastFilter;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawFastFilter(
        string $className = '',
        array  $attributes = [],
    ): void
    {
        static::draw(compact(
                'className',
                'attributes'
            ) + [

            ]
        );
    }
}