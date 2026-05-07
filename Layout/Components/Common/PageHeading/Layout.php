<?php

namespace App\Layout\Components\Common\PageHeading;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawPageHeading(
        string $className = '',
        string $link = '',
        string $title = '',
        string $desc = '',
        string $promoHD = '',
        string $promoMob = '',
        bool   $button = true,
        array  $links = []
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'title',
                'desc',
                'promoHD',
                'promoMob',
                'button',
                'links',
            )
        );
    }
}