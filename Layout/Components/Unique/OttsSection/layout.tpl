<?php
/** @var array $data */

$cats = App\Extensions\Site\Model\OttsCategory::findAdv()->all();
?>

<section class="otts-section">
    <div class="otts-section__container container">
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
            ],
            noFollow: true
        ); ?>

        <div class="otts-section__body">
            <?php foreach ($cats as $c): ?>
                <?php if ($children = $c->getChildren()): ?>
                    <div class="otts-section__category" id="<?= $c->anchor ?>">

                        <h2 class="otts-section__category-title"><?= $c->name ?></h2>

                        <div class="otts-section__category-list">
                            <?php foreach ($children as $index => $item) {
                                App\Layout\Components\Cards\CertificateCard\Layout::drawCertCard(
                                    className: 'certificate-card--otts',
                                    title: $item->text ?? '',
                                    image: $item->image ? '/uf/images/source/' . $item->image : '',
                                );
                            } ?>
                        </div>
                    </div>
                <?php endif; ?>
            <?php endforeach; ?>
        </div>
    </div>
</section>