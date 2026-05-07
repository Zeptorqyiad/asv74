<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int faq_id
 * @property int npp
 * @property int faq_category_id
 * @property string question
 * @property string answer
 *
 * @property FaqCategory category
 */

class Faq extends ModelBase
{
    protected static $table = 'faq';
    protected static $primaryKeyName = 'faq_id';

    public function offsetGetCategory(): FaqCategory
    {
        return FaqCategory::findOne(['faq_category_id' => $this->faq_category_id]);
    }
}