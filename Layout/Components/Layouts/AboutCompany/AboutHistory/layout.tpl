<?php
/** @var array $data */

?>

<section class="about-history">
    <h2 class="section-title about-history__title"><?= $data['title'] ?></h2>

    <div class="about-history__controls">
        <?php
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'about-history__button-prev',
            icon: 'arrow-left',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        );
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'about-history__button-next',
            icon: 'arrow-right',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary
        );
        ?>
    </div>

    <div class="about-history__body">
        <div class="about-history__body-wrap">
            <?php
            foreach ($data['cards'] as $index => $card) {
                App\Layout\Components\Cards\YearCard\Layout::drawYearCard(
                    class: 'about-history__card' . ($index == 0 ? ' active' : ''),
                    title: $card['title'] ?? '',
                    descRowFirst: $card['descRowFirst'] ?? '',
                    descRowSecond: $card['descRowSecond'] ?? '',
                    descRowThird: $card['descRowThird'] ?? '',
                    descRowFourth: $card['descRowFourth'] ?? '',
                    descRowFifth: $card['descRowFifth'] ?? '',
                );
            }
            ?>
        </div>
    </div>
</section>