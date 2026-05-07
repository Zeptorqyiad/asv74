<?php

namespace App\Layout\Components\UI\Core\TabList;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawTabList(
        string $className = '',
        array  $tabs = [],
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'tabs',
                'attributes'
            )
        );
    }
}