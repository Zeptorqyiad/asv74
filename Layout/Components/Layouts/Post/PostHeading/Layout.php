<?php

namespace App\Layout\Components\Layouts\Post\PostHeading;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawPostHeading(
        string $className = '',
        string $link = '',
        string $title = '',
        string $desc = '',
        string $date = '',
        string $category = '',
        int    $views = 0,
        int    $categoryId = 0,
        bool   $backButton = true,
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'title',
                'desc',
                'date',
                'category',
                'categoryId',
                'views',
                'backButton',
            )
        );
    }
}