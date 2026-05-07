<?php
/** @var array $content */
?>

<?php App\Layout\Components\Common\Header\Layout::draw(); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>