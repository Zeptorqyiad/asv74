<?php

namespace App\Layout\Components\Cards\YearCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawYearCard(
        string $class = '',
        string $title = '',
        string $descRowFirst = '',
        string $descRowSecond = '',
        string $descRowThird = '',
        string $descRowFourth = '',
        string $descRowFifth = '',
        string $image = '',
    ): void
    {
        static::draw(compact(
                'class',
                'title',
                'descRowFirst',
                'descRowSecond',
                'descRowThird',
                'descRowFourth',
                'descRowFifth',
                'image',
            )
        );
    }
}