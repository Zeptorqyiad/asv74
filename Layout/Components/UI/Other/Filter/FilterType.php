<?php

namespace App\Layout\Components\UI\Other\Filter;

enum FilterType: string
{
    case Category = 'category';
    case Switch = 'switch';
    case Range = 'range';
    case FieldSelect = 'field-select';
    case TagList = 'tag-list';
}