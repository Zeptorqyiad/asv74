<?php

namespace App\Extensions\Site\Component;

use App\Extensions\Catalog\Model\Category;
use App\Extensions\Catalog\Model\FakeCategory;
use App\Extensions\Catalog\Model\Product;
use App\Extensions\Site\Model\Addon;
use Simflex\Core\Container;
use Simflex\Core\Profiler;

class Catalog extends \App\Extensions\Catalog\Component\Catalog
{
    protected function makeFilter()
    {
        $params = [];

        $filter = $this->makeQFilter();
        $params = array_merge($params, $filter[1]);
        $filter = $filter[0];

        $addy = '';
        if (($f2 = $this->makeWFilter())[0]) {
            $params = array_merge($params, $f2[1]);
            $f2 = $f2[0];
            $f2Temp = explode(' and ', $f2);
            $addy = $f2Temp[1] ?? '';
            $f2 = $f2Temp[0];

            if ($filter) {
                $filter .= ' AND ';
            }

            $filter .= $f2;
        }

        $r = Container::getRequest();
        if ($f = $r->request('price_min')) {
            if ($filter) {
                $filter .= ' AND ';
            }

            $filter .= 'vdp.discounted_price >= :price_min';
            $params['price_min'] = $f;
        }

        if ($f = $r->request('price_max')) {
            if ($filter) {
                $filter .= ' AND ';
            }

            $filter .= 'vdp.discounted_price <= :price_max';
            $params['price_max'] = $f;
        }

        foreach ($r->request() as $k => $v) {
            if ($k && isset($this->filterToString[$k])) {
                if ($filter) {
                    $filter .= ' AND ';
                }

                $filter .= $this->filterToString[$k][0];
            }
        }

        if ($f = $r->request('brand')) {
            if ($filter) {
                $filter .= ' AND ';
            }

            $bPl = [];
            $bVals = [];

            foreach ($f as $c) {
                $bPl[] = ':brand_' . crc32($c);
                $bVals['brand_' . crc32($c)] = $c;
            }

            $filter .= 't.brand_id in (' . implode(',', $bPl) . ')';
            $params = array_merge($bVals, $params);
        }

        $pQuery = [];
        $pvs = [];
        foreach ($r->request() as $k => $fa) {
            if (!str_starts_with($k, 'param_')) {
                continue;
            }

            $pPl = [];
            $pVals = [];
            $paramId = (int)substr($k, strlen('param_'));

            if (!is_array($fa)) {
                $fa = [$fa];
            }

            foreach ($fa as $a) {
                $pPl[] = ':param_' . $paramId . '_' . crc32($a);
                $pVals['param_' . $paramId . '_' . crc32($a)] = $a;
            }

            $pQuery[] = "(pv$paramId.param_id = $paramId AND pv$paramId.value IN (" . implode(',', $pPl) . "))";
            $params = array_merge($params, $pVals);
            $pvs[] = $paramId;
        }

        $cpvs = [];
        foreach ($r->request() as $k => $fa) {
            if (!str_starts_with($k, 'cparam_')) {
                continue;
            }

            $pPl = [];
            $pVals = [];
            $paramId = (int)substr($k, strlen('cparam_'));

            if (!is_array($fa)) {
                $fa = [$fa];
            }

            foreach ($fa as $a) {
                $pPl[] = ':cparam_' . $paramId . '_' . crc32($a);
                $pVals['cparam_' . $paramId . '_' . crc32($a)] = $a;
            }

            $pQuery[] = "(cpv$paramId.chassis_param_id = $paramId AND cpv$paramId.value IN (" . implode(',', $pPl) . "))";
            $params = array_merge($params, $pVals);
            $cpvs[] = $paramId;
        }

        $aQuery = [];
        $apvs = [];
        foreach ($r->request() as $k => $fa) {
            if (!str_starts_with($k, 'aparam_')) {
                continue;
            }

            $pPl = [];
            $pVals = [];
            $paramId = (int)substr($k, strlen('aparam_'));

            if (!is_array($fa)) {
                $fa = [$fa];
            }

            foreach ($fa as $a) {
                $pPl[] = ':aparam_' . $paramId . '_' . crc32($a);
                $pVals['aparam_' . $paramId . '_' . crc32($a)] = $a;
            }

            $aQuery[] = "(apv$paramId.addon_param_id = $paramId AND apv$paramId.value IN (" . implode(',', $pPl) . "))";
            $params = array_merge($params, $pVals);
            $apvs[] = $paramId;
        }

        $filter2 = $filter;
        if ($pQuery) {
            if ($filter) {
                $filter .= ' AND ';
            }

            $filter .= '(' . implode(' AND ', $pQuery) . ')';
        }

        if ($aQuery) {
            if ($filter2) {
                $filter2 .= ' AND ';
            }

            $filter2 .= '(' . implode(' AND ', $aQuery) . ')';
        }

        return [$filter, $pvs, $addy, $params, $apvs, $cpvs, $filter2];
    }

    protected function resolveCategory()
    {
        Profiler::traceStart(__CLASS__, __FUNCTION__);
        $r = Container::getRequest();
        $path = $r->getPath();

        $this->resolveMode();

        // always globalize
        if ($this->isGlobal()) {
            return Container::getFactory()->create(FakeCategory::class);
        }

        // locate category
        $cat = Category::findAdv()->where(['path' => trim($path, '/')])->fetchOne();
        if ($cat) {
            Profiler::traceEnd(__CLASS__, __FUNCTION__);
            return $cat;
        }

        // attempt loading product
        $prod = Product::findAdv()->where(['path' => trim($path, '/'), 'is_active' => 1])->fetchOne();
        if ($prod) {
            $this->prod = $prod;

            if (isset($_REQUEST['v'])) {
                $this->resolveVariant();
            }

            // roll back cat path
            $path = explode('/', trim($path, '/'));
            unset($path[count($path) - 1]);

            while ($path && !($cat = Category::findAdv()->where(['path' => implode('/', $path)])->fetchOne())) {
                unset($path[count($path) - 1]);
            }
        } else {
            $prod = Addon::findAdv()->where(['path' => trim($path, '/'), 'is_active' => 1])->fetchOne();
            if ($prod) {
                $this->prod = $prod;

                if (isset($_REQUEST['v'])) {
                    $this->resolveVariant();
                }

                // roll back cat path
                $path = explode('/', trim($path, '/'));
                unset($path[count($path) - 1]);

                while ($path && !($cat = Category::findAdv()->where(['path' => implode('/', $path)])->fetchOne())) {
                    unset($path[count($path) - 1]);
                }
            }
        }

        Profiler::traceEnd(__CLASS__, __FUNCTION__);

        // root
        $cat ??= Container::getFactory()->create(FakeCategory::class);
        return $cat;
    }
}