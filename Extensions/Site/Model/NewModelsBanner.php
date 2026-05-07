<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int model_banner_id
 * @property int npp
 * @property bool is_active
 * @property string title
 * @property string desc
 * @property string link
 * @property string background
 * @property string image
 * @property bool to_order
 * @property bool is_new
 * @property bool in_stock
 * @property bool is_sale
 * @property string badges
 *
 */
class NewModelsBanner extends ModelBase
{
    protected static $table = 'new_models_banner';
    protected static $primaryKeyName = 'model_banner_id';

    public function getBadges(): array
    {
        $data = json_decode($this->badges, true);
        return $data['v'] ?? [];
    }
}