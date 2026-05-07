<?php

namespace App\Layout\Components\UI\Core\Chip;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawChip(
        string $className = '',
        string $text = '',
        array $attributes = [],
    ): void
    {
        static::draw(compact(
                'className',
                'text',
                'attributes'
            )
        );
    }
}