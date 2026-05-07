<?php
/** @var array $content */
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Unique\ErrorSection\Layout::drawErrorSection(
            errorText: 'Ошибка 404',
            title: 'Такой страницы не существует',
            description: 'Скорее всего, вы использовали устаревшую или неправильную ссылку. Вы можете перейти на главную или в каталог и найти то, что вам требуется',
        );
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>