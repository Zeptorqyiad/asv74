<?php
/** @var array $data */

$aboutLinks = [
    [
        'icon' => 'unique-certificate',
        'text' => 'Сертификаты и ОТТС',
        'link' => '/info/certificates/'
    ],
    [
        'icon' => 'unique-car',
        'text' => 'Доставка и оплата',
        'link' => '/info/delivery/'
    ],
    [
        'icon' => 'unique-sale-01',
        'text' => 'Лизинг',
        'link' => '/info/leasing/'
    ],
    [
        'icon' => 'unique-shield-tick',
        'text' => 'О гарантии',
        'link' => '/info/guarantee/'
    ],
    [
        'icon' => 'unique-message-question',
        'text' => 'Частые вопросы',
        'link' => '/info/faq/'
    ],
    [
        'icon' => 'unique-cube-outline',
        'text' => '3D экскурсия',
        'link' => '/asv/ASV2022.html'
    ],
];

$links = !empty($data['links']) ? $data['links'] : $aboutLinks;
?>

<section class="about-promo <?= $data['className'] ?>">
    <div class="about-promo__container container">
        <?php if ($data['cards']): ?>
            <div class="about-promo__text">
                <h2 class="section-title about-promo__title"><?= $data['title'] ?></h2>
                <p class="about-promo__desc"><?= $data['desc'] ?></p>
            </div>

            <div class="about-promo__info">

                <img class="about-promo__info-image"
                     src="<?= $data['img'] ?>"
                     alt=""
                     draggable="false"
                     loading="lazy"
                     aria-hidden="true"
                >

                <p class="about-promo__info-desc"><?= $data['desc'] ?></p>

                <div class="about-promo__info-list">
                    <?php foreach ($data['cards'] as $card): ?>
                        <div class="about-promo__info-card">
                            <h3 class="about-promo__info-card-title"><?= $card['title'] ?></h3>
                            <?php App\Layout\Components\UI\Core\Separator\Layout::drawSeparator(
                                className: 'about-promo__info-card-separator',
                            ); ?>
                            <p class="about-promo__info-card-desc"><?= $card['desc'] ?></p>
                        </div>
                    <?php endforeach; ?>
                </div>

                <p class="about-promo__info-quote">
                    <?php if ($data['badge']): ?>
                        <span class="about-promo__info-quote-badge"><?= $data['badge'] ?></span>
                    <?php endif; ?>

                    <?= $data['quote'] ?>
                </p>
            </div>
        <?php endif; ?>

        <?php if ($links): ?>
            <div class="about-promo__links">
                <?php foreach ($links as $link): ?>
                    <div class="about-promo__link">
                        <a class="about-promo__link-wrap" href="<?= $link['link'] ?>">
                            <?php if ($link['icon']): ?>
                                <?= renderIcon($link['icon'], 'about-promo__link-icon') ?>
                            <?php endif; ?>
                            <span class="about-promo__link-text"><?= $link['text'] ?></span>
                        </a>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
</section>