<?php

namespace App\Layout\Components\Cards\CertificateCard;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawCertCard(
        string $className = '',
        string $title = '',
        string $image = '',
        array  $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'title',
                'image',
                'attributes'
            ) + [

            ]
        );
    }
}