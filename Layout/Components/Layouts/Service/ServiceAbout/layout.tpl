<?php
/** @var array $data */

?>

<section class="service-about" id="service-about">
    <div class="service-about__container container">
        <h2 class="section-title service-about__title"><?= $data['title'] ?></h2>

        <div class="service-about__body">
            <div class="service-about__steps">
                <?php foreach ($data['steps'] as $step): ?>
                    <div class="service-about__step">
                        <h3 class="service-about__step-title"><?= $step["title"] ?></h3>

                        <div class="service-about__step-list">
                            <?php if ($step['text_row_1']): ?>
                                <div class="service-about__step-item">
                                    <?= renderIcon('arrow-up-right', 'service-about__step-item-icon') ?>
                                    <p class="service-about__step-item-text"><?= $step['text_row_1'] ?></p>
                                </div>
                            <?php endif; ?>

                            <?php if ($step['text_row_2']): ?>
                                <div class="service-about__step-item">
                                    <?= renderIcon('arrow-up-right', 'service-about__step-item-icon') ?>
                                    <p class="service-about__step-item-text"><?= $step['text_row_2'] ?></p>
                                </div>
                            <?php endif; ?>

                            <?php if ($step['text_row_3']): ?>
                                <div class="service-about__step-item">
                                    <?= renderIcon('arrow-up-right', 'service-about__step-item-icon') ?>
                                    <p class="service-about__step-item-text"><?= $step['text_row_3'] ?></p>
                                </div>
                            <?php endif; ?>

                            <?php if ($step['text_row_4']): ?>
                                <div class="service-about__step-item">
                                    <?= renderIcon('arrow-up-right', 'service-about__step-item-icon') ?>
                                    <p class="service-about__step-item-text"><?= $step['text_row_4'] ?></p>
                                </div>
                            <?php endif; ?>

                            <?php if ($step['text_row_5']): ?>
                                <div class="service-about__step-item">
                                    <?= renderIcon('arrow-up-right', 'service-about__step-item-icon') ?>
                                    <p class="service-about__step-item-text"><?= $step['text_row_5'] ?></p>
                                </div>
                            <?php endif; ?>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>

            <div class="service-about__image-container">
                <?php if ($data['image']): ?>
                    <img class="service-about__image"
                         src="/uf/images/source/<?= $data['image'] ?>"
                         alt="<?= $data['title'] ?>"
                         loading="lazy"
                         aria-hidden="true"
                    >
                <?php endif; ?>

                <?php if ($data['manager']): ?>
                    <div class="service-about__manager">
                        <div class="service-about__manager-credentials">
                            <div class="service-about__manager-image-wrap">
                                <img class="service-about__manager-avatar"
                                     src="<?= $data['manager']['image'] ?: '/assets/images/placeholders/fallback-img.webp' ?>"
                                     alt="<?= $data['manager']['name'] ?>"
                                     loading="lazy"
                                     draggable="false"
                                >
                            </div>

                            <div class="service-about__manager-text">
                                <h4 class="service-about__manager-name"><?= $data['manager']['name'] ?></h4>
                                <?php if ($data['manager']['job']): ?>
                                    <p class="service-about__manager-job"><?= $data['manager']['job'] ?></p>
                                <?php endif; ?>
                            </div>

                            <div class="service-about__manager-links">
                                <?php foreach (json_decode($data['manager']['phone'], true)['v'] ?? [] as $p): ?>
                                    <a class="service-about__manager-phone"
                                       href="<?= 'tel:' . $p['phone'] ?>"
                                    >
                                        <span><?= $p['phone'] ?></span>
                                    </a>
                                <?php endforeach; ?>

                                <?php if ($data['manager']['email']): ?>
                                    <a class="service-about__manager-email"
                                       href="<?= 'mailto:' . $data['manager']['email'] ?>"
                                    >
                                        <span><?= $data['manager']['email'] ?></span>
                                    </a>
                                <?php endif; ?>
                            </div>
                        </div>

                        <div class="service-about__controls">
                            <?php
                            App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                                className: 'w-full',
                                text: 'Заказать услугу',
                                icon: 'arrow-up-right',
                                iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
                                attributes: [
                                    'onclick' => 'modalManager.open("callback-modal"); tracker.track("callback_form_open");',
                                ]
                            );
                            ?>
                        </div>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</section>