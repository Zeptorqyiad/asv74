<?php

namespace App\Extensions\Site\Model;

use App\Extensions\Catalog\Model\Category;
use App\Extensions\Catalog\SaleAssist;
use Simflex\Core\Buffer;
use Simflex\Core\DB;
use Simflex\Core\DB\AQ;
use Simflex\Core\Models\Attrib\FieldOne;
use Simflex\Core\Models\User;

/**
 * @property User manager
 */
class Product extends \App\Extensions\Catalog\Model\Product
{
    public static function listLookupCount(int $listId, array $filter, $in = [])
    {
        $in = implode(',', $in);

        $pvs = '';
        foreach ($filter[1] as $pv) {
            $pvs .= "LEFT JOIN catalog_param_value pv$pv ON pv$pv.product_id = t.product_id AND coalesce(pv$pv.variant_id, 0) = 0\n";
        }

        $cpvs = '';
        foreach ($filter[5] as $pv) {
            $cpvs .= "LEFT JOIN catalog_chassis_param_value cpv$pv ON cpv$pv.chassis_id = t.chassis_id\n";
        }

        $apvs = '';
        foreach ($filter[4] as $pv) {
            $apvs .= "LEFT JOIN catalog_addon_param_value apv$pv ON apv$pv.addon_id = t.addon_id\n";
        }

        $qw = ' AND ' . $filter[0];
        if ($filter[6]) {
            $jopa = ' AND ' . $filter[6];
        } else {
            $jopa = '';
        }

        if (trim($qw) == 'AND') {
            $qw = '';
        }
        if (trim($jopa) == 'AND') {
            $jopa = '';
        }

        if (str_contains($qw, 'AND (t.name like :search or t.sku like :search)')) {
            $jopa .= ' AND (t.name like :search or t.sku like :search) ';
        }

        $q = "WITH RankedDiscounts AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY discounted_price ASC) AS rn
    FROM v_product_discounted_price
)
SELECT COUNT(*) 
         FROM `catalog_product` t
                     JOIN catalog_product_list_p lp ON lp.product_id = t.product_id
                  $pvs
                  $cpvs
                  $apvs
                  INNER JOIN RankedDiscounts vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
                  JOIN catalog_p2c cpc ON t.product_id = cpc.product_id
                  LEFT JOIN catalog_stock st ON st.product_id = t.product_id
         WHERE t.is_active = 1 AND lp.list_id = :list_id AND cpc.category_id IN ($in)
           $qw 
           $jopa
         ";

