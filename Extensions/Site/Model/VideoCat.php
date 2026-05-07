<?php
namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int video_cat_id
 * @property int video_id
 * @property int category_id
 */
class VideoCat extends ModelBase
{
    protected static $table = 'catalog_video_cat';
    protected static $primaryKeyName = 'video_cat_id';
}