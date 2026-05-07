<div id="success-modal" class="modal success-modal" role="dialog" aria-modal="true">
    <div class="success-modal__container">
        <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
            className: 'success-modal__button-close',
            attributes: [
                'onclick' => 'modalManager.close("success-modal")',
            ]
        ); ?>
        <div class="success-modal__top">
            <svg class="success-modal__icon" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 56 56">
                <g filter="url(#success-modal-icon)" opacity=".8">
                    <rect width="28" height="24" x="24" y="28" fill="#FACBC8" rx="4"/>
                </g>
                <path stroke="#DB1E16" stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="m17.999 33 3.333 3.333 7.5-7.5m-7.5-7.5v-4.666c0-1.867 0-2.8.363-3.514.32-.627.83-1.137 1.457-1.456.713-.364 1.646-.364 3.513-.364h12.667c1.867 0 2.8 0 3.513.364.627.32 1.138.83 1.457 1.456.363.713.363 1.647.363 3.514v12.666c0 1.867 0 2.8-.363 3.514a3.334 3.334 0 0 1-1.457 1.456c-.713.364-1.646.364-3.513.364h-4.667m-18 10h12.667c1.867 0 2.8 0 3.513-.364a3.334 3.334 0 0 0 1.457-1.456c.363-.714.363-1.647.363-3.514V26.667c0-1.867 0-2.8-.363-3.514a3.333 3.333 0 0 0-1.457-1.456c-.713-.364-1.646-.364-3.513-.364H16.665c-1.866 0-2.8 0-3.513.364-.627.32-1.137.83-1.457 1.456-.363.713-.363 1.647-.363 3.514v12.666c0 1.867 0 2.8.363 3.514.32.627.83 1.137 1.457 1.456.713.364 1.647.364 3.513.364Z"/>
                <defs>
                    <filter id="success-modal-icon" width="32" height="28" x="22" y="26" color-interpolation-filters="sRGB" filterUnits="userSpaceOnUse">
                        <feFlood flood-opacity="0" result="BackgroundImageFix"/>
                        <feBlend in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
                        <feGaussianBlur result="effect1_foregroundBlur_10262_2695" stdDeviation="1"/>
                    </filter>
                </defs>
            </svg>

            <div class="success-modal__text">
                <h4 class="success-modal__title">Успешно!</h4>
                <p class="success-modal__desc">
                    Ваша заявка успешно отправлена
                </p>
            </div>
        </div>
        <div class="success-modal__body">
            <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'success-modal__button w-full',
                text: 'Хорошо',
                attributes: [
                    'onclick' => 'modalManager.close("success-modal")',
                ]
            ); ?>
        </div>
    </div>
</div>