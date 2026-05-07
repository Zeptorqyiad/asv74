<?php

/* @var array $data */

$page = $data['page'];
$pages = $data['pages'];
$name = $data['name'];
$maxPage = $pages - 1;

$stepper = function (string $target) use ($page, $maxPage, $name) {
    $dir = $target == 'prev' ? -1 : 1;
    $icon = $target == 'prev' ? 'm13 16-4-4 4-4"' : 'm11 8 4 4-4 4';
    $url = paginate($page + $dir, $maxPage, $name);
    if (!$url) {
        return;
    }

    echo <<<HTML
<a href="$url" class="pagination__item pagination__item--$target">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
        <path d="$icon" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" />
    </svg>
</a>
HTML;
};

$link = function (int $target) use ($page, $maxPage, $name) {
    $url = paginate($target, $maxPage, $name);
    $active = $target == $page ? 'active' : '';
    $targetText = $target + 1;

    echo <<<HTML
<a href="$url" class="pagination__item $active">$targetText</a>
HTML;
};
?>

<div class="pagination pagination--desktop wrapper">
    <div class="pagination__container container">
        <?php
        $stepper('prev');

        // if current page is <= page 6 output 1..6
        if ($page < 5) {
            if ($pages <= 8) {
                for ($i = 0; $i <= min($maxPage, 8); ++$i) {
                    $link($i);
                }
            } else {
                for ($i = 0; $i <= min($maxPage, 5); ++$i) {
                    $link($i);
                }

                echo '<span class="pagination__item pagination__item--disabled">...</span>';
                $link($maxPage);
            }
        } else {
            // output page 1 and ...
            $link(0);
            echo '<span class="pagination__item pagination__item--disabled">...</span>';

            // output n-2..n
            for ($i = $page - 2; $i <= $page; ++$i) {
                $link($i);
            }

            if ($page < $maxPage - 3) {
                // output n+1..n+2
                for ($i = $page + 1; $i <= min($page + 2, $pages); ++$i) {
                    $link($i);
                }

                echo '<span class="pagination__item pagination__item--disabled">...</span>';
                $link($maxPage);
            } else {
                for ($i = $page + 1; $i < $pages; ++$i) {
                    $link($i);
                }
            }
        }

        $stepper('next');
        ?>
    </div>

<!--    <button class="pagination__button-more">Показать ещё</button>-->
</div>

<div class="pagination pagination--mobile wrapper">
    <div class="pagination__container">
        <?php
        $stepper('prev');

        // if current page is <= page 6 output 1..6
        if ($page < 2) {
            if ($pages <= 5) {
                for ($i = 0; $i <= min($maxPage, 5); ++$i) {
                    $link($i);
                }
            } else {
                for ($i = 0; $i <= min($maxPage, 2); ++$i) {
                    $link($i);
                }

                echo '<span class="pagination__item pagination__item--disabled">...</span>';
                $link($maxPage);
            }
        } else {
            // output page 1 and ...
            $link(0);
            echo '<span class="pagination__item pagination__item--disabled">...</span>';

            // output n-2..n
            for ($i = $page - 1; $i <= $page; ++$i) {
                $link($i);
            }

            if ($page < $maxPage - 2) {
                // output n+1..n+2
                $link($i+1);
                echo '<span class="pagination__item pagination__item--disabled">...</span>';
                $link($maxPage);
            } else {
                for ($i = $page + 1; $i < $pages; ++$i) {
                    $link($i);
                }
            }
        }

        $stepper('next');
        ?>
    </div>

<!--    <button class="pagination__button-more">Показать ещё</button>-->
</div>
