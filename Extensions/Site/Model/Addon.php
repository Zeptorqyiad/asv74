<?php

namespace App\Extensions\Site\Model;

use App\Extensions\Catalog\Model\Category;
use Simflex\Core\Buffer;
use Simflex\Core\ModelBase;

class Addon extends ModelBase
{
    protected static $table = 'catalog_addon';
    protected static $primaryKeyName = 'addon_id';

    public function getFirstCategory()
    {
        return Buffer::getOrSet('addon.' . $this->addon_id . '.firstcat', fn() => Category::findOne('category_id in (select category_id from catalog_a2c where addon_id = ' . $this->addon_id . ')'));
    }

    public function getAnyStockCount()
    {
        return 0;
    }

    public function inSale()
    {
        return $this->price != $this->price_old;
    }

    public function getAllCategories()
    {
        return Buffer::getOrSet('addon.' . $this->id . '.allcats', fn() => Category::findAdv()
            ->where('category_id in (select category_id from catalog_a2c where addon_id = ' . $this->addon_id . ')')
            ->all());
    }

    public function getDocs()
    {
        return [];
    }

    public function getLinked2()
    {
        return [];
    }

    public function getFullSpecs(): array
    {
        $ret = [
            'p' => [],
            'c' => [],
            'a' => [],
        ];

        $params = \App\Extensions\Site\Model\Addon\Param::all();
        $vals = \App\Extensions\Site\Model\Addon\ParamValue::getList($this->addon_id);

        $grouped = [];
        $seen = [];
        foreach ($params as $par) {
            if (in_array($par->getId(), $seen)) {
                continue;
            }

            $grouped[$par->getCategoryName()][] = $par;
            $seen[] = $par->getId();
        }

        foreach ($grouped as $category => $params) {
            $cat = [
                'name' => $category,
                'values' => []
            ];

            foreach ($params as $param) {
                if (!$vals[$param->addon_param_id]) {
                    continue;
                }

                $cat['values'][] = [
                    'name' => trim($param->name),
                    'value' => $vals[$param->addon_param_id] ?? ''
                ];
            }

            if ($cat['values']) {
                $ret['a'][] = $cat;
            }
        }

        return $ret;
    }

    public function getImages(): array
    {
        $data = json_decode($this->photo, true);
        if (!$data || !isset($data['v']) || !$data['v']) {
            if (!$this->product_id && $this->image) {
                return ['/uf/images/source/' . $this->image];
            }

            return [asset('images/placeholders/fallback-img.webp', true)];
        }

        $v = $data['v'];
        usort($v, function ($a, $b) {
            return $a['order'] > $b['order'];
        });

        return array_map(function ($e) {
            return $e['img'];
        }, $v);
    }
}