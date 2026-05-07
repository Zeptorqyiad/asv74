<?php

namespace App\Layout\Components\Layouts\Service\ServiceFs;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawServiceFs(
        string $class = '',
        string $image = '',
        string $desc = '',
        array  $badges = [],
        array  $list = [],
        string $btnLink = '',
    ): void
    {
        static::draw(compact(
                'class',
                'image',
                'desc',
                'badges',
                'list',
                'btnLink',
            )
        );
    }
}
