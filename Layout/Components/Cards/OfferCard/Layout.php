<?php

namespace App\Layout\Components\Cards\OfferCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawOfferCard(
        string $className = '',
        string $link = '',
        string $image = '',
        string $title = '',
        bool $darkText = true,
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'image',
                'title',
                'darkText',
            )
        );
    }
}