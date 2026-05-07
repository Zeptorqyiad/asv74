<?php
/** @var array $data */
?>

<section class="post-content <?= $data['className'] ?>">
    <div class="post-content__body content">
        <?= $data['content'] ?>
    </div>

    <div class="post-content__bottom">

        <p class="post-content__views">
            <b><?= $data['views'] ?></b>
            <span><?= Simflex\Core\Helpers\Str::pluralize($data['views'], 'просмотр', true, false) ?></span>
        </p>

        <p class="post-content__date">
            <?= $data['date'] ?>
        </p>

        <?php
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'post-content__button-back',
            text: 'Назад',
            icon: 'arrow-left',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
            attributes: [
                'onclick' => 'event.preventDefault(); history.back();',
            ]
        );
        App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
            className: 'post-content__button-share share-button',
            text: 'Поделиться',
            icon: 'share',
            style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
        );
        ?>

    </div>
</section>