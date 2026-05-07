<?php

namespace App\Extensions\Services\Model;

use Simflex\Core\ModelBase;

/**
 * @property int serv_p2c_id
 * @property int services_id
 * @property boolean product_id
 */

class ServicesP2C extends ModelBase
{
    protected static $table = 'services_p2c_product';
    protected static $primaryKeyName = 'serv_p2c_id';
}