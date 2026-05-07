<?php

namespace App\Layout\Components\Unique\InfoBlock;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawInfoBlock(
        string $className = '',
        string $title = '',
        string $text = '',
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'text',
            ) + [

            ]
        );
    }
}