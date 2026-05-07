<?php

namespace App\Layout\Components\Layouts\Product\ProductManagerInfo;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawProductMangerInfo(
        string $className = '',
        string $name = '',
        string $image = '',
        string $job = '',
        string $phone = '',
        string $email = '',
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'name',
                'image',
                'job',
                'phone',
                'email',
                'attributes',
            )
        );
    }
}