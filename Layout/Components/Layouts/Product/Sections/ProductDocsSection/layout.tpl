<?php
/** @var array $data */
?>

<div class="product-docs-section">
    <?php if ($data['certCards']): ?>
        <div class="product-docs-section__container wrapper-sm js--prod-subsection" id="cert_cert" data-title="Сертификаты">
            <h4 class="product-docs-section__title">Сертификаты</h4>

            <div class="product-docs-section__cert-list">
                <?php foreach ($data['certCards'] as $card) {
                    App\Layout\Components\Cards\FileCard\Layout::drawFileCard(
                        link: $card['link'] ?? '',
                        name: $card['text'] ?? '',
                        size: $card['size'] ?? '',
                    );
                } ?>
            </div>
        </div>
    <?php endif; ?>

    <?php if ($data['ottsCards']): ?>
        <div class="product-docs-section__container wrapper-sm js--prod-subsection" id="cert_ottc" data-title="ОТТС">
            <h4 class="product-docs-section__title">ОТТС</h4>

            <div class="product-docs-section__cert-list">
                <?php foreach ($data['ottsCards'] as $card) {
                    App\Layout\Components\Cards\FileCard\Layout::drawFileCard(
                        link: $card['link'] ?? '',
                        name: $card['text'] ?? '',
                        size: $card['size'] ?? '',
                    );
                } ?>
            </div>
        </div>
    <?php endif; ?>
</div>