<?php

namespace App\Layout\Components\Cards\ComplectCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawComplectCard(
        int    $productId = 0,
        int    $variantId = 0,
        string $className = '',
        string $link = '',
        string $title = '',
        string $desc = '',
        string $list = '',
        string $category = '',
        string $sku = '',
        string $price = '',
        string $oldPrice = '',
        bool   $toOrder = false,
        bool   $isNew = false,
        bool   $inStock = false,
        bool   $isSale = false,
        array  $images = [],
        array  $specs = [],
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
                'sku',
                'price',
                'oldPrice',
                'toOrder',
                'isNew',
                'inStock',
                'isSale',
                'images',
                'specs',
                'attributes'
            ) + [

            ]
        );
    }
}