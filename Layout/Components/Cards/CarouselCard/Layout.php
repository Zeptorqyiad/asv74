<?php

namespace App\Layout\Components\Cards\CarouselCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCarouselCard(
        string $className = '',
        string $link = '',
        string $title = '',
        string $desc = '',
        string $image = '',
        string $video = '',
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'title',
                'desc',
                'image',
                'video',
            ) + [

            ]
        );
    }
}