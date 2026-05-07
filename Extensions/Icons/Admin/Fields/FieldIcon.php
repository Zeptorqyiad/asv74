<?php
namespace App\Extensions\Icons\Admin\Fields;

use Simflex\Admin\Fields\Field;
use Simflex\Core\DB;

class FieldIcon extends Field
{
    public function input($value)
    {
        $items = DB::assoc("select icon from icon");

        $select = '<div class="form-control form-control--sm">
                    <div class="form-control__dropdown ' . ($this->readonly ? ' disabled' : '') . '" data-action="searchInt" data-ajax="true">
                        <div class="form-control__dropdown-top">
                            <input class="form-control__dropdown-input" onchange="' . $this->onchange . '" value="' . (!$value ? '' : $value) . '" type="hidden" name="' . $this->name . '"' . ($this->readonly ? ' readonly' : '') . ' >
                           <input placeholder="Начните вводить название..." class="form-control__dropdown-text" type="text" ' . ($this->readonly ? ' readonly' : '') . '>
                            <div class="form-control__dropdown-current">' . $value . '</div>
                            <button type="button" class="form-control__dropdown-toggle"' . ($this->readonly ? ' readonly' : '') . '>
                                <svg viewBox="0 0 24 24">
                                    <use xlink:href="' . asset('img/icons/svg-defs.svg') . '#chevron-mini"></use>
                                </svg>
                            </button>
                        </div>
                        <div class="form-control__dropdown-list">
                                       
                                    ';

        $tempSel = '';

        $hasId = false;
        foreach ($items as $r) {
            if ($r['icon'] == $value) {
                $hasId = true;
            }

            $tempSel .= '<div data-value="' . $r['icon'] . '" class="form-control__dropdown-item">' . $r['icon'] . '</div>';
        }

        if (!$hasId) {
            $select .= '<div data-value="' . $value. '" class="form-control__dropdown-item">' . $value . '</div>';
        }

        $select .= $tempSel;

//            foreach ($list as $id=>$row) {
//                $select .= '<div data-value="'.$id.'" class="form-control__dropdown-item">'. str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;', $row['tree_level']) . $row['label'] .'</div>';
//            }

        $select .= '</div>
                                </div>
                            </div>';

        return $select;
    }

    public function getPOST($simple = false, $group = null)
    {
        return $this->e2n && $_POST[$this->name] === '' ? NULL : $_POST[$this->name];
    }
}