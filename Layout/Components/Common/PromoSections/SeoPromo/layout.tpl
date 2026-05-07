<?php
/** @var array $data */
?>


<?php if ($data['seo_title_1'] || $data['seo_text_1'] || $data['seo_title_2'] || $data['seo_text_2']): ?>
    <section class="seo-promo">
        <div class="seo-promo__container container">
            <div class="seo-promo__text-wrap">
                <h2 class="seo-promo__title"><?= $data['seo_title_1'] ?></h2>
                <div class="seo-promo__desc content"><?= $data['seo_text_1'] ?></div>
            </div>
            <div class="seo-promo__text-wrap">
                <h2 class="seo-promo__title"><?= $data['seo_title_2'] ?></h2>
                <div class="seo-promo__desc content"><?= $data['seo_text_2'] ?></div>
            </div>
        </div>
    </section>
<?php endif; ?>