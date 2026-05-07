<?php
/** @var array $data */

/** @var \App\Extensions\Site\Model\Product $prod */

use App\Extensions\Catalog\LoadAssist;
use Simflex\Core\Buffer;

$prod = $data['prod'];

$equipCards = array_map(fn($i) => [
    'image' => '/uf/images/source/' . $i->photo,
    'text' => $i->name
], $data['o']);
?>

<div class="product-car-section">
    <?php if ($prod->desc || $prod->description): ?>
        <div class="product-car-section__container wrapper-sm js--prod-subsection" id="car_desc" data-title="Описание">
            <h4 class="product-car-section__title">Описание</h4>

            <div class="product-car-section__text content">
                <?= $prod->desc ?: $prod->description ?>
            </div>

            <!--        <img class="product-car-section__desc-image"-->
            <!--             data-fancybox="prod-desc-img"-->
            <!--             src="/assets/images/products/product-desc.webp"-->
            <!--             alt="" draggable="false"-->
            <!--             loading="lazy"-->
            <!--        >-->
        </div>
    <?php endif; ?>

    <?php
    $params = $prod->product_id ? \App\Extensions\Catalog\Model\Param::getAllForCategory($prod->getFirstCategory()->category_id, false) : \App\Extensions\Site\Model\Addon\Param::all();
    $vals = $prod->product_id ? \App\Extensions\Catalog\Model\ParamValue::getList($prod->product_id) : \App\Extensions\Site\Model\Addon\ParamValue::getList($prod->addon_id);

    $grouped = [];
    $seen = [];
    foreach ($params as $par) {
        if (in_array($par->getId(), $seen)) {
            continue;
        }

        $grouped[$par->getCategoryName()][] = $par;
        $seen[] = $par->getId();
    }

    if ($grouped && $vals && array_filter($vals, fn($i) => !!$i)): ?>
        <div class="product-car-section__container wrapper-sm js--prod-subsection" id="car_chars" data-title="Характеристики">
            <h4 class="product-car-section__title">Характеристики</h4>

            <div class="product-car-section__table-wrap">
                <div class="product-car-section__table">
                    <?php
                    foreach ($grouped as $category => $params) {
                        App\Layout\Components\UI\Core\Table\Layout::drawTable(title: $category ?: 'Основные', data: $params, values: $vals, id: $prod->product_id ? 'param_id' : 'addon_param_id');
                    }
                    ?>
                </div>

                <?php if ($prod->param_image): ?>
                    <div class="product-car-section__table-image img-expand">
                        <img src="/uf/images/source/<?= $prod->param_image ?>"
                             data-fancybox="prod-specs-img"
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

    <?php if ($prod->plan): ?>
        <div class="product-car-section__container wrapper-sm js--prod-subsection" id="car_plan" data-title="Планировка">
            <h4 class="product-car-section__title">Планировка</h4>

            <div class="product-car-section__plan-wrap">
                <div class="product-car-section__plan content">
                    <?= $prod->plan ?>
                </div>

                <?php if ($prod->plan_photo): ?>
                    <div class="product-car-section__plan-image-wrap">
                        <div class="product-car-section__plan-image img-expand">
                            <img src="/uf/images/source/<?= $prod->plan_photo ?>"
                                 data-fancybox="prod-plan-img"
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
                        <span><?= $prod->plan_desc ?></span>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    <?php endif; ?>

    <?php if ($equipCards): ?>
        <div class="product-car-section__container wrapper-sm js--prod-subsection" id="car_equip" data-title="Техническое оснащение">
            <h4 class="product-car-section__title">Техническое оснащение</h4>

            <div class="product-car-section__equip-list">
                <?php foreach ($equipCards as $card): ?>
                    <div class="product-car-section__equip-card">
                        <img src="<?= $card['image'] ?>" alt="<?= $card['text'] ?>" draggable="false" loading="lazy">
                        <p><?= $card['text'] ?></p>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endif; ?>

<!--    --><?php //if ($prod->video): ?>
<!--        <div class="product-car-section__container wrapper-sm js--prod-subsection" id="car_video" data-title="Видео">-->
<!--            <div class="product-car-section__video-wrap">-->
<!--                --><?php
//                App\Layout\Components\UI\Other\VideoPlayer\Layout::drawVideoPlayer(
//                    className: 'product-car-section__player',
//                    src: '/uf/files/' . $prod->video,
//                );
//                ?>
<!--                <span class="product-car-section__video-subtitle"></span>-->
<!--            </div>-->
<!--        </div>-->
<!--    --><?php //endif; ?>
</div>