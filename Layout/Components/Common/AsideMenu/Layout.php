<?php

namespace App\Layout\Components\Common\AsideMenu;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawAsideMenu(
        string $className = '',
        array  $tabs = [],
        bool   $noFollow = false,
    ): void
    {
        static::draw(compact(
                'className',
                'tabs',
                'noFollow',
            )
        );
    }
}