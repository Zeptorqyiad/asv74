<?php

namespace App\Extensions\Site\Model\Chassis;

use App\Extensions\Catalog\LoadAssist;
use Simflex\Core\Buffer;
use Simflex\Core\DB;
use Simflex\Core\ModelBase;

class Param extends ModelBase
{
    protected static $table = 'catalog_chassis_param';
    protected static $primaryKeyName = 'chassis_param_id';

    public function getCategoryName(): string
    {
        return Buffer::getOrSet('param_chassis_cat.' . $this->chassis_param_category_id, fn() => DB::result('select name from catalog_chassis_param_category where chassis_param_category_id = ? limit 1', 0, [$this->chassis_param_category_id]));
    }
    
    public function getValues(): array
    {
        return Buffer::getOrSet('param_chassis.' . $this->id . '.vals', function () {
            $q = new DB\AQ();
            $q->from(ParamValue::getTableName());
            $q->asArray();
            $q->where(['chassis_param_id' => $this->chassis_param_id]);
            $q->andWhere('value <> \'\'');
            $q->select('distinct `value`, chassis_param_id');
            return $q->all();
        });
    }
}