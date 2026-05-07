<?php

namespace App\Extensions\Site\Model;

use App\Extensions\Catalog\Model\Product;
use App\Extensions\Catalog\SessionAssist;
use Simflex\Core\Buffer;
use Simflex\Core\DB;
use Simflex\Core\ModelBase;

class Compare extends ModelBase
{
    protected static $table = 'catalog_compare';
    protected static $primaryKeyName = 'compare_id';

    public static function getOrInsert(int $id = 0)
    {
        return Buffer::getOrSet('compare', function () use ($id) {
            $del = function ($id) {
                $q = DB::query(
                    'select compare_id from catalog_compare where user_id = ? and sess_id <> ?',
                    [$id, SessionAssist::getId()]
                );
                while ($r = DB::fetch($q)) {
                    DB::query('delete from catalog_compare_product where compare_id = ?', [$r['compare_id']]);
                    DB::query('delete from catalog_compare where compare_id = ?', [$r['compare_id']]);
                }
            };

            $compare = self::findOne(['sess_id' => SessionAssist::getId()]);
            if (!$compare) {
                if (($compare = self::findOne(['user_id' => $id]))) {
                    $compare->sess_id = SessionAssist::getId();
                    $compare->save();
                    $compare->reload();
                    $del($id);
                    return $compare;
                }

                $compare = new self;
                $id ? ($compare->user_id = $id) : ($compare->sess_id = SessionAssist::getId());
            } else {
                // fixes a bug that you get your cart emptied per login
                if ($id && ($compare2 = self::findOne(['user_id' => $id]))) {
                    $compare2->sess_id = SessionAssist::getId();
                    $compare2->save();
                    $compare2->reload();
                    $del($id);
                    return $compare2;
                }

                if ($id && !$compare->user_id) {
                    $del($id);
                }

                $compare->user_id = $id;
            }

            $compare->save();
            $compare->reload();

            $del($id);
            return $compare;
        });
    }

    public function getList()
    {
        $out = [];

        $q = DB::query(
            'select product_id, variant_id from catalog_compare_product where compare_id = ?',
            [$this->compare_id]
        );
        while ($r = DB::fetch($q)) {
            $p = new Product($r['product_id']);
            $p->variant_id = $r['variant_id'];
            $out[] = $p;
        }

        return $out;
    }

    public function inList(int $prod, ?int $var): bool
    {
        $in = Buffer::getOrSet('comparearr', function () {
            $arr = [];

            $q = DB::query(
                'select product_id, variant_id from catalog_compare_product where compare_id = ?',
                [$this->compare_id]
            );
            while ($r = DB::fetch($q)) {
                $arr[] = $r['product_id'] . '.' . (int)$r['variant_id'];
            }

            return $arr;
        });

        return in_array($prod . '.' . ($var ?? 0), $in);
    }

    public function addProduct(int $id, ?int $var): bool
    {
        if ($this->inList($id, $var)) {
            return true;
        }

        return !!DB::query(
            'insert into catalog_compare_product (compare_id, product_id, variant_id) values (?, ?, ?)',
            [$this->compare_id, $id, $var ?? 0]
        );
    }

    public function removeProduct(int $id, ?int $var): bool
    {
        return !!DB::query(
            'delete from catalog_compare_product where compare_id = ? and product_id = ? and variant_id = ?',
            [$this->compare_id, $id, $var ?? 0]
        );
    }

    public function getProductCount(): int
    {
        return DB::result('select count(*) from catalog_compare_product where compare_id = ?', 0, [$this->compare_id]);
    }
}