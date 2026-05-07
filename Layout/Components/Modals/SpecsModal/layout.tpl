<?php
$data['toOrder'] = true;
?>

<div id="specs-modal" class="modal specs-modal" role="dialog" aria-modal="true">
    <div class="specs-modal__container">
        <?php App\Layout\Components\UI\Core\Buttons\ButtonClose\Layout::drawButtonClose(
            className: 'specs-modal__button-close',
            attributes: [
                'onclick' => 'modalManager.close("specs-modal");',
            ]
        ); ?>
        <div class="specs-modal__top">
            <h4 class="specs-modal__title">Характеристики</h4>
            <div class="specs-modal__desc">
                <div class="specs-modal__info">
                    <img class="specs-modal__info-image" src="/assets/images/products/product-mock-1.webp" alt=""
                         loading="lazy">

                    <div class="specs-modal__info-text">
                        <h5 class="specs-modal__info-title">
                            Вахтовый автобус Урал NEXT 4320-6952-72 (Е5) Г38, 28 мест
                        </h5>

                        <div class="specs-modal__info-prices">

                            <span class="specs-modal__price specs-modal__price--request">
                                Узнайте цену сейчас
                            </span>

                            <span class="specs-modal__price specs-modal__price--current" itemprop="price">
                                от <?= $data['price'] ?>
                            </span>


                            <span class="specs-modal__price specs-modal__price--old">
                                <?= $data['oldPrice'] ?>
                            </span>

                        </div>
                    </div>
                </div>

                <div class="specs-modal__actions">
                    <?php
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'specs-modal__button-order spec-a',
                        text: 'Узнать цену',
                        size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                        attributes: [
                            'onclick' => 'modalManager.open("callback-modal")',
                        ]
                    );

                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'specs-modal__button-order spec-b',
                        text: 'Оставить заявку',
                        size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                        attributes: [
                            'onclick' => 'modalManager.open("callback-modal")',
                        ]
                    );

                    App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                        className: 'specs-modal__button-about',
                        text: 'Подробнее',
                        link: '/catalog/category/product/',
                        style: \App\Layout\Components\UI\Core\Tab\TabStyle::Secondary,
                        size: \App\Layout\Components\UI\Core\Tab\TabSize::Small,
                    );
                    ?>
                </div>
            </div>
        </div>
        <div class="specs-modal__body-wrapper" data-simplebar>
            <div class="specs-modal__body">
                <?php
                \App\Layout\LayoutManager::useLayout(App\Layout\Components\UI\Core\Table\Layout::class); ?>
            </div>
        </div>
    </div>
</div>