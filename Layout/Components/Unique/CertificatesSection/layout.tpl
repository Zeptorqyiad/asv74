<?php
/** @var array $data */


?>

<section class="certificates-section">
    <div class="certificates-section__container container">
        <?php App\Layout\Components\Common\AsideMenu\Layout::drawAsideMenu(
            tabs: [
                [
                    'text' => 'Сертификаты',
                    'link' => '/info/certificates/',
                ],
                [
                    'className' => 'with-separator',
                    'text' => 'ОТТС',
                    'link' => '/info/otts/',
                ],
            ]
        ); ?>

        <div class="certificates-section__body">
            <h2 class="certificates-section__category-title">Дилерские свидетельства</h2>
            <div class="certificates-section__category-list">
                <?php foreach ($data['cards'] as $card) {
                    App\Layout\Components\Cards\CertificateCard\Layout::drawCertCard(
                        title: $card['title'] ?? '',
                        image: $card['image'] ?? '',
                    );
                } ?>
            </div>
        </div>
    </div>
</section>