<?php

namespace App\Extensions\Site\Admin;

use Simflex\Core\DB;

class Product extends \App\Extensions\Catalog\Admin\Product
{
    public function save()
    {
        $ret = parent::save();
        if ($ret && !$_REQUEST['sku']) {
            $prod = \App\Extensions\Site\Model\Product::findOne(['product_id' => $ret]);
            $prod->sku = ($prod->getFirstCategory()->category_id ?? 0) . '-' . $ret;
            $prod->save();
        }

        return $ret;
    }
}