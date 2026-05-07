<div id="error-modal" class="modal error-modal" role="dialog" aria-modal="true">
    <div class="error-modal__container">
        <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
            className: 'error-modal__button-close',
            attributes: [
                'onclick' => 'modalManager.close("error-modal")',
            ]
        ); ?>
        <div class="error-modal__top">
            <svg class="error-modal__icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 56 56">
                <g filter="url(#error-modal-icon)" opacity=".8">
                    <rect width="28" height="24" x="24" y="28" fill="#FACBC8" rx="4"/>
                </g>
                <path stroke="#DB1E16" stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="m23 23 10 10m0-10L23 33m-2 10h14c2.8 0 4.2 0 5.27-.545a5 5 0 0 0 2.185-2.185C43 39.2 43 37.8 43 35V21c0-2.8 0-4.2-.545-5.27a5 5 0 0 0-2.185-2.185C39.2 13 37.8 13 35 13H21c-2.8 0-4.2 0-5.27.545a5 5 0 0 0-2.185 2.185C13 16.8 13 18.2 13 21v14c0 2.8 0 4.2.545 5.27a5 5 0 0 0 2.185 2.185C16.8 43 18.2 43 21 43Z"/>
                <defs>
                    <filter id="error-modal-icon" width="32" height="28" x="22" y="26" color-interpolation-filters="sRGB" filterUnits="userSpaceOnUse">
                        <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                        <feBlend in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
                        <feGaussianBlur result="effect1_foregroundBlur_10262_13698" stdDeviation="1"/>
                    </filter>
                </defs>
            </svg>

            <div class="error-modal__text">
                <h4 class="error-modal__title">Ошибка!</h4>
                <p class="error-modal__desc">
                    Не удалось отправить, повторите позже
                </p>
            </div>
        </div>
        <div class="error-modal__body">
            <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'error-modal__button w-full',
                text: 'Хорошо',
                attributes: [
                    'onclick' => 'modalManager.close("error-modal")',
                ]
            ); ?>
        </div>
    </div>
</div>