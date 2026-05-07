<?php
namespace App\Extensions\Blog\Model;

use Simflex\Core\ModelBase;

/**
 * @property int bc_id
 * @property int npp
 * @property string name
 * @property string cat_name
 */
class BlogCategory extends ModelBase
{
    protected static $table = 'blog_category';
    protected static $primaryKeyName = 'bc_id';

    public function getCount()
    {
        return Blog::findAdv()->where('bc_id = ' . $this->bc_id . ' AND is_active = 1')->select('count(*)')->fetchScalar();
    }

    public static function getTotalCount()
    {
        return Blog::findAdv()->where('is_active = 1')->select('count(*)')->fetchScalar();
    }
}