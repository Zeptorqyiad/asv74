<?php

namespace App\Layout\Components\Cards\ReviewCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawReviewCard(
        string $className = '',
        string $type = '',
        string $badgeText = '',
        string $title = '',
        string $file = '',
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'type',
                'badgeText',
                'title',
                'file',
                'attributes'
            ) + [

            ]
        );
    }
}