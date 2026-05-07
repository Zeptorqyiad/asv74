<?php

namespace App\Layout\Components\UI\Core\Table;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawTable(
        string $className = '',
        string $title = '',
        string $id = 'param_id',
        array  $data = [],
        array  $values = [],
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'data',
                'values',
                'id',
                'attributes'
            )
        );
    }
}