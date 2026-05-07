<?php

namespace App\Layout\Components\Cards\VideoReviewCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawVideoReviewCard(
        string $className = '',
        string $title = '',
        string $src = '',
        string $poster = '',
        string $link = ''
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'src',
                'poster',
                'link'
            )
        );
    }
}