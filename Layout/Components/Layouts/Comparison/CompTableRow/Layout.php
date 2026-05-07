<?php

namespace App\Layout\Components\Layouts\Comparison\CompTableRow;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCompTableRow(
        string $className = '',
        string $title = '',
        array  $columns = [],
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'columns',
            )
        );
    }
}