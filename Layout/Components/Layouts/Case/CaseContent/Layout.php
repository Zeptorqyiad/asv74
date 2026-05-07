<?php

namespace App\Layout\Components\Layouts\Case\CaseContent;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCaseContent(
        string $class = '',
        string $location = '',
        string $date = '',
        string $content = '',
        string $link = '',
    ): void
    {
        static::draw(compact(
                'class',
                'location',
                'date',
                'content',
                'link',
            )
        );
    }
}