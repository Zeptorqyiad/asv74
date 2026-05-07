<?php
namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

class ProductList extends ModelBase
{
    protected static $primaryKeyName = 'list_id';
    protected static $table = 'catalog_product_list';
}