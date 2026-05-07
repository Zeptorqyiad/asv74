<?php
/** @var array $data */

?>

<?php if ($data['title'] || $data['image']): ?>
<section class="service-cta">
    <div class="service-cta__container container">
        <div class="service-cta__content">
            <div class="service-cta__ls">
                <?php if ($data['title']): ?>
                    <h2 class="service-cta__ls--title">
                        <?= $data['title'] ?>
                    </h2>
                <?php endif; ?>
                <?php if ($data['text']): ?>
                    <div class="service-cta__ls--text">
                        <?= $data['text'] ?>
                    </div>
                <?php endif; ?>

                <?php App\Layout\Components\UI\Core\Cards\FirstscreenCard\Layout::drawFirstscreenCard(
                    className: 'service-cta__ls--button',
                    title: 'Получить расчёт проекта',
                    text: 'Отправим КП за 2 часа',
                    attributes: [
                        'onclick' => 'modalManager.open("callback-modal"); tracker.track("callback_form_open");',
                    ]
                ); ?>
            </div>
            <div class="service-cta__rs">
                <img class="service-cta__rs--image"
                     src="/uf/images/source/<?= $data['image'] ?>"
                     alt="">
            </div>
        </div>
    </div>
</section>
<?php endif; ?>