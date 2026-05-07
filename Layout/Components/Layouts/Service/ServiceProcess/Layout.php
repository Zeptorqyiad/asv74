<?php

namespace App\Layout\Components\Layouts\Service\ServiceProcess;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawServiceProcess(
        string $class = '',
        string $title = '',
        array  $steps = [],
    ): void
    {
        static::draw(compact(
                'class',
                'title',
                'steps'
            )
        );
    }
}
