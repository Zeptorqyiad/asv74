<?php
namespace App\Extensions\GeoIp\Model;

use Simflex\Core\ModelBase;

class GeoCity extends ModelBase
{
    protected static $primaryKeyName = 'city_id';
    protected static $table = 'g_city';
}