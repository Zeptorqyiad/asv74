<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int review_asv_id
 * @property bool is_active
 * @property int npp
 * @property int review_asv_category_id
 * @property string title
 * @property string file
 *
 * @property ReviewCategory category
 */
class Review extends ModelBase
{
    protected static $table = 'review_asv';
    protected static $primaryKeyName = 'review_asv_id';

    public function offsetGetCategory(): ReviewCategory
    {
       return new ReviewCategory($this->review_asv_category_id);
    }

    public function getCategoryName(): string
    {
        $category = $this->category;
        return $category ? $category->name : '';
    }

    public function getCategoryType(): string
    {
        $category = $this->category;
        return $category ? $category->type : '';
    }
}