<?php

namespace App\Extensions\Site\Model;

use App\Extensions\Catalog\Model\Category;
use Simflex\Core\ModelBase;

/**
 * @property int div_id
 * @property string name
 * @property string icon
 */
class CategoryDiv extends ModelBase
{
    protected static $primaryKeyName = 'div_id';
    protected static $table = 'catalog_category_div';

    public function getCategories(): array
    {
        return Category::find(['div_id' => $this->div_id, 'pid' => null, 'is_on_home' => 1, 'is_active' => 1], 'npp');
    }
}