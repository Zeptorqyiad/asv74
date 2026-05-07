<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int review_asv_category_id
 * @property int npp
 * @property string name
 * @property string type
 */
class ReviewCategory extends ModelBase
{
    protected static $table = 'review_asv_category';
    protected static $primaryKeyName = 'review_asv_category_id';

    public function getChildren()
    {
        return Review::find(['review_asv_category_id' => $this->review_asv_category_id]);
    }
}