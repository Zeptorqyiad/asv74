<?php
$phone = Simflex\Core\Core::siteParam('phone');
$tg = Simflex\Core\Core::siteParam('tg');
//$wt = Simflex\Core\Core::siteParam('whats_app');
$max_social = Simflex\Core\Core::siteParam('max_social');

?>

<div id="not-found-modal" class="modal not-found-modal" role="dialog" aria-modal="true">
    <div class="not-found-modal__container">
        <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
            className: 'callback-modal__button-close',
            attributes: [
                'onclick' => 'modalManager.close("not-found-modal")',
            ]
        ); ?>
        <div class="not-found-modal__top">
            <div class="not-found-modal__head">
                <img class="not-found-modal__head--image"
                     src="/assets/images/default/not-found.png" alt="" />

                <div class="not-found-modal__head_rs">
                    <h4 class="not-found-modal__title">НЕ НАШЛИ, ЧТО ИСКАЛИ?</h4>
                    <p class="not-found-modal__subtitle">
                        Мы бесплатно поможем вам определиться с выбором спецтехники и ответим на любые вопросы
                    </p>
                </div>
            </div>

            <?php if ($phone || $tg || $max_social): ?>
                <div class="not-found-modal__contacts">
                    <?php if ($phone):
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'not-found-modal__phone w-full',
                            text: $phone,
                            link: 'tel:' . $phone,
                            icon: 'phone',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray
                        );
                    endif; ?>

                    <?php if ($tg || $max_social): ?>
                        <ul class="not-found-modal__social">
                            <?php if ($tg): ?>
                                <li class="not-found-modal__social-item">
                                    <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                                        className: 'not-found-modal__social--tg w-full',
                                        text: 'Связаться',
                                        link: $tg,
                                        icon: 'social-mono-tg',
                                        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
                                    ); ?>
                                </li>
                            <?php endif; ?>

                            <?php if ($max_social): ?>
                                <li class="not-found-modal__social-item">
                                    <a href="<?= $max_social ?>" target="_blank" class="not-found-modal__social--max w-full">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
                                            <defs>
                                                <radialGradient
                                                        id="max-gradient"
                                                        cx="0" cy="0" r="1"
                                                        gradientUnits="userSpaceOnUse"
                                                        gradientTransform="translate(25.9774 3.68132) rotate(-3.91438) scale(47.3802)">
                                                    <stop offset="0.068816" stop-color="#9F4FDC"/>
                                                    <stop offset="0.186949" stop-color="#6C2FDE"/>
                                                    <stop offset="0.279643" stop-color="#5130E8"/>
                                                    <stop offset="0.42667" stop-color="#214EFA"/>
                                                    <stop offset="0.673154" stop-color="#43BBFC"/>
                                                </radialGradient>
                                            </defs>
                                            <path
                                                    fill-rule="evenodd"
                                                    clip-rule="evenodd"
                                                    d="M11.2364 21.9372C9.07734 21.9372 8.074 21.6207 6.32997 20.3545C5.22682 21.7789 1.73352 22.8922 1.58118 20.9876C1.58118 19.5578 1.26599 18.3496 0.908784 17.0306C0.483284 15.4056 0 13.596 0 10.9739C0 4.71138 5.11651 0 11.1786 0C17.2459 0 21.9999 4.94352 21.9999 11.0319C22.0203 17.0262 17.2046 21.9052 11.2364 21.9372ZM11.3257 5.41308C8.37342 5.26008 6.07257 7.31241 5.56302 10.5307C5.14277 13.195 5.88871 16.4397 6.52434 16.6086C6.82901 16.6824 7.59597 16.0599 8.074 15.5798C8.86444 16.1282 9.78491 16.4576 10.7426 16.5347C13.8016 16.6825 16.4154 14.3435 16.6208 11.2746C16.7403 8.1992 14.3851 5.59435 11.3257 5.41836L11.3257 5.41308Z"
                                                    fill="url(#max-gradient)"/>
                                        </svg>

                                        Связаться
                                    </a>
                                </li>
<!--                                <li class="not-found-modal__social-item">-->
<!--                                    --><?php //App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
//                                        className: 'not-found-modal__social--wt w-full',
//                                        text: 'Связаться',
//                                        link: $wt,
//                                        icon: 'social-mono-wt',
//                                        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
//                                    ); ?>
<!--                                </li>-->
                            <?php endif; ?>
                        </ul>
                    <?php endif; ?>
                </div>
            <?php endif; ?>

            <p class="not-found-modal__desc">
                Заполните форму и наш менеджер свяжется с вами в течение 15 минут (в рабочее время)
            </p>
        </div>
        <div class="not-found-modal__body" data-simplebar>
            <?php App\Layout\Components\UI\Core\Form\Layout::draw([
                'form_placement' => 'Модальное окно'
            ]); ?>
        </div>
    </div>
</div>