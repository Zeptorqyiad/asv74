<?php
namespace App\Extensions\Site\Admin;

use Simflex\Admin\Base;
use Simflex\Core\DB;

class ChassisParam extends Base
{
    protected function deleteItem($id)
    {
        DB::query('DELETE FROM catalog_chassis_param_value WHERE chassis_param_id = ?', [$id]);
        return parent::deleteItem($id);
    }
}