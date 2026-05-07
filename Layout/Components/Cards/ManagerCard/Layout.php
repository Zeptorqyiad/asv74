<?php

namespace App\Layout\Components\Cards\ManagerCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawManagerCard(
        string $className = '',
        string $name = '',
        string $image = '',
        string $job = '',
        string $phone = '',
        string $email = '',
    ): void
    {
        static::draw(compact(
                'className',
                'name',
                'image',
                'job',
                'phone',
                'email',
            )
        );
    }
}