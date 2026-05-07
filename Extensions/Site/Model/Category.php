<?php

namespace App\Extensions\Site\Model;

use App\Extensions\Catalog\CategoryAssist;
use App\Extensions\Catalog\Model\Product;
use Simflex\Core\Buffer;
use Simflex\Core\DB;
use Simflex\Core\DB\AQ;
use Simflex\Core\DB\Where;
use Simflex\Core\Profiler;

class Category extends \App\Extensions\Catalog\Model\Category
{
    public static function find(
        string|array|Where $where,
        ?string            $orderBy = null,
        ?string            $limit = null,
        bool|string        $assocKey = false
    ): array
    {
        $id = md5(
            (is_string($where) ? $where : implode(
                ';',
                array_map(function ($k, $v) {
                    return $k . '.' . $v;
                }, array_keys($where), array_values($where))
            )) . '.' . ($orderBy ?? '') . '.' . ($limit ?? '') . '.' . ($assocKey ? '1' : '0')
        );

        return Buffer::getOrSet('cat.find.' . $id, function () use ($where, $orderBy, $limit, $assocKey) {
            return parent::find($where, $orderBy, $limit, $assocKey);
        });
    }

    public function accumulateBanners(): array
    {
        $list = json_decode($this->banners, true)['v'] ?? [];
        foreach ($this->getAllChildren() as $childId) {
            $child = new \App\Extensions\Catalog\Model\Category($childId);
            $list = array_merge($list, json_decode($child->banners, true)['v'] ?? []);
        }

        return $list;
    }

    /**
     * @return Product[]
     */
    public function getProducts($limit = '', $order = '', $filter = [])
    {
        if (is_string($filter)) {
            $filter = [$filter, []];
        }

        Profiler::traceStart($this, __FUNCTION__);
        $ret = Buffer::getOrSet(
            'cat.' . $this->id . '.products.' . md5($limit . '.' . $order . '.' . ($filter[0] ?? '')),
            function () use ($limit, $order, $filter) {
                $cats = $this->getAllChildren();
                $cats[] = $this->category_id;
                $in = implode(',', $cats);

                $q = (new AQ())->from('catalog_product', 't')
                    ->select(
                        't.*, 
                        null as variant_id, 
                        coalesce(vdp.discounted_price / vdp.original_price, 0) as discount, 
                        avg(rv.rating) as rating, 
                        vdp.discounted_price as price, 
                        vdp.discounted_price as sorter, 
                        vdp.original_price as price_old, 
                        st.available as stock, 
                        null as image'
                    )
                    ->setModelClass(Product::class);

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

                $qw = "INNER JOIN catalog_p2c cpc ON t.product_id = cpc.product_id
                $pvs
                $cpvs
                $apvs
                LEFT JOIN review rv ON rv.product_id = t.product_id
                LEFT JOIN catalog_stock st ON st.product_id = t.product_id
                INNER JOIN RankedDiscounts AS vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
WHERE t.is_active = 1
AND cpc.category_id IN ($in)
  ";

                if ($filter[0]) {
                    $qw .= ' AND ' . $filter[0] . ' ';
                }

                if ($filter[6]) {
                    $qw .= ' AND ' . $filter[6] . ' ';
                }

                $qw .= ' GROUP BY t.product_id, vdp.discounted_price, vdp.original_price, st.available ';

                $jopa = '';
                if (trim($filter[6])) {
                    $jopa .= ' AND ' . $filter[6] . ' ';
                }

                $qw2 = '';
                if ($filter[2] ?? '') {
                    $qw2 = ' AND ' . $filter[2];
                }

                $jopa = str_replace('AND vdp.discounted_price <= :price_max', 'AND t.price <= :price_max', $jopa);
                $jopa = str_replace(['AND st.available > 0', 'AND t.is_popular = 1'], '', $jopa);
                $qw2 = str_replace('AND vdp.discounted_price <= :price_max', 'AND t.price <= :price_max', $qw2);
                $qw2 = str_replace(['AND st.available > 0', 'AND t.is_popular = 1'], '', $qw2);

                // var selector
                $qw .= "
                UNION ALL

SELECT
    null                                           as product_id,
    t.is_active,
    (coalesce(t.npp, 1) + 100000)                  as npp,
    t.alias,
    t.path,
    t.name,
    t.description                                  as `desc`,
    t.photo,
    ''                                             as meta_title,
    ''                                             as meta_desc,
    ''                                             as meta_keywords,
    t.is_new,
    0                                              as new_timeout,
    t.is_popular,
    ''                                             as seo,
    t.sku,
    t.price                                        as `t.price`,
    0                                              as price_base,
    0                                              as stock,
    ''                                             as seo2,
    ''                                             as seo_title,
    ''                                             as seo_title2,
    ''                                             as about,
    ''                                             as tags_prim,
    ''                                             as tags_sec,
    ''                                             as button_text,
    ''                                             as docs,
    0                                              as is_of_the_day,
    null                                           as brand_id,
    ''                                             as weight,
    ''                                             as size,
    ''                                             as guarantee,
    0                                              as bulk_amount,
    ''                                             as bulk_help,
    null                                           as chassis_id,
    t.addon_id,
    t.manager_id,
    ''                                             as visualizer,
    ''                                             as video,
    t.plan,
    t.plan_photo,
    t.plan_desc,
    ''                                             as side_video,
    ''                                             as chassis_image,
    ''                                             as param_image,
    ''                                             as otts,
    t.is_primary,
    ''                                             as fabric,
    t.card_desc,
    null                                           as chassis_dependent,
    null                                           as variant_id,
    coalesce(t.price / t.price_old, 0)             as discount,
    0                                              as rating,
    t.price                                        as price,
    (t.price * coalesce(t.price / t.price_old, 0)) as sorter,
    t.price_old                                    as price_old,
    0                                              as stock,
    t.image
FROM
    catalog_addon t
    INNER JOIN catalog_a2c cpc ON cpc.addon_id = t.addon_id
        $apvs
       
WHERE
    t.is_active = 1
    AND cpc.category_id IN ($in)
    $jopa
    $qw2
GROUP BY
    t.addon_id
                ";

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

                $all = $q->all();
                CategoryAssist::queryLinks($all);
                return $all;
            }
        );
        Profiler::traceEnd($this, __FUNCTION__);
        return $ret;
    }

