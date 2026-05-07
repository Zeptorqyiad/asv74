<?php

namespace App\Layout\Components\Cards\CaseCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCaseCard(
        string $className = '',
        string $title = '',
        string $link = '',
        string $location = '',
        string $date = '',
        string $image = '',
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'link',
                'location',
                'date',
                'image',
            )
        );
    }
}