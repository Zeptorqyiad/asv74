<?php

namespace App\Layout\Components\Layouts\Case\CaseFs;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCaseFs(
        string $class = '',
        string $title = '',
        array  $images = [],
    ): void
    {
        static::draw(compact(
                'class',
                'title',
                'images',
            )
        );
    }
}