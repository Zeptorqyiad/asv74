<?php

namespace App\Layout\Components\UI\Core\Collapsible;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCollapsible(
        string $className = '',
        string $text = '',
        string $link = '',
        string $image = '',
        string $marker = '',
        string $badge = '',
        array  $options = [],
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'text',
                'link',
                'image',
                'marker',
                'badge',
                'options',
                'attributes'
            ) + [

            ]
        );
    }
}