<?php
/** @var array $content */
?>

<?php App\Layout\Components\Common\Header\Layout::draw(); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PromoSections\ContactsPromo\Layout::draw();

        App\Layout\Components\Common\PromoSections\ConsultationPromo\Layout::draw([
            'title' => '<span>Обсудить сотрудничество</span> или нужна консультация?',
            'desc' => 'Заполните форму и наш менеджер свяжется с вами в течении 15 минут (в рабочее время)',
            'img' => '/assets/images/default/consult-promo.webp',
        ]);
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw(); ?>