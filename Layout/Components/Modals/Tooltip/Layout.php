<?php

namespace App\Layout\Components\Modals\Tooltip;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawTooltip(
        string     $class = '',
        string     $triggerText = '',
        string     $contentText = '',
        bool       $icon = true,
        bool       $isButton = true,
        TooltipPos $position = TooltipPos::Right,
        array      $attributes = [],
    ): void
    {
        static::draw(compact(
                'class',
                'triggerText',
                'contentText',
                'icon',
                'attributes'
            ) + [
                'position' => $position->value
            ]
        );
    }
}