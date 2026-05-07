<div class="cookie-modal active" id="cookie" role="dialog" aria-label="Куки">
    <div class="cookie-modal__container container">
        <div class="cookie-modal__description">
            <p class="cookie-modal__title">Сайт использует Cookie</p>
            <p class="cookie-modal__text">Мы отслеживаем различные метрики для того, чтобы сделать сайт лучше. Используя сайт, вы даёте согласие на работу с этими файлами.</p>
        </div>
        <?php
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'cookie-modal__submit',
            text: 'Соглашаюсь',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
        ); ?>
    </div>
</div>