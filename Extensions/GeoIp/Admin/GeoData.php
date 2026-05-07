<?php

namespace App\Extensions\GeoIp\Admin;

use Simflex\Core\DB;
use Simflex\Extensions\Content\Admin\AdminContent;

class GeoData extends AdminContent
{
    protected function initTable()
    {
        $this->fields['pid'] = new \stdClass();
        parent::initTable();
        unset($this->fields['pid']);
    }

    protected function tableParamsLoad()
    {
        $contentId = DB::result('select content_id from g_data where data_id = ?', 0, [$_REQUEST['data_id'] ?? 0]) ?: 0;
        if (isset($_REQUEST['content_id'])) {
            $contentId = (int)$_REQUEST['content_id'];
        }

        $q = "
 SELECT param_id, param_pid, pos, '' as group_name, t1.name, t1.label, t1.params, t2.class, '$this->table' `table`, null default_value, 0 npp
            FROM struct_param t1
            LEFT JOIN struct_field t2 USING(field_id)
            WHERE table_id = $this->tableId
            UNION ALL
            SELECT ctp_id + 1000000 as param_id, param_pid, position as pos, t1.group_name as group_name,
                   t1.name, t1.label, t1.params, t2.class, '$this->table' `table`, default_value, t1.npp
            FROM content_template_param t1
            JOIN content c USING(template_id)
            LEFT JOIN struct_field t2 USING(field_id)
            WHERE c.content_id = $contentId
            ORDER BY npp";

        return DB::assoc($q, 'param_pid', 'param_id');
    }

    public function save()
    {
        if (!($_REQUEST['data_id'] ?? 0)) {
            // copy params from existing content
            $_POST = array_merge($_POST, unserialize(DB::result('select params from content where content_id = ?', 0, [$_REQUEST['content_id'] ?? 0])));
        }

        return parent::save();
    }
}