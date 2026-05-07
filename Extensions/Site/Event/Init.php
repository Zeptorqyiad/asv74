<?php

namespace App\Extensions\Site\Event;

use App\Extensions\Catalog\CategoryAssist;
use App\Extensions\Catalog\LoadAssist;
use App\Extensions\Catalog\MailAssist;
use App\Extensions\Catalog\Model\Category;
use App\Extensions\Catalog\Model\FakeCategory;
use App\Extensions\Catalog\Model\Product;
use App\Extensions\Catalog\Price\PriceManager;
use App\Extensions\Catalog\Price\SaleProxy;
use App\Extensions\Catalog\SessionAssist;
use App\Extensions\Site\Model\Compare;
use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Events\EventListener;
use Simflex\Core\Events\GroupEvents;
use Simflex\Core\Factory;
use Simflex\Core\Request;

class Init implements EventListener
{
    use GroupEvents;

    public function onPreInit(Request $request, Factory $factory, PriceManager $pm)
    {
        CategoryAssist::$counters[] = function (int $categoryId) {
            return DB::result('select count(*) from catalog_addon a left join catalog_a2c ac on ac.addon_id = a.addon_id where a.is_active = 1 and ac.category_id = ?', 0, [$categoryId]);
        };

        if (SF_LOCATION == SF_LOCATION_CLI) {
            return;
        }

        LoadAssist::load();
        CategoryAssist::loadCounts();

        MailAssist::$tplPath = __DIR__ . '/../';

        $lastUpdate = (int)file_get_contents(SF_ROOT_PATH . '/cache/filter_update');
        if (time() - $lastUpdate > 84600) {
            file_put_contents(SF_ROOT_PATH . '/cache/filter_update', time());

            $cg = new \App\Extensions\Catalog\CacheGen();
            $cg->updateAll();
        }

        $pm->addProxy(new SaleProxy());

        if (SF_LOCATION == SF_LOCATION_SITE) {
            // don't do this on import... you idiot
            if (!str_contains($request->getPath(), 'import')) {
                $user = Container::getUser();
//                \App\Extensions\Catalog\SessionAssist::$cart = \App\Extensions\Catalog\Model\Cart::getOrInsert(
//                    $user->user_id ?: 0
//                );
//                \App\Extensions\Catalog\SessionAssist::$fav = \App\Extensions\Catalog\Model\Fav::getOrInsert(
//                    $user->user_id ?: 0
//                );

                SessionAssist::$compare = Compare::getOrInsert($user->user_id ?? 0);
            }
        }

        $factory->override(Product::class, \App\Extensions\Site\Model\Product::class);
        $factory->override(Category::class, \App\Extensions\Site\Model\Category::class);
        $factory->override(FakeCategory::class, \App\Extensions\Site\Model\FakeCategory::class);
    }
}