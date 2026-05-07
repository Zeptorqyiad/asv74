<?php

namespace App\Layout\Components\UI\Core\DualRangeSlider;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawRangeSlider(
        string  $className = '',
        int     $min = 0,
        int     $max = 100,
        ?string $minNow = null,
        ?string $maxNow = null,
        array   $attributes = [],
        string  $nameMin = '',
        string  $nameMax = '',
    ): void
    {
        static::draw(compact(
                'className',
                'min',
                'max',
                'minNow',
                'maxNow',
                'attributes',
                'nameMin',
                'nameMax',
            ) + [

            ]
        );
    }
}