    public function getProductCount($filter = [])
    {
        if (is_string($filter)) {
            $filter = [$filter, []];
        }

        Profiler::traceStart($this, __FUNCTION__);
        if (!$filter[0]) {
            $ret = CategoryAssist::$categoryCounts[$this->category_id] ?? 0;
            Profiler::traceEnd($this, __FUNCTION__);
            return $ret;
        }

        $ret = Buffer::getOrSet('cat.' . $this->id . '.count.' . md5($filter[0]), function () use ($filter) {
            $cats = $this->getAllChildren();
            $cats[] = $this->category_id;
            $in = implode(',', array_filter($cats, function ($c) {
                return !!$c;
            }));

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

            $qw2 = '';
            $qw = ' AND ' . $filter[0];
            if ($filter[2] ?? '') {
                $qw2 = ' AND ' . $filter[2];
            }

            $jopa = ' AND ' . $filter[6];

            if (trim($qw) == 'AND') {
                $qw = '';
            }
            if (trim($jopa) == 'AND') {
                $jopa = '';
            }

            $q = "WITH RankedDiscounts AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY discounted_price ASC) AS rn
    FROM v_product_discounted_price
)
SELECT COUNT(*) AS total_count
FROM (
         SELECT t.product_id
         FROM `catalog_product` t
         INNER JOIN catalog_p2c cpc ON t.product_id = cpc.product_id
                  $pvs
                  $cpvs
                  $apvs
                  INNER JOIN RankedDiscounts vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
                  LEFT JOIN catalog_stock st ON st.product_id = t.product_id
         WHERE t.is_active = 1 AND cpc.category_id IN ($in)
           $qw
           $jopa
         GROUP BY t.product_id

         UNION ALL
         ";

            $jopa = str_replace('AND vdp.discounted_price <= :price_max', 'AND t.price <= :price_max', $jopa);
            $jopa = str_replace(['AND st.available > 0', 'AND t.is_popular = 1'], '', $jopa);
            $qw2 = str_replace('AND vdp.discounted_price <= :price_max', 'AND t.price <= :price_max', $qw2);
            $qw2 = str_replace(['AND st.available > 0', 'AND t.is_popular = 1'], '', $qw2);

            $q .= "SELECT t.addon_id
         FROM catalog_addon t
         INNER JOIN catalog_a2c cpc ON t.addon_id = cpc.addon_id
                  $apvs
         WHERE t.is_active = 1 AND cpc.category_id IN ($in)
           $jopa
         $qw2
         GROUP BY t.addon_id
     ) AS combined;";

            return DB::result($q, 0, $filter[3] ?? []);
        });
        Profiler::traceEnd($this, __FUNCTION__);
        return $ret;
    }
}