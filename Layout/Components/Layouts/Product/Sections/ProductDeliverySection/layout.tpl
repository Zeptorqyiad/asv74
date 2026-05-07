<?php
/** @var array $data */
?>

<div class="product-delivery-section">
    <?php if ($data['delivery']): ?>
        <div class="product-delivery-section__container wrapper-sm js--prod-subsection" id="delivery_delivery" data-title="Доставка">
            <h4 class="product-delivery-section__title">Доставка</h4>

            <div class="product-delivery-section__body">
                <?php foreach ($data['delivery'] as $block): ?>
                    <div class="product-delivery-section__block">
                        <h5 class="product-delivery-section__block-title"><?= $block['title'] ?></h5>
                        <div class="product-delivery-section__block-text content">
                            <?= $block['text'] ?>
                        </div>
                    </div>
                <?php endforeach; ?>

                <a class="product-delivery-section__link" href="/info/delivery/">Подробнее о доставке</a>
            </div>
        </div>
    <?php endif; ?>

    <?php if ($data['payment']): ?>
        <div class="product-delivery-section__container wrapper-sm js--prod-subsection" id="delivery_pay" data-title="Оплата">
            <h4 class="product-delivery-section__title">Оплата</h4>

            <div class="product-delivery-section__body">
                <?php foreach ($data['payment'] as $block): ?>
                    <div class="product-delivery-section__block">
                        <h5 class="product-delivery-section__block-title"><?= $block['title'] ?></h5>
                        <div class="product-delivery-section__block-text content">
                            <?= $block['text'] ?>
                        </div>
                    </div>
                <?php endforeach; ?>

                <a class="product-delivery-section__link" href="/info/payment/">Подробнее об оплате</a>
            </div>
        </div>
    <?php endif; ?>
</div>