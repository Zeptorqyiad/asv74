<?php
namespace App\Extensions\GeoIp\Model;

use Simflex\Core\ModelBase;

/**
 * @property int data_field_id
 * @property int field_id
 * @property string name
 * @property string label
 * @property string group_name
 * @property string default_value
 * @property string params
 */
class GeoDataField extends ModelBase
{
    protected static $table = 'geo_data_field';
    protected static $primaryKeyName = 'data_field_id';
}