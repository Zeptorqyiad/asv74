<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int faq_category_id
 * @property int npp
 * @property string name
 * @property string anchor
 */
class FaqCategory extends ModelBase
{
    protected static $table = 'faq_category';
    protected static $primaryKeyName = 'faq_category_id';

    public function getChildren()
    {
        return Faq::find(['faq_category_id' => $this->faq_category_id]);
    }
}