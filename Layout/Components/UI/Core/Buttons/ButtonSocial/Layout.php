<?php

namespace App\Layout\Components\UI\Core\Buttons\ButtonSocial;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawButtonSocial(
        string            $className = '',
        string            $link = '',
        ButtonSocialType  $type = ButtonSocialType::Telegram,
        ButtonSocialSize  $size = ButtonSocialSize::Medium,
        ButtonSocialTheme $theme = ButtonSocialTheme::Light,
        array             $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'link',
                'attributes'
            ) + [
                'type' => $type->value,
                'size' => $size->value,
                'theme' => $theme->value,
            ]
        );
    }
}