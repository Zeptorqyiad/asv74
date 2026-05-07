<?php

namespace App\Extensions\Site;

use App\Extensions\Site\Model\Addon;
use App\Extensions\Site\Model\Category;
use App\Extensions\Site\Model\Product;
use Simflex\Core\Console\Command;
use Simflex\Core\ConsoleBase;
use Simflex\Core\Helpers\Str;
use Simflex\Core\Log;

class Console extends ConsoleBase
{
    #[Command]
    public function rebuildPaths()
    {
        foreach (Category::all() as $cat) {
            if (!$cat->alias) {
                $cat->alias = Str::translite($cat->name);
            }

            $path = [$cat->alias];
            $par = $cat->getParent();
            while ($par) {
                if (!$par->alias) {
                    $par->alias = Str::translite($par->name);
                    $par->save();
                }

                $path[] = $par->alias;
                $par = $par->getParent();
            }

            $path[] = 'catalog';
            $cat->path = implode('/', array_reverse($path));
            $cat->save();

            Log::info('rebuilt category {n}', ['n' => $cat->name]);
        }

        foreach (Product::all() as $prod) {
            if (!$prod->alias) {
                $prod->alias = Str::translite($prod->name);
            }

            $cat = $prod->getFirstCategory();
            if (!$cat) {
                $prod->save();
                Log::error('no category found for product {n}', ['n' => $prod->name]);
                continue;
            }

            $prod->path = $cat->path . '/' . $prod->alias;
            $prod->save();

            Log::info('rebuilt product {n}', ['n' => $prod->name]);
        }
    }

    #[Command]
    public function rebuildAddons()
    {
        foreach (Addon::all() as $addon) {
            $addon->alias = Str::translite($addon->name);
            if (Product::findOne(['alias' => $addon->alias]) || Category::findOne(['alias' => $addon->alias])) {
                $addon->alias .= '_' . $addon->addon_id;
            }

            $cat = $addon->getFirstCategory();
            if (!$cat) {
                $addon->save();
                Log::error('no category found for addon {n}', ['n' => $addon->name]);
                continue;
            }

            $addon->path = $cat->path . '/' . $addon->alias;
            $addon->save();

            Log::info('rebuild addon {n}', ['n' => $addon->name]);
        }
    }

    #[Command]
    public function genSkus()
    {
        foreach (Product::all() as $prod) {
            $prod->sku = ($prod->getFirstCategory()->category_id ?? 0) . '-' . $prod->product_id;
            $prod->save();

            Log::info('generated sku for {n}', ['n' => $prod->name]);
        }

        foreach (Addon::all() as $addon) {
            if (($cat = $addon->getFirstCategory())) {
                $addon->sku = $cat->category_id . '-' . $addon->addon_id;
                $addon->save();

                Log::info('generated sku for addon {n}', ['n' => $addon->name]);
            }
        }
    }
}