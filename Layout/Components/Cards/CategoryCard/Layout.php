<?php

namespace App\Layout\Components\Cards\CategoryCard;

use App\Layout\Components\Cards\CategoryCard\CategoryCardSize;
use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCategoryCard(
        string           $className = '',
        string           $link = '',
        string           $link2 = '',
        string           $image = '',
        string           $title = '',
        array            $subcategories = [],
        CategoryCardSize $size = CategoryCardSize::Medium,
        array            $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'link2',
                'image',
                'title',
                'subcategories',
                'attributes'
            ) + [
                'size' => $size->value
            ]
        );
    }
}