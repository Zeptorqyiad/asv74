<?php
return new class implements \Simflex\Core\DB\Seeder {
    public function seed(): void
    {
        $table = \Simflex\Core\Models\StructTable::byName('user');
        $fieldImg = \Simflex\Core\Models\StructField::byClass(\Simflex\Admin\Fields\FieldImage::class);
        $fieldString = \Simflex\Core\Models\StructField::byClass(\Simflex\Admin\Fields\FieldString::class);

        \Simflex\Core\Models\StructData::bulkInsert([
            [
                'npp' => 10,
                'table_id' => $table->table_id,
                'field_id' => $fieldImg->field_id,
                'name' => 'avatar',
                'label' => 'Аватар',
                'help' => '',
                'placeholder' => '',
                'params' => serialize(['main' => ['pos' => 'right', 'group' => 'Данные']]),
            ],
            [
                'npp' => 11,
                'table_id' => $table->table_id,
                'field_id' => $fieldString->field_id,
                'name' => 'job',
                'label' => 'Должность',
                'help' => '',
                'placeholder' => '',
                'params' => serialize(['main' => ['pos' => 'right', 'group' => 'Данные']]),
            ],
        ]);
    }
};