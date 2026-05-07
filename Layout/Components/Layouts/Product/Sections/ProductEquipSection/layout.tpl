<?php
/** @var array $data */
/** @var \App\Extensions\Site\Model\Addon $a */
$a = $data['a'];

$equipCards = array_map(fn($i) => [
    'image' => '/uf/images/source/' . $i->photo,
    'text' => $i->name
], $data['o']);
$productSlides = [
    [
        'productId' => $a->addon_id,
        'variantId' => 0,
        'link' => '/' . $a->path . '/',
        'title' => $a->name,
        'desc' => '',
        'sku' => $a->sku,
        'price' => number_format($a->price, 0, '', ' '),
        'oldPrice' => number_format($a->price_old, 0, '', ' '),
        'isNew' => $a->is_new,
        'inStock' => true,
        'isSale' => $a->price != $a->price_old,
        'images' => $a->getImages(),
    ],
];
?>

<div class="product-equip-section">
    <?php if($a->description): ?>
        <div class="product-equip-section__container wrapper-sm js--prod-subsection" id="equip_desc" data-title="Описание">
            <h4 class="product-equip-section__title">Описание</h4>

            <div class="product-equip-section__table-wrap">
                <div class="product-equip-section__text">
                    <span><?= $a->name ?></span>
                    <div class="content"><?= $a->description ?></div>
                </div>
                <?php if ($a->image) : ?>
                    <div class="product-equip-section__table-image img-expand">
                        <img src="/uf/images/source/<?= $a->image ?>"
                             data-fancybox="prod-specs-img-2"
                             alt=""
                             draggable="false"
                             loading="lazy"
                        >
                        <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'img-expand__btn',
                            icon: 'unique-expand-03',
                            attributes: ['type' => 'button'],
                            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small
                        ); ?>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    <?php endif; ?>

    <?php
    $params = \App\Extensions\Site\Model\Addon\Param::all();
    $vals = \App\Extensions\Site\Model\Addon\ParamValue::getList($a->addon_id);

    $grouped = [];
    $seen = [];
    foreach ($params as $par) {
        if (in_array($par->getId(), $seen)) {
            continue;
        }

        $grouped[$par->getCategoryName()][] = $par;
        $seen[] = $par->getId();
    }

    if ($grouped && $vals && array_filter($vals, fn($i) => !!$i)):
        ?>
        <div class="product-equip-section__container wrapper-sm js--prod-subsection" id="equip_chars" data-title="Характеристики">
            <h4 class="product-equip-section__title">Характеристики</h4>

            <div class="product-equip-section__table-wrap">
                <div class="product-equip-section__table">
                    <?php
                    foreach ($grouped as $cat => $params) {
                        $any = false;
                        foreach ($params as $p) {
                            if ($vals[$p->addon_param_id] ?? false) {
                                $any = true;
                                break;
                            }
                        }

                        if (!$any) {
                            continue;
                        }

                        App\Layout\Components\UI\Core\Table\Layout::drawTable(title: $cat ?: 'Основные', id: 'addon_param_id', data: $params, values: $vals);
                    }
                    ?>
                </div>

                <?php if ($a->image_param) : ?>
                    <div class="product-equip-section__table-image img-expand">
                        <img src="/uf/images/source/<?= $a->image_param ?>"
                             data-fancybox="prod-specs-img-2"
                             alt=""
                             draggable="false"
                             loading="lazy"
                        >
                        <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'img-expand__btn',
                            icon: 'unique-expand-03',
                            attributes: ['type' => 'button'],
                            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small
                        ); ?>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    <?php endif; ?>

    <div class="product-equip-section__container wrapper-sm js--prod-subsection" id="equip_tools" data-title="Установленное оборудование">
        <h4 class="product-equip-section__title">Установленное оборудование</h4>

        <div class="product-equip-section__variants">
            <?php foreach ($productSlides as $slide) {
                \App\Layout\Components\Cards\CatalogCard\Layout::drawCatalogCard(
                    productId: $slide['id'] ?? 0,
                    variantId: $slide['variantId'] ?? 0,
                    link: $slide['link'] ?? '',
                    title: $slide['title'] ?? '',
                    desc: $slide['desc'] ?? '',
                    category: $slide['category'] ?? '',
                    sku: $slide['sku'] ?? '',
                    price: $slide['price'] ?? '',
                    oldPrice: $slide['oldPrice'] ?? '',
                    toOrder: $slide['toOrder'] ?? false,
                    isNew: $slide['isNew'] ?? false,
                    inStock: $slide['isStock'] ?? false,
                    isSale: $slide['isSale'] ?? false,
                    fabric: $slide['fabric'] ?? '',
                    images: $slide['images'] ?? [],
                    specs: $slide['specs'] ?? [],
                );
            } ?>
        </div>
    </div>

    <?php if ($equipCards): ?>
        <div class="product-equip-section__container wrapper-sm js--prod-subsection" id="equip_options" data-title="Дополнительные опции">
            <h4 class="product-equip-section__title">Дополнительные опции</h4>

            <div class="product-equip-section__equip-list">
                <?php foreach ($equipCards as $card): ?>
                    <div class="product-equip-section__equip-card">
                        <img src="<?= $card['image'] ?>" alt="<?= $card['text'] ?>" draggable="false" loading="lazy">
                        <p><?= $card['text'] ?></p>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endif; ?>
</div>