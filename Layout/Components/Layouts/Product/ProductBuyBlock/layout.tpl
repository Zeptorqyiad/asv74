<?php
/** @var array $data */

$tg = Simflex\Core\Core::siteParam('tg');
//$wt = Simflex\Core\Core::siteParam('whats_app');
$max_social = Simflex\Core\Core::siteParam('max_social');
?>

<div class="product-buy-block <?= $data['className'] ?>">

    <div class="product-buy-block__info">
        <?php if ($data['sku']): ?>
            <span class="product-buy-block__sku"><?= $data['sku'] ?></span>
        <?php endif; ?>

        <div class="product-buy-block__prices"
             itemprop="offers"
             itemscope
             itemtype="https://schema.org/Offer"
        >
            <meta itemprop="priceCurrency" content="RUB">

            <?php /* if ($data['toOrder'] || !(int)$data['price']): ?>
                <span class="product-buy-block__price product-buy-block__price--request">
                Узнайте цену сейчас
            </span>
            <?php endif; */?>

            <?php if ($data['oldPrice'] && $data['oldPrice'] != $data['price']): ?>
                <span class="product-buy-block__price product-buy-block__price--old">
                <?= $data['oldPrice'] ?>
            </span>
            <?php endif; ?>

            <?php if ((int)$data['price']): ?>
                <span class="product-buy-block__price product-buy-block__price--current" itemprop="price">
                    от <?= $data['price'] ?>
                </span>
            <?php else: ?>
                <span class="product-buy-block__price product-buy-block__price--request">
                    Узнайте цену сейчас
                </span>
            <?php endif; ?>
        </div>
    </div>

    <div class="product-buy-block__actions">
        <?php
        /*
        if ($data['toOrder'] && !$data['price']) {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'product-buy-block__button-order w-full',
                text: 'Узнать цену',
                attributes: [
                    'onclick' => 'modalManager.open("callback-modal"); tracker.track("request_form_open");',
                ]
            );
        }
        */

        if ($data['price']) {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'product-buy-block__button-order w-full',
                text: 'Узнать цену',
                attributes: [
                    'onclick' => 'modalManager.open("callback-modal"); tracker.track("order_form_open");',
                ]
            );
        } else {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'product-buy-block__button-order w-full',
                text: 'Узнать цену',
                attributes: [
                    'onclick' => 'modalManager.open("callback-modal"); tracker.track("request_form_open");',
                ]
            );
        }

        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'product-buy-block__button-leasing w-full',
            text: 'Выгодный лизинг',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
            attributes: [
                'onclick' => 'modalManager.open("callback-modal", {
                    type: "leasing",
                    title: "Оформить заявку на лизинг",
                    desc: "Заполните форму, чтобы узнать о доступных условиях лизинга на выбранную технику."
                }); 
                tracker.track("leasing_form_open");',
            ]
        ); ?>

        <?php if ($tg || $max_social): ?>
            <ul class="product-buy-block__social">
                <?php if ($tg): ?>
                    <li class="product-buy-block__social-item">
                        <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'product-buy-block__social--tg w-full',
                            text: 'Связаться',
                            link: $tg,
                            icon: 'social-mono-tg',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
                        ); ?>
                    </li>
                <?php endif; ?>

<!--                --><?php //if ($wt): ?>
<!--                    <li class="product-buy-block__social-item">-->
<!--                        --><?php //App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
//                            className: 'product-buy-block__social--wt w-full',
//                            text: 'Связаться',
//                            link: $wt,
//                            icon: 'social-mono-wt',
//                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
//                        ); ?>
<!--                    </li>-->
<!--                --><?php //endif; ?>

                <?php if ($max_social): ?>
                    <li class="product-buy-block__social-item">
                        <a href="<?= $max_social ?>" target="_blank" class="product-buy-block__social--max w-full">
                            <img src="/assets/images/Max.png" alt="">

                            Связаться
                        </a>
                    </li>
                <?php endif; ?>
            </ul>
        <?php endif; ?>

        <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'product-buy-block__button-about w-full',
            text: 'Подробнее о лизинге',
            link: '/info/leasing/',
            icon: 'info',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Flat,
            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::ExtraSmall,
        );
        ?>
    </div>
</div>