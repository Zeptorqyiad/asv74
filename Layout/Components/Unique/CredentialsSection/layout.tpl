<?php
/** @var array $data */

?>

<section class="cred-section" id="credentials">
    <div class="cred-section__container container">
        <h3 class="cred-section__title">Реквизиты:</h3>

        <div class="cred-section__content">

            <div class="cred-section__table">
                <?php foreach ($data['tableRows'] as $index => $r): ?>
                    <?php if ($index % 2 === 0): ?>
                        <div class="cred-section__table-row">
                            <div class="cred-section__table-col cred-section__table-col--title">
                                <span><?= $r['title'] ?></span>
                            </div>
                            <div class="cred-section__table-col cred-section__table-col--text">
                                <span><?= $r['text'] ?></span>
                            </div>
                        </div>
                    <?php endif; ?>
                <?php endforeach; ?>
            </div>

            <div class="cred-section__table">
                <?php foreach ($data['tableRows'] as $index => $r): ?>
                    <?php if ($index % 2 === 1): ?>
                        <div class="cred-section__table-row">
                            <div class="cred-section__table-col cred-section__table-col--title">
                                <span><?= $r['title'] ?></span>
                            </div>
                            <div class="cred-section__table-col cred-section__table-col--text">
                                <span><?= $r['text'] ?></span>
                            </div>
                        </div>
                    <?php endif; ?>
                <?php endforeach; ?>
            </div>

        </div>

        <div class="cred-section__actions">
            <?php
            if ($data['file']) {
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'cred-section__button cred-section__button-download',
                    text: 'Скачать реквизиты',
                    link: $data['file'],
                    icon: 'download',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Gray,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                    attributes: [
                        'download' => $data['title'],
                        'onclick' => 'tracker.track("requisites_download");',
                    ]
                );

                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'cred-section__button cred-section__button-print',
                    text: 'Распечатать',
                    link: $data['file'],
                    icon: 'unique-printer',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::Small,
                    attributes: [
                        'onclick' => 'window.open(this.href).print(); return false;',
                    ]
                );
            }
            ?>
        </div>
    </div>
</section>