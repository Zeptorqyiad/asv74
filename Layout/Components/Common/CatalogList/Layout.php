<?php

namespace App\Layout\Components\Common\CatalogList;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCatalogList(
        string $className = '',
        string $title = '',
        string $groupTitle = '',
        array  $cards = [],
        array  $pagination = [],
        bool   $isExpandable = false,
        bool   $collapsed = true,
        array  $attributes = [],
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'groupTitle',
                'cards',
                'pagination',
                'isExpandable',
                'collapsed',
                'attributes'
            )
        );
    }
}