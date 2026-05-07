<?php
/** @var array $data */
?>

<div class="product-heading container"
     data-product-id="<?= $data['productId'] ?>"
     data-variant-id="<?= $data['variantId'] ?>"
>
    <h1 class="product-heading__title"><?= $data['title'] ?></h1>

    <div class="product-heading__actions">
        <?php
        if ($data['productId']) {
            App\Layout\Components\UI\Other\ButtonCompare\Layout::drawButtonCompare(
                class: 'product-heading__button-compare',
                productId: $data['productId'],
                variantId: $data['variantId'] ?? 0,
                style: \App\Layout\Components\UI\Other\ButtonCompare\ButtonCompareStyle::Full
            );
        }

        if ($data['file']) {
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'product-heading__button-download',
                text: 'Скачать PDF',
                link: $data['file'],
                icon: 'download',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::ExtraSmall,
                attributes: [
                    'download' => $data['title'],
                    'onclick' => 'tracker.track("product_pdf_download");',
                ]
            );

            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'product-heading__button-print',
                text: 'Распечатать',
                link: $data['file'] . '&print=1',
                icon: 'unique-printer',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::ExtraSmall,
                attributes: [
                    'onclick' => 'tracker.track("product_pdf_print"); window.open(this.href); return false;',
                ]
            );
        }

        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'product-heading__button-share share-button',
            text: 'Поделиться',
            icon: 'share',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::ExtraSmall,
            attributes: [
                'onclick' => 'tracker.track("product_link_share");',
            ]
        );
        ?>
    </div>
</div>