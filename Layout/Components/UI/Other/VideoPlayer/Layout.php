<?php

namespace App\Layout\Components\UI\Other\VideoPlayer;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawVideoPlayer(
        string $className = '',
        string $link = '',
        string $src = '',
        string $poster = '',
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'src',
                'poster',
                'attributes'
            )
        );
    }
}