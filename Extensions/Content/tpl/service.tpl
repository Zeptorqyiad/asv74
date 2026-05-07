<?php
/** @var array $content */

$index = $content->loadFrom('/');
use App\Extensions\Services\Model\Services;
use App\Extensions\Services\Model\ServicesP2C;
use App\Extensions\Site\Model\Product;

$services = Services::findAdv()
    ->where(['is_active' => 1])
    ->orderBy('npp')
    ->all();

usort($services, fn ($a, $b) => $b->npp <=> $a->npp);

$services_p2c = ServicesP2C::findAdv()
    ->where(['services_id' => $this->service->services_id])
    ->all();

$products = [];
foreach ($services_p2c as $p2c) {
    $product = Product::findOne(['product_id' => $p2c->product_id]);
    if ($product) {
        $products[] = $product;
    }
}

$anchors = [
    [
        'text' => 'Об услуге',
        'link' => '#service-about',
        'icon' => 'unique-image-indent-right'
    ],
    [
        'text' => 'Процесс работы',
        'link' => '#service-process',
        'icon' => 'unique-car'
    ]
];

if (!empty($exampleCards)) {
    $anchors[] = [
        'text' => 'Примеры работ',
        'link' => '#service-examples',
        'icon' => 'unique-car'
    ];
}

$anchors[] = [
    'text' => 'Контакты',
    'link' => '#contacts-promo',
    'icon' => 'phone'
];

$m = \App\Extensions\Site\Model\ManagerContent::getForContent($content['content_id']);
if ($m && $m->user) {
    $u = $m->user;
    $manager = [
        'name' => $u->name . ' ' . $u->last_name,
        'image' => '/uf/images/source/' . $m->avatar,
        'job' => $m->job,
        'phone' => $m->phones,
        'email' => $m->email
    ];
} else {
    $manager = [];
}
?>

<?php App\Layout\Components\Common\Header\Layout::drawHeader(
    title: $this->service->title ?? 'Услуга',
); ?>

    <main>
        <?php
        App\Layout\Components\UI\Core\BreadCrumbs\Layout::draw();

        App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
            title: $this->service->title ?? 'Услуга',
            button: false,
            links: $anchors,
        );

        App\Layout\Components\Layouts\Service\ServiceFs\Layout::drawServiceFs(
            image: '/uf/images/source/' . $this->service->fs_photo ?: '/assets/images/placeholders/fallback-img.webp',
            desc: $this->service->fs_description ?? '',
            badges: $this->service->getBadges(),
            list: $this->service->getList(),
            btnLink: $this->service->fs_btn_link ?? '',
        );

        App\Layout\Components\Common\PromoSections\AdvantagesPromo\Layout::draw([
            'title' => $this->service->promo_title ?: '',
            'cards' => $this->service->getPromoCards(),
        ]);

        App\Layout\Components\Layouts\Service\ServiceGallery\Layout::drawServiceGallery(
            images: $this->service->getGalleryImages(),
        );

        App\Layout\Components\Layouts\Service\ServiceAbout\Layout::drawServiceAbout(
            title: $this->service->about_title ?: '',
            image: $this->service->about_image ?: '',
            manager: $manager,
            steps:  $this->service->getAboutSteps(),
        );

        App\Layout\Components\Layouts\Service\ServiceProcess\Layout::drawServiceProcess(
            title: $this->service->process_title ?: '',
            steps: $this->service->getProcessSteps(),
        );

        App\Layout\Components\Layouts\Service\ServiceCTA\Layout::draw([
            'title' => $this->service->cta_title,
            'text' => $this->service->cta_text,
            'image' => $this->service->cta_image,
        ]);

        if (!empty($products)) {
            App\Layout\Components\Common\SliderSections\ProductsSlider\Layout::draw([
                'title' => 'Техника в наличии',
                'slides' => $products,
            ]);
        }

        App\Layout\Components\Layouts\Service\ServiceExamples\Layout::drawServiceExamples(
            title: $this->service->examples_title ?: '',
            slides: $this->service->getExamplesSlides(),
        );

        $services = array_values(array_filter(
            $services,
            fn ($s) => (int)$s->services_id !== (int)$this->service->services_id
        ));

        App\Layout\Components\Common\SliderSections\ServiceSlider\Layout::draw([
            'title' => $this->service->slider_title ?: 'Другие услуги',
            'link' => '/services/',
            'cards' => $services,
        ]);

        //        App\Layout\Components\Common\SliderSections\CasesSlider\Layout::draw([
        //            'title' => 'История поставок',
        //            'link' => '/cases/',
        //        ]);

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