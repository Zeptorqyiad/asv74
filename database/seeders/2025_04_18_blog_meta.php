<?php
return new class implements \Simflex\Core\DB\Seeder {
    public function seed(): void
    {
        $table = \Simflex\Core\Models\StructTable::byName('blog');
        $text = \Simflex\Core\Models\StructField::byClass(\Simflex\Admin\Fields\FieldText::class);

        \Simflex\Core\Models\StructData::bulkInsert([
            [
                'npp' => 1,
                'table_id' => $table->table_id,
                'field_id' => $text->field_id,
                'name' => 'meta_desc',
                'label' => 'Описание',
                'params' => serialize(['main' => [
                    'pos' => 'right',
                    'pos_group' => 'Мета',
                ]])
            ],
            [
                'npp' => 2,
                'table_id' => $table->table_id,
                'field_id' => $text->field_id,
                'name' => 'meta_kw',
                'label' => 'Ключевые слова',
                'params' => serialize(['main' => [
                    'pos' => 'right',
                    'pos_group' => 'Мета',
                ]])
            ]
        ]);
    }
};