<?php
namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int chassis_id
 * @property bool is_active
 * @property string name
 * @property string description
 */
class Chassis extends ModelBase
{
    protected static $table = 'catalog_chassis';
    protected static $primaryKeyName = 'chassis_id';
}