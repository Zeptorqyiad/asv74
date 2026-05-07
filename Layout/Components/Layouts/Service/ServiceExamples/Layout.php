<?php

namespace App\Layout\Components\Layouts\Service\ServiceExamples;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawServiceExamples(
        string $class = '',
        string $title = '',
        array  $slides = [],
    ): void
    {
        static::draw(compact(
                'class',
                'title',
                'slides'
            )
        );
    }
}
