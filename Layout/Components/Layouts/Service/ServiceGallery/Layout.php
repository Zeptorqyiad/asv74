<?php

namespace App\Layout\Components\Layouts\Service\ServiceGallery;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawServiceGallery(
        string $class = '',
        array  $images = [],
    ): void
    {
        static::draw(compact(
                'class',
                'images',
            )
        );
    }
}
