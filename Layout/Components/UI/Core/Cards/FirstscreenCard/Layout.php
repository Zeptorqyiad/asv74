<?php

namespace App\Layout\Components\UI\Core\Cards\FirstscreenCard;


use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawFirstscreenCard(
        string           $className = '',
        string           $title = '',
        string           $text = '',
        array            $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'text',
                'attributes'
            ) + [
            ]
        );
    }
}