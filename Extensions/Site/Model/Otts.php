<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int otts_id
 * @property int npp
 * @property int otts_category_id
 * @property string image
 * @property string text
 *
 * @property OttsCategory category
 */

class Otts extends ModelBase
{
    protected static $table = 'otts';
    protected static $primaryKeyName = 'otts_id';

    public function offsetGetCategory(): OttsCategory
    {
        return OttsCategory::findOne(['otts_category_id' => $this->otts_category_id]);
    }
}