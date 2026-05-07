<?php
/** @var array $data */
?>

<section class="post-fs <?= $data['className'] ?>">
    <div class="post-fs__container container">

        <?php if ($data['imgBig']): ?>
            <div class="post-fs__media">
                <img class="post-fs__image post-fs__image--desktop"
                     src="<?= '/uf/images/source/' . $data['imgBig'] ?>"
                     alt="<?= $data['title'] ?>"
                     loading="lazy"
                >
                <img class="post-fs__image post-fs__image--mobile"
                     src="<?= '/uf/images/source/' . $data['imgMob'] ?? $data['imgBig'] ?>"
                     alt="<?= $data['title'] ?>"
                     loading="lazy"
                >
            </div>
        <?php endif; ?>

        <div class="post-fs__text">
            <h1 class="post-fs__title">
                <?= $data['title'] ?>
            </h1>
            <p class="post-fs__desc">
                <?= $data['description'] ?>
            </p>
        </div>
    </div>
</section>