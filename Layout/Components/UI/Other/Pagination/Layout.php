<?php
namespace App\Layout\Components\UI\Other\Pagination;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawPages(
        int $page,
        int $pages,
        string $name = 'page',
    ): void
    {
        // don't render if there are no pages
        if ($pages <= 1) {
            return;
        }

        self::draw(compact('page', 'pages', 'name'));
    }
}