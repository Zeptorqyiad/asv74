<?php

namespace App\Layout\Components\Cards\NewModelBanner;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawNewModelBanner(
        string $className = '',
        string $link = '',
        string $background = '',
        string $image = '',
        string $title = '',
        string $desc = '',
        bool   $toOrder = false,
        bool   $isNew = false,
        bool   $inStock = false,
        bool   $isSale = false,
        string $fabric = '',
        array  $badges = [],
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'background',
                'image',
                'title',
                'desc',
                'toOrder',
                'isNew',
                'inStock',
                'isSale',
                'fabric',
                'badges',
                'attributes'
            )
        );
    }
}