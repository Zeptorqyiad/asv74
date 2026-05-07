<?php

namespace App\Layout\Components\Cards\DepartmentCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawDepartmentCard(
        string $class = '',
        string $title = '',
        array  $list = [],
    ): void
    {
        static::draw(compact(
                'class',
                'title',
                'list',
            )
        );
    }
}