<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int brand_id
 * @property int npp
 * @property bool is_official
 * @property bool show_on_index
 * @property string name
 * @property string photo
 * @property string desc
 *
 */
class CatalogBrand extends ModelBase
{
    protected static $table = 'catalog_brand';
    protected static $primaryKeyName = 'brand_id';
}