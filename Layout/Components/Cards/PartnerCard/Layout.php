<?php

namespace App\Layout\Components\Cards\PartnerCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawPartnerCard(
        string $className = '',
        string $image = '',
        string $title = '',
        string $desc = ''
    ): void
    {
        static::draw(compact(
                'className',
                'image',
                'title',
                'desc',
            )
        );
    }
}