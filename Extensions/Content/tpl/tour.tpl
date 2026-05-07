<?php
/** @var array $content */

?>

<?php
App\Layout\Components\Common\Header\Layout::drawHeader();
?>

    <main>
        <?php
        App\Layout\Components\Unique\Tour\Layout::draw();

        ?>
    </main>

<?php
App\Layout\Components\Common\Footer\Layout::draw();
?>