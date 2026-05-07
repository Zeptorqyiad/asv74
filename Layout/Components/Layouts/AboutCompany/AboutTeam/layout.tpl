<?php
/** @var array $data */

?>

<section class="about-team">
    <div class="about-team__container container">
        <h2 class="section-title about-team__title"><?= $data['title'] ?? 'Наша команда' ?></h2>
        <div class="about-team__list">
            <?php foreach ($data['cards'] as $card) {
                App\Layout\Components\Cards\TeamCard\Layout::drawTeamCard(
                    name: $card['name'] ?? '',
                    job: $card['job'] ?? '',
                    image: $card['image'] ?? ''
                );
            } ?>
        </div>
    </div>
</section>