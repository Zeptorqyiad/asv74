<?php

namespace App\Layout\Components\Cards\FileCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawFileCard(
        string $className = '',
        string $link = '',
        string $name = '',
        string $size = '',
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'name',
                'size',
            )
        );
    }
}