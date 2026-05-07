<?php

namespace App\Layout\Components\Layouts\Service\ServiceAbout;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawServiceAbout(
        string $class = '',
        string $title = '',
        string $image = '',
        array  $manager = [],
        array  $steps = [],
    ): void
    {
        static::draw(compact(
                'class',
                'title',
                'image',
                'manager',
                'steps'
            )
        );
    }
}
