<?php
/** @var array $data */

?>

<?php if ($data['cards']): ?>
    <section class="certificates-slider <?= $data['className'] ?>">

        <h2 class="section-title certificates-slider__title"><?= $data['title'] ?? 'Официальный дилер крупных компаний' ?></h2>

        <div class="certificates-slider__buttons">
            <?php if ($data['link']) {
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'certificates-slider__button-link',
                    text: 'Все документы',
                    link: $data['link'],
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                );
            }
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'certificates-slider__button-prev',
                icon: 'arrow-left',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            );
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'certificates-slider__button-next',
                icon: 'arrow-right',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            ); ?>
        </div>

        <div class="certificates-slider__slider-wrap">
            <div class="certificates-slider__slider">
                <div class="swiper-wrapper">
                    <?php foreach ($data['cards'] as $card) {
                        App\Layout\Components\Cards\CertificateCard\Layout::drawCertCard(
                            className: 'certificate-card--slider swiper-slide',
                            title: $card['title'] ?? '',
                            image: $card['image'] ?? '',
                        );
                    } ?>
                </div>
            </div>
        </div>
    </section>
<?php endif; ?>