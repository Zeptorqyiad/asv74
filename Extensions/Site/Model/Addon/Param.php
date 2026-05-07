<?php

namespace App\Extensions\Site\Model\Addon;

use App\Extensions\Catalog\LoadAssist;
use Simflex\Core\Buffer;
use Simflex\Core\DB;
use Simflex\Core\ModelBase;

class Param extends ModelBase
{
    protected static $table = 'catalog_addon_param';
    protected static $primaryKeyName = 'addon_param_id';

    public function getCategoryName(): string
    {
        return Buffer::getOrSet('param_addon_cat.' . $this->addon_param_category_id, fn() => DB::result('select name from catalog_addon_param_category where addon_param_category_id = ?', 0, [$this->addon_param_category_id]));
    }

    public function getValues(): array
    {
        return Buffer::getOrSet('param_addon.' . $this->id . '.vals', function () {
            $q = new DB\AQ();
            $q->from(ParamValue::getTableName());
            $q->asArray();
            $q->where(['addon_param_id' => $this->addon_param_id]);
            $q->andWhere('value <> \'\'');
            $q->select('distinct `value`, addon_param_id');
            return $q->all();
        });
    }
}