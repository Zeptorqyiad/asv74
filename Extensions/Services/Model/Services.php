<?php

namespace App\Extensions\Services\Model;

use Simflex\Core\ModelBase;

/**
 * @property int services_id
 * @property int npp
 * @property boolean is_on_home
 * @property boolean is_active
 * @property string title
 * @property string fs_photo
 * @property text fs_description
 * @property text fs_badges
 * @property text fs_list
 * @property string fs_btn_link
 * @property string promo_title
 * @property text promo_cards
 * @property text gallery_images
 * @property string about_title
 * @property string about_image
 * @property text about_steps
 * @property string process_title
 * @property text process_steps
 * @property string cta_title
 * @property text cta_text
 * @property string cta_image
 * @property string examples_title
 * @property text examples_slides
 * @property string slider_title
 * @property string meta_title
 * @property text meta_desc
 * @property text meta_kw
 */
class Services extends ModelBase
{
    protected static $table = 'services';
    protected static $primaryKeyName = 'services_id';

    public function getBadges(): array
    {
        return json_decode($this->fs_badges, true)['v'] ?? [];
    }
    public function getList(): array
    {
        return json_decode($this->fs_list, true)['v'] ?? [];
    }
    public function getPromoCards(): array
    {
        return json_decode($this->promo_cards, true)['v'] ?? [];
    }
    public function getGalleryImages(): array
    {
        return json_decode($this->gallery_images, true)['v'] ?? [];
    }
    public function getAboutSteps(): array
    {
        return json_decode($this->about_steps, true)['v'] ?? [];
    }
    public function getProcessSteps(): array
    {
        return json_decode($this->process_steps, true)['v'] ?? [];
    }
    public function getExamplesSlides(): array
    {
        return json_decode($this->examples_slides, true)['v'] ?? [];
    }
}