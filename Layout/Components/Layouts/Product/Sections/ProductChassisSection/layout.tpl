<?php
/** @var array $data */
/** @var \App\Extensions\Site\Model\Chassis $c */
$c = $data['c'];
$prod = $data['prod'];
?>

<div class="product-chassis-section">
    <?php if($c->description): ?>
        <div class="product-chassis-section__container wrapper-sm js--prod-subsection" id="chassi_desc" data-title="Описание">
            <h4 class="product-chassis-section__title">Описание</h4>

            <div class="product-chassis-section__text">
                <span>Шасси <?= $c->name ?></span>
                <br/>
                <div class="content"><?= $c->description ?></div>
            </div>
        </div>
    <?php endif; ?>


    <?php
    $params = \App\Extensions\Site\Model\Chassis\Param::all();
    $vals = \App\Extensions\Site\Model\Chassis\ParamValue::getList($c->chassis_id);

    $grouped = []; $seen = [];
    foreach ($params as $par) {
        if (in_array($par->getId(), $seen)) {
            continue;
        }

        $grouped[$par->getCategoryName()][] = $par;
        $seen[] = $par->getId();
    }

    if ($grouped && $vals && array_filter($vals, fn($i) => !!$i)): ?>
        <div class="product-chassis-section__container wrapper-sm js--prod-subsection" id="chassi_chars" data-title="Характеристики">
            <h4 class="product-chassis-section__title">Характеристики</h4>

            <div class="product-chassis-section__table-wrap">
                <div class="product-chassis-section__table">
                    <?php
                    foreach ($grouped as $cat => $params) {
                        $any = false;
                        foreach ($params as $p) {
                            if ($vals[$p->chassis_param_id] ?? false) {
                                $any = true;
                                break;
                            }
                        }

                        if (!$any) {
                            continue;
                        }

                        App\Layout\Components\UI\Core\Table\Layout::drawTable(title: $cat ?: 'Основные', id: 'chassis_param_id', data: $params, values: $vals);
                    }
                    ?>
                </div>

                <?php if($prod->chassis_image) : ?>
                    <div class="product-chassis-section__table-image img-expand">
                        <img src="/uf/images/source/<?= $prod->chassis_image ?>"
                             data-fancybox="prod-chassis-img"
                             draggable="false"
                             loading="lazy"
                        >
                        <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'img-expand__btn',
                            icon: 'unique-expand-03',
                            attributes: [ 'type' => 'button' ],
                            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small
                        ); ?>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    <?php endif; ?>
</div>