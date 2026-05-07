<?php
/** @var array $data */
?>

<?php if (!empty($data['slides'])): ?>
<section class="service-examples" id="service-examples">
    <div class="service-examples__container container">
        <h2 class="section-title service-examples__title"><?= $data['title'] ?? 'Новые модели' ?></h2>

        <div class="service-examples__buttons">
            <?php if ($data['link']) {
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'service-examples__button-link',
                    text: 'Показать все',
                    link: $data['link'],
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                );
            }
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'service-examples__button-prev',
                icon: 'arrow-left',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            );
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'service-examples__button-next',
                icon: 'arrow-right',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            ); ?>
        </div>

        <div class="service-examples__slider-wrap">
            <div class="swiper service-examples__slider">
                <div class="swiper-wrapper">
                    <?php foreach ($data['slides'] as $slide) {
                        App\Layout\Components\Cards\ServiceExampleCard\Layout::drawServiceExampleCard(
                            class: 'swiper-slide',
                            image: $slide['image'] ?? '',
                            title: $slide['title'] ?? '',
                            desc: $slide['desc'] ?? '',
                            textRow1: $slide['textRow1'] ?? '',
                            textRow2: $slide['textRow2'] ?? '',
                            textRow3: $slide['textRow3'] ?? '',
                            textRow4: $slide['textRow4'] ?? '',
                            textRow5: $slide['textRow5'] ?? '',
                        );
                    } ?>
                </div>
            </div>

            <div class="service-examples__pagination"></div>
        </div>
    </div>
</section>
<?php endif; ?>