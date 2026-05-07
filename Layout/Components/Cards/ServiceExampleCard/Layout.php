<?php

namespace App\Layout\Components\Cards\ServiceExampleCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawServiceExampleCard(
        string $class = '',
        string $image = '',
        string $title = '',
        string $desc = '',
        string $textRow1 = '',
        string $textRow2 = '',
        string $textRow3 = '',
        string $textRow4 = '',
        string $textRow5 = '',


    ): void
    {
        static::draw(compact(
                'class',
                'image',
                'title',
                'desc',
                'textRow1',
                'textRow2',
                'textRow3',
                'textRow4',
                'textRow5',
            )
        );
    }
}