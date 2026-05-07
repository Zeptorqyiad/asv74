<?php

namespace App\Layout\Components\Layouts\Post\PostContent;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawPostContent(
        int    $id = 0,
        string $className = '',
        string $content = '',
        string $views = '',
        string $date = '',
        int    $likes = 0,
        int    $dislikes = 0,
    ): void
    {
        static::draw(compact(
                'id',
                'className',
                'content',
                'views',
                'date',
                'likes',
                'dislikes',
            )
        );
    }
}