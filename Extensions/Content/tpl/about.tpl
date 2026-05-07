<?php
/** @var array $content */

$index = $content->loadFrom('/');

$aboutCards = self::getTableFrom('index_about_cards', $index);
$advantageCards = self::getTableFrom('index_advantages_cards', $index);
$certCards = array_reverse(self::getTableFrom('certificates', $content->loadFrom('/info/certificates/')));
$partnerSlides = self::getTableFrom('index_partners_cards', $index);
$yearCards = self::getTableFrom('about_path_cards', $content);
$workProcessCards = self::getTableFrom('about_process_cards', $content);
$factoryCards = self::getTableFrom('about_factory_cards', $content);
$constructList = self::getTableFrom('about_deps_construct', $content);
$qualityList = self::getTableFrom('about_deps_quality', $content);
$supplyList = self::getTableFrom('about_deps_supply', $content);
$salesList = self::getTableFrom('about_deps_sales', $content);
$marketingList = self::getTableFrom('about_deps_marketing', $content);
$teamCards = self::getTableFrom('about_team_cards', $content);

?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: 'О компании',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Layouts\AboutCompany\AboutFs\Layout::draw([
            'title' => $content['params']['about_fs_title'],
            'desc' => $content['params']['about_fs_desc'],
            'image' => $content['params']['about_fs_image'] ? '/uf/images/source/' . $content['params']['about_fs_image'] : '',
            'cards' => $aboutCards,
        ]);

        if ($advantageCards) {
            App\Layout\Components\Common\PromoSections\AdvantagesPromo\Layout::draw([
                'title' => $index['params']['index_advantages_title'],
                'cards' => $advantageCards
            ]);
        }

        App\Layout\Components\Layouts\AboutCompany\AboutPrinciples\Layout::draw([
            'title' => $content['params']['about_principles_title'],

            'card_img_1' => $content['params']['about_principles_card_img_1'] ? '/uf/images/source/' . $content['params']['about_principles_card_img_1'] : '',
            'card_title_1' => $content['params']['about_principles_card_title_1'],
            'card_desc_1' => $content['params']['about_principles_card_desc_1'],

            'card_title_2' => $content['params']['about_principles_card_title_2'],
            'card_desc_2' => $content['params']['about_principles_card_desc_2'],

            'card_title_3' => $content['params']['about_principles_card_title_3'],
            'card_desc_3' => $content['params']['about_principles_card_desc_3'],

            'card_img_4' => $content['params']['about_principles_card_img_4'] ? '/uf/images/source/' . $content['params']['about_principles_card_img_1'] : '',
            'card_title_4' => $content['params']['about_principles_card_title_4'],
            'card_desc_4' => $content['params']['about_principles_card_desc_4'],
        ]);

        if ($yearCards) {
            App\Layout\Components\Layouts\AboutCompany\AboutHistory\Layout::draw([
                'title' => $content['params']['about_path_title'],
                'cards' => $yearCards,
            ]);
        }

        if ($workProcessCards) {
            App\Layout\Components\Common\PromoSections\WorkProcessPromo\Layout::draw([
                'title' => $content['params']['about_process_title'],
                'cards' => $workProcessCards
            ]);
        }

        if ($factoryCards) {
            App\Layout\Components\Layouts\AboutCompany\AboutFactory\Layout::draw([
                'title' => $content['params']['about_factory_title'],
                'desc' => $content['params']['about_factory_desc'],
                'cards' => $factoryCards
            ]);
        }

        if ($certCards) {
            App\Layout\Components\Common\SliderSections\CertificatesSlider\Layout::draw([
                'title' => 'Официальный дилер крупных компаний',
                'link' => '/info/certificates/',
                'cards' => $certCards,
            ]);
        }

        if ($constructList || $qualityList || $supplyList || $salesList || $marketingList) {
            App\Layout\Components\Layouts\AboutCompany\AboutDepartments\Layout::draw([
                'title' => $content['params']['about_deps_title'],
                'construct_list' => $constructList,
                'quality_list' => $qualityList,
                'supply_list' => $supplyList,
                'sales_list' => $salesList,
                'marketing_list' => $marketingList,
            ]);
        }

//        if ($teamCards) {
//            App\Layout\Components\Layouts\AboutCompany\AboutTeam\Layout::draw([
//                'title' => $content['params']['about_team_title'],
//                'cards' => $teamCards
//            ]);
//        }
        if ($partnerSlides) {
            App\Layout\Components\Common\SliderSections\PartnersSlider\Layout::draw([
                'title' => $index['params']['index_partners_title'],
                'link' => '/cases/',
                'slides' => $partnerSlides,
            ]);
        }

        App\Layout\Components\Common\SliderSections\ReviewsSlider\Layout::draw([
            'title' => 'Отзывы',
            'link' => '/info/reviews/',
        ]);

        App\Layout\Components\Common\PromoSections\ContactsPromo\Layout::draw();

        App\Layout\Components\Common\PromoSections\ConsultationPromo\Layout::draw([
            'title' => $index['params']['index_form_title'],
            'desc' => $index['params']['index_form_desc'],
            'image' => $index['params']['index_form_image'],
        ]);
        ?>
    </main>

<?php App\Layout\Components\Common\Footer\Layout::draw([
    'file' => $index['params']['working_conditions_file'],
]); ?>