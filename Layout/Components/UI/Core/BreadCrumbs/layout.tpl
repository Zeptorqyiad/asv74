<?php
/** @var array $data */

use Simflex\Extensions\Breadcrumbs\Breadcrumbs;

$breadcrumbs = Breadcrumbs::get();
$activeBreadcrumb = Breadcrumbs::getLast();

// Check if the current page is a 404.
$is404 = ($_SERVER['REQUEST_URI'] === '/404');

// Ensure breadcrumbs are re-indexed from 0.
$breadcrumbs = array_values($breadcrumbs);
?>

<div class="<?= $data['class_name'] ?> bread-crumbs wrapper <?= count(Breadcrumbs::get()) + 1 > 4 ? 'bread-crumbs--minimal' : '' ?>">
    <div class="bread-crumbs__container">
        <ul class="bread-crumbs__list">
            <li class="bread-crumbs__item bread-crumbs__item--home">
                <?php
                App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
                    className: 'bread-crumbs__button-home',
                    link: '/',
                    icon: 'home',
                    style: \App\Layout\Components\UI\Core\Buttons\Button\ButtonStyle::Secondary,
                    size: \App\Layout\Components\UI\Core\Buttons\Button\ButtonSize::ExtraSmall,
                    attributes: [
                            'aria-label' => 'На главную',
                    ]
                );
                ?>
            </li>

            <?php if ($is404): ?>
                <li class="bread-crumbs__item">
                    <div class="bread-crumbs__separator">/</div>
                    <p class="bread-crumbs__item-title">Страница не найдена</p>
                </li>
            <?php else: ?>
                <?php foreach ($breadcrumbs as $breadcrumb): ?>
                    <li class="bread-crumbs__item">
                        <div class="bread-crumbs__separator">/</div>
                        <?php if ($activeBreadcrumb['link'] === $breadcrumb['link']): ?>
                            <p class="bread-crumbs__item-title"><?= $breadcrumb['name'] ?></p>
                        <?php else: ?>
                            <a class="bread-crumbs__item-link" href="<?= $breadcrumb['link'] ?>">
                                <?= $breadcrumb['name'] ?>
                            </a>
                        <?php endif; ?>
                    </li>
                <?php endforeach; ?>
            <?php endif; ?>
        </ul>
    </div>
</div>
