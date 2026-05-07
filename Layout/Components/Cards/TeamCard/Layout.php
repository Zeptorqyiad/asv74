<?php

namespace App\Layout\Components\Cards\TeamCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawTeamCard(
        string $class = '',
        string $name = '',
        string $job = '',
        string $image = '',
    ): void
    {
        static::draw(compact(
                'class',
                'name',
                'job',
                'image',
            )
        );
    }
}