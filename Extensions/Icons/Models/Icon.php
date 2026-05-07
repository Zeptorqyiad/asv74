<?php
namespace App\Extensions\Icons\Models;

use Simflex\Core\ModelBase;

/**
 * @property int icon_id
 * @property string icon
 * @property string viewbox
 * @property string content
 */
class Icon extends ModelBase
{
    protected static $table = 'icon';
    protected static $primaryKeyName = 'icon_id';
}