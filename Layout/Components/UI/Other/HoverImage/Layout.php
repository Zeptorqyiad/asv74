<?php

namespace App\Layout\Components\UI\Other\HoverImage;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawHoverImage(
        string $class = '',
        array  $images = [],
        string $link = '',
        string $title = '',
        bool   $pagination = true,
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'class',
                'images',
                'link',
                'title',
                'pagination',
                'attributes'
            ) + [

            ]
        );
    }
}