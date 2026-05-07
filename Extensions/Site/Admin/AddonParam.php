<?php
namespace App\Extensions\Site\Admin;

use Simflex\Admin\Base;
use Simflex\Core\DB;

class AddonParam extends Base
{
    protected function deleteItem($id)
    {
        DB::query('DELETE FROM catalog_addon_param_value WHERE addon_param_id = ?', [$id]);
        return parent::deleteItem($id);
    }
}