        return DB::result($q, 0, array_merge($filter[3] ?? [], ['list_id' => $listId]));
    }

    public static function listLookup(int $listId, array $filter, string $order = '', string $limit = '', $in = [])
    {
        $in = implode(',', $in);

        $q = (new AQ())->from('catalog_product', 't')
            ->select(
                't.*, null as variant_id, coalesce(vdp.discounted_price / vdp.original_price, 0) as discount, avg(rv.rating) as rating, vdp.discounted_price as price, vdp.discounted_price as sorter, vdp.original_price as price_old, st.available as stock, null as image'
            )
            ->setModelClass(\App\Extensions\Catalog\Model\Product::class);

        $pvs = '';
        if ($filter[0]) {
            foreach ($filter[1] as $pv) {
                $pvs .= "LEFT JOIN catalog_param_value pv$pv ON pv$pv.product_id = t.product_id AND coalesce(pv$pv.variant_id, 0) = 0\n";
            }
        }

        $cpvs = '';
        if ($filter[0]) {
            foreach ($filter[5] as $pv) {
                $cpvs .= "LEFT JOIN catalog_chassis_param_value cpv$pv ON cpv$pv.chassis_id = t.chassis_id\n";
            }
        }

        $apvs = '';
        if ($filter[6]) {
            foreach ($filter[4] as $pv) {
                $apvs .= "LEFT JOIN catalog_addon_param_value apv$pv ON apv$pv.addon_id = t.addon_id\n";
            }
        }

        $qw = "
                JOIN catalog_product_list_p lp ON lp.product_id = t.product_id
                INNER JOIN catalog_p2c cpc ON t.product_id = cpc.product_id
                $pvs
                $apvs
                $cpvs
                LEFT JOIN review rv ON rv.product_id = t.product_id
                LEFT JOIN catalog_stock st ON st.product_id = t.product_id
                INNER JOIN RankedDiscounts AS vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
WHERE t.is_active = 1 AND lp.list_id = :list_id  AND cpc.category_id IN ($in)
  ";

        if (trim($filter[0])) {
            $qw .= ' AND ' . $filter[0] . ' ';
        }

        if (trim($filter[6])) {
            $qw .= ' AND ' . $filter[6] . ' ';
        }

        $qw .= ' GROUP BY t.product_id, vdp.discounted_price, vdp.original_price, st.available ';

        if ($order) {
            $qw .= ' ORDER BY ' . $order . ' ';
        }

        if ($limit) {
            $qw .= ' LIMIT ' . $limit . ' ';
        }

        $q->custom($qw);
        $q->prefix(
            "WITH RankedDiscounts AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY discounted_price ASC) AS rn
    FROM v_product_discounted_price
)"
        );

        $q->bind($filter[3] ?? []);
        $q->bind(['list_id' => $listId]);
        return $q->all();
    }

    public function offsetGetManager()
    {
        return User::findOne(['user_id' => $this->manager_id]);
    }

    public function getProdImages(): array
    {
        $data = json_decode($this->photos2, true);
        if (!$data || !isset($data['v']) || !$data['v']) {
            return [asset('images/placeholders/fallback-img.webp', true)];
        }

        $v = $data['v'];
        return array_map(function ($e) {
            return $e['img'];
        }, $v);
    }

    public function getImages(): array
    {
        if($this->product_id) {
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
        } elseif (!$this->product_id && $this->addon_id && $this->image) {
            return ['/uf/images/source/' . $this->image];
        } else {
            return ['/uf/images/source/' . $this->stock];
        }
    }

    public static function findWithVdp($where, $orderBy = null, $limit = null, $assocKey = false): array
    {
        $ret = static::findAdv()->andWhere($where)->orderBy($orderBy)->limit($limit)->leftJoin(
            'v_product_discounted_price',
            'product_id'
        )->all($assocKey);
        SaleAssist::preheat(array_map(fn($i) => $i->product_id, $ret));
        return $ret;
    }

    public function getFirstCategory()
    {
        return $this->id ? Buffer::getOrSet(
            'prod.' . $this->id . '.firstcat',
            fn() => Category::findOne(
                'category_id in (select category_id from catalog_p2c where product_id = ' . $this->product_id . ')'
            )
        ) : Buffer::getOrSet('addon.' . $this->addon_id . '.firstcat', fn() => Category::findOne('category_id in (select category_id from catalog_a2c where addon_id = ' . $this->addon_id . ')'));
    }

    public function getFullSpecs(): array
    {
        $ret = [
            'p' => [],
            'c' => [],
            'a' => [],
        ];

        if ($this->product_id) {
            $params = \App\Extensions\Catalog\Model\Param::getAllForCategory($this->getFirstCategory()->category_id, false);
            $vals = \App\Extensions\Catalog\Model\ParamValue::getList($this->product_id);

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
                    if (!$vals[$param->param_id]) {
                        continue;
                    }

                    $cat['values'][] = [
                        'name' => trim($param->name),
                        'value' => $vals[$param->param_id] ?? ''
                    ];
                }

                if ($cat['values']) {
                    $ret['p'][] = $cat;
                }
            }
        }

        if ($this->addon_id) {
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
        }

        if ($this->chassis_id) {
            $params = \App\Extensions\Site\Model\Chassis\Param::all();
            $vals = \App\Extensions\Site\Model\Chassis\ParamValue::getList($this->chassis_id);

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
                    if (!$vals[$param->chassis_param_id]) {
                        continue;
                    }

                    $cat['values'][] = [
                        'name' => trim($param->name),
                        'value' => $vals[$param->chassis_param_id] ?? ''
                    ];
                }

                if ($cat['values']) {
                    $ret['c'][] = $cat;
                }
            }
        }

        return $ret;
    }
}