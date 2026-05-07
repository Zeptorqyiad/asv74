<?php

namespace App\Layout\Components\UI\Core\Buttons\ButtonContact;

enum ButtonContactType: string
{
    case Standard = '';
    case Tel = 'tel:';
    case Mail = 'mailto:';

}