<?php

namespace App\Layout\Components\Layouts\Product\Sections\ProductVideoSection;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawProdVideo(
        string $title = '',
        string $src = '',
        string $link = '',
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'title',
                'src',
                'link',
                'attributes',
            )
        );
    }
}