<?php

namespace App\Layout\Components\Cards\StaffCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawStaffCard(
        string $className = '',
        string $image = '',
        string $name = '',
        string $job = '',
        array $links = [],
    ): void
    {
        static::draw(compact(
                'className',
                'image',
                'name',
                'job',
                'links',
            )
        );
    }
}