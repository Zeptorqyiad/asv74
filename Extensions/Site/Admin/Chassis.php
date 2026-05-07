<?php

namespace App\Extensions\Site\Admin;

use App\Extensions\Site\Model\Chassis\Param;
use App\Extensions\Site\Model\Chassis\ParamValue;
use Simflex\Admin\Base;
use Simflex\Admin\Fields\Field;
use Simflex\Admin\Fields\FieldBool;

class Chassis extends Base
{
    public function save()
    {
        $ret = parent::save();
        if ($ret) {
            ParamValue::updateForProduct($ret);
        }

        return $ret;
    }

    protected function initTable()
    {
        if (($_REQUEST['action'] ?? '') != 'form') {
            parent::initTable();
            return;
        }

        $toAdd = Param::findAdv()->all();

        // get params
        $prodVar = ParamValue::getList($_REQUEST['chassis_id'] ?? 0);

        /** @var Param $i */
        foreach ($toAdd as $i) {
            $f = new Field([
                'name' => 'param_' . $i->chassis_param_id,
                'label' => $i->name,
                'table' => $this->table
            ]);

            $f->isVirtual = true;
            $f->params = [
                'pos' => 'right',
                'pos_group' => $i->getCategoryName(),
                '__param' => $i->toArray(),
            ];

            $f->value = $prodVar[$i->chassis_param_id] ?? '';
            $this->fields['param_' . $i->chassis_param_id] = $f;
        }

        parent::initTable();
    }
}