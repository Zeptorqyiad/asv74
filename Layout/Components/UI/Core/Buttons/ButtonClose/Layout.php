<?php

namespace App\Layout\Components\UI\Core\Buttons\ButtonClose;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawButtonClose(
        string        $className = '',
        string        $text = '',
        string        $icon = 'close',
        array         $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'text',
                'icon',
                'attributes'
            )
        );
    }
}