<?php
/** @var array $data */

$tg = Simflex\Core\Core::siteParam('tg');
//$wt = Simflex\Core\Core::siteParam('whats_app');
$max_social = Simflex\Core\Core::siteParam('max_social');

?>

<section class="service-fs <?= $data['class'] ?>">
    <div class="service-fs__container container">
        <div class="service-fs__ls">
            <div class="service-fs__image">
                <img src="<?= $data['image'] ?>" alt="<?= $data['title'] ?>" loading="lazy">
            </div>

            <div class="service-fs__controls service-fs__controls--mob">
                <div class="service-fs__controls-wrap">
                    <?php
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'service-fs__button-callback',
                        text: 'Получить расчет',
                        attributes: [
                            'onclick' => 'modalManager.open("callback-modal"); tracker.track("callback_form_open");',
                        ]
                    );
                    if ($data['btnLink']) {
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'service-fs__button-callback',
                            text: 'Продукция в каталоге',
                            link: $data['btnLink'],
                            icon: 'arrow-up-right',
                            style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Outline,
                            iconPos: App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                        );
                    }
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'callback-modal__social--tg w-full',
                        text: 'Написать в Telegram',
                        link: $tg,
                        icon: 'social-mono-tg',
                        style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                        attributes: ['target' => '_blank']
                    );
                    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                        className: 'callback-modal__social--max w-full',
                        text: 'Написать в Max',
                        link: $max_social,
                        icon: 'social-max',
                        style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                        attributes: ['target' => '_blank']
                    );
                    ?>
                </div>
            </div>
        </div>


        <div class="service-fs__text">
            <?php if ($data['desc']): ?>
                <div class="service-fs__desc">
                    <?= $data['desc'] ?>
                </div>
            <?php endif; ?>

            <?php if ($data['badges']): ?>
                <div class="service-fs__badges">
                    <?php foreach ($data['badges'] as $badge) {
                        App\Layout\Components\UI\Core\Badge\Layout::drawBadge(
                            className: 'service-fs__badge',
                            text: $badge['text'],
                            style: App\Layout\Components\UI\Core\Badge\BadgeStyle::Secondary,
                            size: App\Layout\Components\UI\Core\Badge\BadgeSize::Medium,
                        );
                    }
                    ?>
                </div>
            <?php endif; ?>

            <div class="service-fs__controls">
                <div class="service-fs__controls-wrap">
                    <div class="service-fs__controls-wrap--top">
                        <?php if (!empty($data['btnLink'])): ?>
                            <?php
                            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                                className: 'service-fs__button-callback',
                                text: 'Получить расчет',
                                attributes: [
                                    'onclick' => 'modalManager.open("callback-modal"); tracker.track("callback_form_open");',
                                ]
                            );
                            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                                className: 'service-fs__button-catalog',
                                text: 'Продукция в каталоге',
                                link: $data['btnLink'],
                                icon: 'arrow-up-right',
                                style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Outline,
                                iconPos: App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                            );
                            ?>
                        <?php else: ?>
                            <?php App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                                className: 'service-fs__button-callback',
                                text: 'Получить расчет',
                                attributes: [
                                    'onclick' => 'modalManager.open("callback-modal"); tracker.track("callback_form_open");',
                                ]
                            ); ?>
                        <?php endif; ?>
                    </div>
                    <div class="service-fs__controls-wrap--bottom">
                        <?php
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'callback-modal__social--tg w-full',
                            text: 'Написать в Telegram',
                            link: $tg,
                            icon: 'social-mono-tg',
                            style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                            attributes: ['target' => '_blank']
                        );
                        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                            className: 'callback-modal__social--max w-full',
                            text: 'Написать в Max',
                            link: $max_social,
                            icon: 'social-max',
                            style: App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                            attributes: ['target' => '_blank']
                        );
                        ?>
                    </div>
                </div>
            </div>

            <?php if ($data['list']): ?>
                <div class="service-fs__list">
                    <?php foreach ($data['list'] as $item): ?>
                        <div class="service-fs__item">
                            <?= renderIcon('dot-lg', 'service-fs__item-icon') ?>
                            <p class="service-fs__item-text"><?= $item['text'] ?></p>
                        </div>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>
        </div>
    </div>
</section>