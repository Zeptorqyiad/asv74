<?php

namespace App\Layout\Components\UI\Core\TextArea;

use App\Layout\LayoutBase;

class Layout extends LayoutBase
{
    public static function drawTextArea(
        string           $className = '',
        string           $labelText = '',
        TextAreaLabelPos $labelPos = TextAreaLabelPos::Hidden,
        TextAreaStyle    $style = TextAreaStyle::Filled,
        TextAreaSize     $size = TextAreaSize::Medium,
        TextAreaTheme    $theme = TextAreaTheme::Light,
        string           $icon = '',
        bool             $reset = true,
        string           $id = '',
        array            $attributes = []
    ): void
    {
        static::draw(compact(
                'className',
                'labelText',
                'icon',
                'reset',
                'id',
                'attributes'
            ) + [
                'style' => $style->value,
                'labelPos' => $labelPos->value,
                'size' => $size->value,
                'theme' => $theme->value,
            ]
        );
    }
}