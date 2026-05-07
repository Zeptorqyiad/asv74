<?php

namespace App\Extensions\Site\Component;

use App\Extensions\Catalog\Model\Product;
use App\Extensions\Catalog\ProductAssist;
use App\Extensions\Site\Model\Addon;
use App\Extensions\Site\Model\Addon\Param;
use App\Extensions\Site\Model\Addon\ParamValue;
use App\Extensions\Site\Model\Chassis;

class Compare extends \App\Extensions\Catalog\Component\Compare
{
    public array $chcp = [];
    public array $acp = [];

    protected function buildCompare()
    {
        parent::buildCompare();

        $this->buildCompareChassis();
        $this->buildCompareAddon();
    }

    protected static function getParamsForChassis()
    {
        $params = Chassis\Param::findAdv();
        $params = $params->all();

        $toAdd = [];
        /** @var Chassis\Param $p */
        foreach ($params as $p) {
            $toAdd[] = $p;
        }

        $out = [];
        foreach ($toAdd as $p) {
            $out[$p->chassis_param_category_id]['name'] = $p->getCategoryName();
            $out[$p->chassis_param_category_id]['data'][] = $p;
        }

        return $out;
    }

    protected static function getParamsForAddon()
    {
        $params = Param::findAdv();
        $params = $params->all();

        $toAdd = [];
        /** @var Param $p */
        foreach ($params as $p) {
            $toAdd[] = $p;
        }

        $out = [];
        foreach ($toAdd as $p) {
            $out[$p->addon_param_category_id]['name'] = $p->getCategoryName();
            $out[$p->addon_param_category_id]['data'][] = $p;
        }

        return $out;
    }

    protected function buildCompareChassis()
    {
        $params = [];
        $paramVals = [];

        // collect all params
        /** @var Product $p */
        foreach ($this->prodToCat[$this->cur] as $p) {
            if (!$p) {
                continue;
            }

            $chassis = Chassis::findOne(['chassis_id' => $p->chassis_id]);
            if (!$chassis) {
                continue;
            }

            $paramVals[$chassis->chassis_id] = Chassis\ParamValue::getList($chassis->chassis_id);

            foreach (static::getParamsForChassis() as $cat => $data) {
                if (!isset($params[$cat])) {
                    $params[$cat] = $data;
                    continue;
                }

                foreach ($data['data'] as $param) {
                    foreach ($params[$cat]['data'] as $param2) {
                        if ($param2->chassis_param_id == $param->chassis_param_id) {
                            continue 2;
                        }
                    }

                    $params[$cat]['data'][] = $param;
                }
            }
        }

        // build the table
        foreach ($params as $data) {
            $cat = [
                'name' => $data['name'],
                'items' => [],
            ];

            foreach ($data['data'] as $param) {
                $temp = [];
                $items = [];
                $any = false;
                foreach ($this->prodToCat[$this->cur] as $p) {
                    $val = ($paramVals[$p->chassis_id][$param->chassis_param_id] ?? '') ?: '-';
                    if ($val != '-') {
                        $any = true;
                    }
                    $temp[] = [$val, 0];
                }

                if (!$any) {
                    continue;
                }

                foreach ($temp as $d) {
                    $val = $d[0];
                    $items[] = $val;
                }

                $cat['items'][] = [
                    'name' => $param->name,
                    'values' => $items,
                ];
            }

            $this->chcp[] = $cat;
        }
    }

    protected function buildCompareAddon()
    {
        $params = [];
        $paramVals = [];

        // collect all params
        /** @var Product $p */
        foreach ($this->prodToCat[$this->cur] as $p) {
            if (!$p) {
                continue;
            }

            $chassis = Addon::findOne(['addon_id' => $p->addon_id]);
            if (!$chassis) {
                continue;
            }

            $paramVals[$chassis->addon_id] = ParamValue::getList($chassis->addon_id);

            foreach (static::getParamsForAddon() as $cat => $data) {
                if (!isset($params[$cat])) {
                    $params[$cat] = $data;
                    continue;
                }

                foreach ($data['data'] as $param) {
                    foreach ($params[$cat]['data'] as $param2) {
                        if ($param2->addon_param_id == $param->addon_param_id) {
                            continue 2;
                        }
                    }

                    $params[$cat]['data'][] = $param;
                }
            }
        }

        // build the table
        foreach ($params as $data) {
            $cat = [
                'name' => $data['name'],
                'items' => [],
            ];

            foreach ($data['data'] as $param) {
                $temp = [];
                $items = [];
                $any = false;
                foreach ($this->prodToCat[$this->cur] as $p) {
                    $val = ($paramVals[$p->addon_id][$param->addon_param_id] ?? '') ?: '-';
                    if ($val != '-') {
                        $any = true;
                    }
                    $temp[] = [$val, 0];
                }

                if (!$any) {
                    continue;
                }

                foreach ($temp as $d) {
                    $val = $d[0];
                    $items[] = $val;
                }

                $cat['items'][] = [
                    'name' => $param->name,
                    'values' => $items,
                ];
            }

            $this->chcp[] = $cat;
        }
    }
}