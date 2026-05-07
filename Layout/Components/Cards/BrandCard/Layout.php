<?php

namespace App\Layout\Components\Cards\BrandCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawBrandCard(
        string $className = '',
        string $link = '',
        string $name = '',
        string $image = '',
        string $badge = ''
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'name',
                'image',
                'badge',
            )
        );
    }
}