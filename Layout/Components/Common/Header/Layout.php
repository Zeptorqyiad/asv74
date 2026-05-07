<?php

namespace App\Layout\Components\Common\Header;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawHeader(
        string $className = '',
        string $title = '',
        string $tapBarType = '',
        array  $tapBarMenu = [],
        array  $extra = [],
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'tapBarType',
                'tapBarMenu',
                'extra',
            )
        );
    }
}