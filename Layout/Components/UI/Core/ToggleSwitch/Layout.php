<?php

namespace App\Layout\Components\UI\Core\ToggleSwitch;


use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawToggle(
        string         $className = '',
        string         $text = '',
        string         $tooltip = '',
        bool           $icon = true,
        ToggleSize     $size = ToggleSize::Medium,
        ToggleTheme    $theme = ToggleTheme::Light,
        TogglePosition $position = TogglePosition::Left,
        array          $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'text',
                'tooltip',
                'icon',
                'attributes'
            ) + [
                'size' => $size->value,
                'theme' => $theme->value,
                'position' => $position->value
            ]
        );
    }
}