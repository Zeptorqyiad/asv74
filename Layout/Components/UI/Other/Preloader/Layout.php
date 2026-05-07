<?php

namespace App\Layout\Components\UI\Other\Preloader;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawPreloader(
        string $className = '',
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'attributes',
            )
        );
    }
}