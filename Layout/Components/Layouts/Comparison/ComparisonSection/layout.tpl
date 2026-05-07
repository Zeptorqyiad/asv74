<?php
/** @var array $data */

?>

<section class="comparison">
    <div class="comparison__container container">
        <div class="comparison__top">
            <div class="comparison__tab-list">
                <?php
                foreach ($data['cats'] as $cat) {
                    App\Layout\Components\UI\Core\Tab\Layout::drawTab(
                        className: 'comparison__tab ' . ($data['cur'] == $cat->category_id ? 'active' : ''),
                        text: $cat->name,
                        link: '/compare/?c=' . $cat->category_id,
                        badge: count($data['prodToCat'][$cat->category_id] ?? []),
                        style: \App\Layout\Components\UI\Core\Tab\TabStyle::Underline,
                    );
                }
                ?>
            </div>

            <div class="comparison__actions">
                <div class="comparison__controls">
                    <?php
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'comparison__button-add',
                        text: 'Добавить товары',
                        icon: 'menu-3-line-mod',
                        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                        size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                        iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                        attributes: [
                            'onclick' => 'modalManager.open("comparison-modal");'
                        ]
                    );

                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'comparison__button-clear',
                        text: 'Очистить сравнение',
                        link: '/compare/?action=clear&c=' . $data['cur'],
                        icon: 'trash',
                        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                        size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                        iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                        attributes: [
                            'onclick' => 'toastManager.queue({ message: "Сравнение очищено"}); window.location.reload();'
                        ]
                    );
                    ?>
                </div>

                <div class="comparison__buttons-navigation">
                    <?php
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'comparison__button-prev',
                        icon: 'arrow-left',
                        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                        size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small
                    );
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'comparison__button-next',
                        icon: 'arrow-right',
                        style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                        size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small
                    );
                    ?>
                </div>
            </div>

            <div class="comparison__products-slider">
                <div class="swiper-wrapper">
                    <?php foreach ($data['slides'] as $slide) {
                        App\Layout\Components\Cards\ComparisonCard\Layout::drawComparisonCard(
                            productId: $slide['productId'] ?? 0,
                            variantId: $slide['variantId'] ?? 0,
                            className: 'swiper-slide',
                            link: $slide['link'] ?? '',
                            title: $slide['title'] ?? '',
                            price: $slide['price'] ?? '',
                            oldPrice: $slide['oldPrice'] ?? '',
                            toOrder: $slide['toOrder'] ?? false,
                            images: $slide['images'] ?? [],
                        );
                    }
                    ?>
                </div>
            </div>
        </div>

        <div class="comparison__body">

            <!------- Badges Group ------->

            <?php
            $any = false;
            foreach ($data['slides'] as $slide) {
                $any = $slide['toOrder'] || $slide['isNew'] || $slide['isStock'] || $slide['isSale'];
                if ($any) {
                    break;
                }
            }

            if ($any): ?>
                <div class="comparison__group">
                    <button class="comparison__group-top">
                        <h3>Предложения товара</h3>
                        <?= renderIcon('chevron-up') ?>
                    </button>
                    <div class="comparison__group-body">
                        <div class="comparison__group-slider">
                            <div class="swiper-wrapper">
                                <?php foreach ($data['slides'] as $slide) {
                                    App\Layout\Components\Layouts\Comparison\CompBadgesCell\Layout::drawCompBadgesCell(
                                        toOrder: $slide['toOrder'] ?? false,
                                        isNew: $slide['isNew'] ?? false,
                                        inStock: $slide['isStock'] ?? false,
                                        isSale: $slide['isSale'] ?? false,
                                    );
                                } ?>
                            </div>
                        </div>
                    </div>
                </div>
            <?php endif; ?>

            <!------- Tables Group ------->
            <?php if ($data['cp']): ?>
                <div class="comparison__group">
                    <button class="comparison__group-top">
                        <h3>Основное</h3>
                        <?= renderIcon('chevron-up') ?>
                    </button>
                    <div class="comparison__group-body">
                        <?php foreach ($data['cp'] as $dd): if (!$dd['items']) {
                            continue;
                        } ?>
                            <h4 class="comparison__table-title"><?= $dd['name'] ?></h4>

                            <div class="comparison__table">
                                <?php
                                foreach ($dd['items'] as $item) {
                                    App\Layout\Components\Layouts\Comparison\CompTableRow\Layout::drawCompTableRow(
                                        title: $item['name'],
                                        columns: array_map(fn($i) => ['text' => $i], $item['values']),
                                    );
                                }
                                ?>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            <?php endif; ?>

            <?php if ($data['chcp']): ?>
                <div class="comparison__group">
                    <button class="comparison__group-top">
                        <h3>Шасси</h3>
                        <?= renderIcon('chevron-up') ?>
                    </button>
                    <div class="comparison__group-body">
                        <?php foreach ($data['chcp'] as $dd): if (!$dd['items']) {
                            continue;
                        } ?>
                            <h4 class="comparison__table-title"><?= $dd['name'] ?></h4>

                            <div class="comparison__table">
                                <?php
                                foreach ($dd['items'] as $item) {
                                    App\Layout\Components\Layouts\Comparison\CompTableRow\Layout::drawCompTableRow(
                                        title: $item['name'],
                                        columns: array_map(fn($i) => ['text' => $i], $item['values']),
                                    );
                                }
                                ?>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            <?php endif; ?>

            <?php if ($data['acp']): ?>
                <div class="comparison__group">
                    <button class="comparison__group-top">
                        <h3>Оборудование</h3>
                        <?= renderIcon('chevron-up') ?>
                    </button>
                    <div class="comparison__group-body">
                        <?php foreach ($data['acp'] as $dd): if (!$dd['items']) {
                            continue;
                        } ?>
                            <h4 class="comparison__table-title"><?= $dd['name'] ?></h4>

                            <div class="comparison__table">
                                <?php
                                foreach ($dd['items'] as $item) {
                                    App\Layout\Components\Layouts\Comparison\CompTableRow\Layout::drawCompTableRow(
                                        title: $item['name'],
                                        columns: array_map(fn($i) => ['text' => $i], $item['values']),
                                    );
                                }
                                ?>
                            </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>