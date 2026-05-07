<?php

namespace App\Layout\Components\Cards\AddServiceCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawAddServiceCard(
        string $className = '',
        string $link = '',
        string $title = '',
        string $desc = '',
        string $image = '',
        array  $badges = [],
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'title',
                'desc',
                'image',
                'badges'
            )
        );
    }
}