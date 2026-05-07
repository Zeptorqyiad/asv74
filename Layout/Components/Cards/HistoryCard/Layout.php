<?php

namespace App\Layout\Components\Cards\HistoryCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawHistoryCard(
        string $class = '',
        string $year = '',
    ): void
    {
        static::draw(compact(
                'class',
                'year',
            )
        );
    }
}