<?php

namespace App\Layout\Components\Cards\BlogCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawBlogCard(
        string $className = '',
        string $link = '',
        string $title = '',
        string $desc = '',
        string $image = '',
        string $date = '',
        string $category = '',
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'title',
                'desc',
                'image',
                'date',
                'category',
                'attributes'
            )
        );
    }
}