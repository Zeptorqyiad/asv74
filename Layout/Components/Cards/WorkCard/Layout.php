<?php

namespace App\Layout\Components\Cards\WorkCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawWorkCard(
        string $class = '',
        string $title = '',
        string $desc = '',
        string $image = '',
    ): void
    {
        static::draw(compact(
                'class',
                'title',
                'desc',
                'image',
            )
        );
    }
}