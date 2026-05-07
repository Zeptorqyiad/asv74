<?php

namespace App\Extensions\Site\Model\Chassis;

use App\Extensions\Catalog\LoadAssist;
use Simflex\Core\Buffer;
use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Log;
use Simflex\Core\ModelBase;
use Simflex\Core\Profiler;

/**
 * @property int chassis_param_value_id
 * @property int chassis_param_id
 * @property int chassis_id
 * @property string value
 *
 * @property Param param
 */
class ParamValue extends ModelBase
{
    protected static $table = 'catalog_chassis_param_value';
    protected static $primaryKeyName = 'chassis_param_value_id';

    public function offsetGetParam()
    {
        return Param::findOne(['chassis_param_id' => $this->chassis_param_id]);
    }


    public static function getList(int $chassisId): array
    {
        $cache = self::find(['chassis_id' => $chassisId]);

        $out = [];
        foreach ($cache as $val) {
            $out[$val->chassis_param_id] = $val->value;
        }

        return $out;
    }

    /**
     * @throws \Exception
     */
    public static function updateForProduct(int $chassisId)
    {
        $req = Container::getRequest();
        foreach ($req->post() as $k => $v) {
            // filter out ones that start with param_
            if (!str_starts_with($k, 'param_')) {
                continue;
            }

            Log::debug('trying to update {k} (new val {v})', ['k' => $k, 'v' => $v]);

            // get param id and test if it exists
            $paramId = (int)substr($k, strlen('param_'));
            if (!Param::exists($paramId)) {
                Log::warning('param {id} not found', ['id' => $paramId]);
                continue;
            }

            // test if row already exists for this product
            $item = self::findAdv()->where(
                ['chassis_id' => $chassisId, 'chassis_param_id' => $paramId]
            )->fetchOne();
            if ($item) {
                Log::debug('updating item');

                // update
                $item->update([
                    'value' => trim($v)
                ]);
            } else {
                // create new
                $item = new self;
                $item->chassis_id = $chassisId;
                $item->chassis_param_id = $paramId;
                $item->value = trim($v);
                $item->save();

                Log::debug('inserting item');
            }
        }
    }
}