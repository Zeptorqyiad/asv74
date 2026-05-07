<?php

namespace App\Layout\Components\UI\Core\Buttons\ButtonContact;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawButtonContact(
        string             $className = '',
        string             $text = '',
        string             $link = '',
        ButtonContactStyle $style = ButtonContactStyle::Flat,
        ButtonContactSize  $size = ButtonContactSize::Medium,
        ButtonContactTheme $theme = ButtonContactTheme::Light,
        ButtonContactType  $type = ButtonContactType::Standard,
        array              $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'text',
                'link',
                'attributes'
            ) + [
                'style' => $style->value,
                'size' => $size->value,
                'theme' => $theme->value,
                'type' => $type->value,
            ]
        );
    }
}