<?php

namespace App\Extensions\Site\Admin;

use App\Extensions\Catalog\CategoryAssist;
use App\Extensions\Site\Model\Addon\Param;
use App\Extensions\Site\Model\Addon\ParamValue;
use Simflex\Admin\Base;
use Simflex\Admin\Fields\Field;
use Simflex\Core\Helpers\Str;

class Addon extends Base
{
	public function save()
	{
		$ret = parent::save();
		if ($ret) {
			ParamValue::updateForProduct($ret);
			CategoryAssist::generateBrandCache();

			$addon = \App\Extensions\Site\Model\Addon::findOne(['addon_id' => $ret]);

			// Генерируем alias
			if (empty($addon->alias)) {
				$addon->alias = Str::translite($addon->name);
			}

			// Генерируем SKU
			if (!$_REQUEST['sku']) {
				if ($cat = $addon->getFirstCategory()) {
					$addon->sku = $cat->category_id . '-' . $ret;
				}
			}

			$addonAlias = $addon->alias;

			if ($cat = $addon->getFirstCategory()) {
				if (!empty($cat->path)) {
					$catPath = trim($cat->path, '/');
					$addon->path = $catPath . '/' . $addonAlias;
				} else {
					$catAlias = $cat->alias ?? Str::translite($cat->name);
					$addon->path = 'catalog/' . $catAlias . '/' . $addonAlias;
				}
			} else {
				$addon->path = 'catalog/' . $addonAlias;
			}

			$addon->save();
		}

		return $ret;
	}

    protected function initTable()
    {
        if (($_REQUEST['action'] ?? '') != 'form') {
            parent::initTable();
            return;
        }

        $toAdd = Param::findAdv()->all();

        // get params
        $prodVar = ParamValue::getList($_REQUEST['addon_id'] ?? 0);

        /** @var Param $i */
        foreach ($toAdd as $i) {
            $f = new Field([
                'name' => 'param_' . $i->addon_param_id,
                'label' => $i->name,
                'table' => $this->table
            ]);

            $f->isVirtual = true;
            $f->params = [
                'pos' => 'right',
                'pos_group' => $i->getCategoryName(),
                '__param' => $i->toArray(),
            ];

            $f->value = $prodVar[$i->addon_param_id] ?? '';
            $this->fields['param_' . $i->addon_param_id] = $f;
        }

        parent::initTable();
    }
}