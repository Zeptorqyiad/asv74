<?php

namespace App\Extensions\Site\Component;

use App\Extensions\Catalog\Model\Category;
use App\Extensions\Catalog\Model\Product;
use App\Extensions\Site\Model\Addon;
use Simflex\Core\DB;
use Simflex\Core\Helpers\Str;

class Search extends \App\Extensions\Catalog\Component\Search
{
    protected function content()
    {
        if (($_REQUEST['a'] ?? '') == 'city') {
            $this->searchCity();
        }

        if (($_REQUEST['a'] ?? '') == 'stats') {
            $this->getStats();
        }

        $inp = DB::escape($_REQUEST['q']);
        $tot = Product::findAdv()->select('count(*)')
            ->where("(name like '%$inp%' or sku like '%$inp%')")
            ->andWhere('is_active = 1')
            ->fetchScalar() ?? 0;
        $tot += Addon::findAdv()->select('count(*)')
            ->where("(name like '%$inp%' or sku like '%$inp%')")
            ->andWhere('is_active = 1')
            ->fetchScalar() ?? 0;

        $out = [
            'items' => [],
            'cats' => [],
            'tot' => $tot,
            'tot_text' => Str::pluralize($tot, 'товар'),
        ];

        $cats = Category::findAdv()->where("name like '%$inp%'")->andWhere('is_active = 1')->limit(10)->all();
        foreach ($cats as $cat) {
            $out['cats'][] = [
                'cat_id' => $cat->category_id,
                'img' => '/uf/images/source/' . $cat->photo,
                'name' => $cat->name,
                'path' => '/' . $cat->path . '/'
            ];
        }

        $prods = Product::findAdv()
            ->where("(name like '%$inp%' or sku like '%$inp%')")
            ->andWhere('is_active = 1')
            ->limit('5')->all();

        $addons = Addon::findAdv()
            ->where("(name like '%$inp%' or sku like '%$inp%')")
            ->andWhere('is_active = 1')
            ->limit('5')->all();

        $arrItems = array_slice(array_merge($prods, $addons), 0, 5);

        foreach ($arrItems as $p) {
            $out['items'][] = [
                'product_id' => isset($p['product_id']) ? $p->product_id : $p->addon_id,
                'sku' => $p->sku,
                'img' => isset($p['product_id']) ? $p->getPreviewImage() : ($p->image ? '/uf/images/source/' . $p->image : '/uf/images/no_image.png'),
                'name' => $p->name,
                'price' => $p->price,
                'price_old' => $p->price_old,
                'stock' => $p->stock,
                'path' => '/' . $p->path . '/'
            ];
        }

        exit(json_encode($out, JSON_UNESCAPED_UNICODE));
    }
}