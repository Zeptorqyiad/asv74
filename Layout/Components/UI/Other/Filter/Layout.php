<?php

namespace App\Layout\Components\UI\Other\Filter;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawFilter(
        string     $className = '',
        string     $title = '',
        string     $groupName = '',
        FilterType $type = FilterType::Switch,
        array      $data = []
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'groupName',
                'data'
            ) + [
                'type' => $type->value,
            ]
        );
    }
}