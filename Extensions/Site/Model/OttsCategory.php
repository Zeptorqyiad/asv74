<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int otts_category_id
 * @property int npp
 * @property string name
 * @property string anchor
 */
class OttsCategory extends ModelBase
{
    protected static $table = 'otts_category';
    protected static $primaryKeyName = 'otts_category_id';

    public function getChildren()
    {
        return Otts::find(['otts_category_id' => $this->otts_category_id]);
    }
}