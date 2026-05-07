<?php

namespace App\Layout\Components\Cards\SearchCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawSearchCard(
        int    $productId = 0,
        int    $variantId = 0,
        string $className = '',
        string $link = '',
        string $title = '',
        string $desc = '',
        string $list = '',
        string $category = '',
        string $image = '',
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'productId',
                'variantId',
                'className',
                'link',
                'title',
                'desc',
                'list',
                'category',
                'image',
                'attributes'
            ) + [

            ]
        );
    }
}