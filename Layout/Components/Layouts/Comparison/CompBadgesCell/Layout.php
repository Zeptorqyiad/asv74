<?php

namespace App\Layout\Components\Layouts\Comparison\CompBadgesCell;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCompBadgesCell(
        string $className = '',
        bool   $toOrder = false,
        bool   $isNew = false,
        bool   $inStock = false,
        bool   $isSale = false,
    ): void
    {
        static::draw(compact(
                'className',
                'toOrder',
                'isNew',
                'inStock',
                'isSale',
            )
        );
    }
}