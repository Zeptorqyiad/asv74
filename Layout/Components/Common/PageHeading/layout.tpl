<?php
/** @var array $data */
?>

<div class="page-heading <?= $data['className'] ?>">
    <div class="page-heading__container container">
        <div class="page-heading__top">
            <?php if ($data['button']) {
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'page-heading__button-back',
                    text: 'Назад',
                    icon: 'arrow-left',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Flat,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                    attributes: [
                        'onclick' => 'event.preventDefault(); history.back();',
                    ]
                );

                App\Layout\Components\UI\Core\Separator\Layout::drawSeparator(
                    className: 'page-heading__separator',
                    orientation: \App\Layout\Components\UI\Core\Separator\SeparatorOrientation::Vertical,
                );
            }
            ?>

            <h2 class="page-heading__title"><?= $data['title'] ?></h2>

            <?php if ($data['links']): ?>
                <div class="page-heading__links">
                    <?php foreach ($data['links'] as $link) {
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'page-heading__link',
                            text: $link['text'] ?? '',
                            link: $link['link'] ?? '',
                            icon: $link['icon'] ?? '',
                            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                            size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::ExtraSmall,
                        );
                    } ?>
                </div>
            <?php endif; ?>
        </div>

        <?php
            App\Layout\Components\UI\Core\Separator\Layout::drawSeparator();

            $promoHD = !empty($data['promoHD']) ? json_decode($data['promoHD'], true)['v'] : [];
            $promoMob = !empty($data['promoMob']) ? json_decode($data['promoMob'], true)['v'] : [];
        ?>

        <?php if ($promoHD || $promoMob): ?>
            <?php
            App\Layout\Components\Common\SliderSections\PromoSlider\Layout::draw([
                'promoHD' => $promoHD,
                'promoMob' => $promoMob,
            ]);
            ?>
        <?php endif; ?>

        <?php if ($data['desc']): ?>
            <div class="page-heading__bottom">
                <div class="content"><?= $data['desc'] ?></div>
            </div>
        <?php endif; ?>
    </div>
</div>