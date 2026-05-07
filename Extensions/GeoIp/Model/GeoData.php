<?php

namespace App\Extensions\GeoIp\Model;

use App\Extensions\GeoIp\GeoIp;
use Simflex\Core\Container;
use Simflex\Core\ModelBase;

/**
 * @property int data_id
 * @property int city_id
 * @property string path
 * @property string title
 * @property string meta_desc
 * @property string meta_kw
 * @property string params
 */
class GeoData extends ModelBase
{
    protected static $primaryKeyName = 'data_id';
    protected static $table = 'g_data';

    public static function get(string $key, string $default = ''): mixed
    {
        $data = GeoIp::getSavedData();
        if (!$data) {
            $data = ['id' => 0];
        }

        $path = Container::getRequest()->getPath();
        $obj = static::findOne(['path' => $path, 'city_id' => $data['id']]);
        if (!$obj) {
            return null;
        }

        return $obj->getParams()[$key] ?? $default;
    }

    public function getParams(): array
    {
        return json_decode($this->params, true) ?: [];
    }
}