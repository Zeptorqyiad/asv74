<?php
/** @var array $content */

$index = $content->loadFrom('/');

$q = App\Extensions\Blog\Model\Blog::findAdv()->where(['is_active' => 1]);
if ($this->c) {
    $q->andWhere(['bc_id' => $this->c]);
}

$pag = $_REQUEST['page'] ?? 0;

$count = $q->select('count(*)')->fetchScalar();
$cards = $q->select('*')->limit('16 offset ' . ($pag * 16))->orderBy('npp DESC')->all();
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
        title: 'Блог',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: 'Блог',
        );

        App\Layout\Components\Layouts\Blog\BlogFilter\Layout::draw([
            'cats' => $this->c,
        ]);

        App\Layout\Components\Layouts\Blog\BlogSection\Layout::draw([
            'cards' => $cards,
        ]);

        App\Layout\Components\UI\Other\Pagination\Layout::drawPages($pag, ceil($count / 15));
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]); ?>