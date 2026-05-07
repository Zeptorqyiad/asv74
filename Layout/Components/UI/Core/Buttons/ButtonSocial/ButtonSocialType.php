<?php

namespace App\Layout\Components\UI\Core\Buttons\ButtonSocial;

enum ButtonSocialType: string
{
    case Vkontakte = 'vk';
    case Telegram = 'tg';
    case WhatsApp = 'wt';
    case Yandex = 'ya';
    case Instagram = 'in';
    case Google = 'go';
    case YouTube = 'yt';
    case RuTube = 'rt';
    case Max = 'max';
}