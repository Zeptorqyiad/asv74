<?php
return new class implements \Simflex\Core\DB\Seeder {
    public function seed(): void
    {
        \Simflex\Core\Models\StructField::insertStatic([
            'name' => 'Иконка',
            'class' => \App\Extensions\Icons\Admin\Fields\FieldIcon::class,
        ]);

        $dev = \Simflex\Core\Models\UserPriv::byName('dev');
        $table = \Simflex\Core\Models\StructTable::insertStatic([
            'name' => 'icon',
            'order_by' => '',
            'order_desc' => 0,
            'priv_add' => $dev->priv_id,
            'priv_edit' => $dev->priv_id,
            'priv_delete' => $dev->priv_id,
        ]);

        $int = \Simflex\Core\Models\StructField::byClass(\Simflex\Admin\Fields\FieldInt::class);
        $string = \Simflex\Core\Models\StructField::byClass(\Simflex\Admin\Fields\FieldString::class);
        $text = \Simflex\Core\Models\StructField::byClass(\Simflex\Admin\Fields\FieldText::class);

        \Simflex\Core\Models\StructData::bulkInsert([
            [
                'npp' => 1,
                'table_id' => $table->table_id,
                'field_id' => $int->field_id,
                'name' => 'icon_id',
                'label' => 'ID',
                'params' => serialize(['main' => [
                    'e2n' => 1,
                    'hidden' => 1,
                    'pk' => 1,
                    'width' => 120,
                    'filter' => 1,
                ]])
            ],
            [
                'npp' => 2,
                'table_id' => $table->table_id,
                'field_id' => $string->field_id,
                'name' => 'icon',
                'label' => 'ID иконки',
                'params' => serialize(['main' => [
                    'width' => 1,
                    'filter' => 1,
                ]])
            ],
            [
                'npp' => 3,
                'table_id' => $table->table_id,
                'field_id' => $string->field_id,
                'name' => 'viewbox',
                'label' => 'View box',
                'help' => 'Задается в нескольких форматах. "X" = "0 0 X X", "X Y" = "0 0 X Y", "X Y Z W" = "X Y Z W"',
                'params' => serialize(['main' => [
                    'width' => 0,
                ]])
            ],
            [
                'npp' => 4,
                'table_id' => $table->table_id,
                'field_id' => $text->field_id,
                'name' => 'content',
                'label' => 'SVG',
                'params' => serialize(['main' => [
                    'width' => 0,
                ]])
            ]
        ]);

        $parent = \Simflex\Core\Models\AdminMenu::byLink('/admin/admin/');
        \Simflex\Core\Models\AdminMenu::insertStatic([
            'menu_pid' => $parent->menu_id,
            'priv_id' => $dev->priv_id,
            'npp' => 9000,
            'name' => 'Иконки',
            'link' => '/admin/admin/icon/',
            'model' => 'icon',
            'icon' => '',
            'hidden' => 0,
        ]);
    }
};