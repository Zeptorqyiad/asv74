<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int banner_id
 * @property int npp
 * @property bool is_active
 * @property string title
 * @property string desc
 * @property string image
 * @property string image_mob
 * @property string video
 * @property string link
 *
 */
class Banner extends ModelBase
{
    protected static $table = 'fs_banner';
    protected static $primaryKeyName = 'banner_id';
}