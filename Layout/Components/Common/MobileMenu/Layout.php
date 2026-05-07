<?php

namespace App\Layout\Components\Common\MobileMenu;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawMobileMenu(
        string $className = '',
        array  $tabs = [],

    ): void
    {
        static::draw(compact(
                'className',
                'tabs',
            )
        );
    }
}