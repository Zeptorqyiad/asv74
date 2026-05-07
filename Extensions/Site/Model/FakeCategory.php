<?php

namespace App\Extensions\Site\Model;

use App\Extensions\Catalog\CategoryAssist;
use App\Extensions\Catalog\Model\Product;
use Simflex\Core\Buffer;
use Simflex\Core\DB;
use Simflex\Core\Profiler;
use Simflex\Core\DB\AQ;

class FakeCategory extends \App\Extensions\Catalog\Model\FakeCategory
{
    public function getProducts($limit = '', $order = '', $filter = '')
    {
        if (is_string($filter)) {
            $filter = [$filter, []];
        }

        Profiler::traceStart($this, __FUNCTION__);
        $ret = Buffer::getOrSet(
            'gcat.products.' . md5($limit . '.' . $order . '.' . ($filter[0] ?? '')),
            function () use ($limit, $order, $filter) {
                $q = (new AQ())->from('catalog_product', 't')
                    ->select(
                        't.*, null as variant_id, coalesce(vdp.discounted_price / vdp.original_price, 0) as discount, avg(rv.rating) as rating, vdp.discounted_price as price, vdp.discounted_price as sorter, vdp.original_price as price_old, st.available as stock, null as image'
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

                $jopa = '';
                if (trim($filter[6])) {
                    $jopa .= ' AND ' . $filter[6] . ' ';
                }

                $qw = "
                $pvs
                $apvs
                $cpvs
                LEFT JOIN review rv ON rv.product_id = t.product_id
                LEFT JOIN catalog_stock st ON st.product_id = t.product_id
                INNER JOIN RankedDiscounts AS vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
WHERE t.is_active = 1
  ";

                if (trim($filter[0])) {
                    $qw .= ' AND ' . $filter[0] . ' ';
                }

                if (trim($filter[6])) {
                    $qw .= ' AND ' . $filter[6] . ' ';
                }

                $qw .= ' GROUP BY t.product_id, vdp.discounted_price, vdp.original_price, st.available ';

                $qw2 = '';
                if ($filter[2] ?? '') {
                    $qw2 = ' AND ' . $filter[2];
                }

                if (str_contains($qw, 'AND (t.name like :search or t.sku like :search)')) {
                    $jopa .= ' AND (t.name like :search or t.sku like :search) ';
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
        $apvs
WHERE
    t.is_active = 1
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
            $filter = [$filter, [], '', []];
        }

        Profiler::traceStart($this, __FUNCTION__);
        if (!$filter[0]) {
            $ret = DB::result('select count(*) from catalog_product where is_active = 1', 0) + DB::result('select count(*) from catalog_addon where is_active = 1', 0);
            Profiler::traceEnd($this, __FUNCTION__);
            return $ret;
        }

        $ret = Buffer::getOrSet('gcat.count.' . md5($filter[0]), function () use ($filter) {
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
SELECT COUNT(*) AS total_count
FROM (
         SELECT t.product_id
         FROM `catalog_product` t
                  $pvs
                  $cpvs
                  $apvs
                  INNER JOIN RankedDiscounts vdp ON t.product_id = vdp.product_id AND vdp.rn = 1
                  LEFT JOIN catalog_stock st ON st.product_id = t.product_id
         WHERE t.is_active = 1
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
                  $apvs
         WHERE t.is_active = 1
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