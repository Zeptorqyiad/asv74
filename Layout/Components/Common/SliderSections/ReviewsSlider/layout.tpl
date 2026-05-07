<?php
/** @var array $data */

$cats = App\Extensions\Site\Model\ReviewCategory::findAdv()->all();
?>

<?php if ($cats): ?>
    <section class="reviews-slider <?= $data['className'] ?>">

        <h2 class="section-title reviews-slider__title"><?= $data['title'] ?? 'Отзывы' ?></h2>

        <div class="reviews-slider__buttons">
            <?php if ($data['link']) {
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'reviews-slider__button-link',
                    text: 'Показать все',
                    link: $data['link'],
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                );
            }
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'reviews-slider__button-prev',
                icon: 'arrow-left',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            );
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'reviews-slider__button-next',
                icon: 'arrow-right',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            ); ?>
        </div>

        <div class="reviews-slider__slider-wrap">
            <div class="reviews-slider__slider">
                <div class="swiper-wrapper">
                    <?php foreach ($cats as $c) {
                        if ($children = $c->getChildren()) {
                            foreach ($children as $card) {
                                App\Layout\Components\Cards\ReviewCard\Layout::drawReviewCard(
                                    className: 'swiper-slide',
                                    type: $c->type ?? '',
                                    badgeText: $c->name ?? '',
                                    title: $card->title ?? '',
                                    file: $card->file ?? '',
                                );
                            }
                        }
                    } ?>
                </div>
            </div>
        </div>
    </section>
<?php endif; ?>