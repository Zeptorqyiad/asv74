<?php
namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

class Option extends ModelBase
{
    protected static $table = 'catalog_option';
    protected static $primaryKeyName = 'option_id';
}