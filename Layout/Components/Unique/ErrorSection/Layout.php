<?php

namespace App\Layout\Components\Unique\ErrorSection;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawErrorSection(
        string $className = '',
        string $errorText = '',
        string $icon = '',
        string $title = '',
        string $description = '',

    ): void
    {
        static::draw(compact(
                'className',
                'errorText',
                'icon',
                'title',
                'description',
            )
        );
    }
}