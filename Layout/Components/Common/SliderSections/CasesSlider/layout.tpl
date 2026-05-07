<?php
/** @var array $data */

if ($data['c']) {
    $cards = App\Extensions\Site\Model\CaseDetail::findAdv()
        ->leftJoin('case_asv_c', 'case_asv_id')
        ->where('case_asv_id <> :case_asv_id and is_active = 1 and case_asv_c.category_id = :category_id')
        ->bind(['case_asv_id' => $data['case_asv_id'] ?? 0, 'category_id' => $data['c']])
        ->limit(15)
        ->orderBy('npp desc')
        ->all();
} else {
    $cards = App\Extensions\Site\Model\CaseDetail::findAdv()
        ->where('case_asv_id <> :case_asv_id and is_active = 1')
        ->bind(['case_asv_id' => $data['case_asv_id'] ?? 0])
        ->limit(15)
        ->orderBy('npp desc')
        ->all();
}
?>

<?php if ($cards): ?>
    <section class="cases-slider <?= $data['className'] ?>">

        <h2 class="section-title cases-slider__title"><?= $data['title'] ?? 'История поставок' ?></h2>

        <div class="cases-slider__buttons">
            <?php if ($data['link']) {
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'cases-slider__button-link',
                    text: 'Показать все',
                    link: $data['link'],
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                );
            }
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'cases-slider__button-prev',
                icon: 'arrow-left',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            );
            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                className: 'cases-slider__button-next',
                icon: 'arrow-right',
                style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
            ); ?>
        </div>

        <div class="cases-slider__slider-wrap">
            <div class="cases-slider__slider">
                <div class="swiper-wrapper">
                    <?php foreach ($cards as $card) {
                        App\Layout\Components\Cards\CaseCard\Layout::drawCaseCard(
                            className: 'swiper-slide',
                            title: $card['title'] ?? '',
                            link: '/cases/' . $card['alias'] . '/',
                            location: $card['location'] ?? '',
                            date: $card['date'] ?? '',
                            image: $card->getFirstImage(),
                        );
                    } ?>
                </div>
            </div>
        </div>
    </section>
<?php endif; ?>