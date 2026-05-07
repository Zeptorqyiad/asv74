<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_chassis', function (Schema\Table $c) {
            $c->id('chassis_id');
            $c->string('name');
            $c->text('description');
            $c->boolean('is_active');
        });

        $s->createTable('catalog_chassis_param_category', function (Schema\Table $c) {
            $c->id('chassis_param_category_id');
            $c->string('name');
        });

        $s->createTable('catalog_chassis_param', function (Schema\Table $c) {
            $c->id('chassis_param_id');
            $c->string('name');
        });

        $s->createTable('catalog_chassis_param_value', function (Schema\Table $c) {
            $c->id('chassis_param_value_id');
            $c->integer('chassis_param_id')->foreignKey('catalog_chassis_param');
            $c->integer('chassis_id')->foreignKey('catalog_chassis');
            $c->string('value');
        });

        $s->table('catalog_product', function (Schema\Table $c) {
            $c->integer('chassis_id');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->dropColumns('chassis_id');
        });

        $s->dropTable('catalog_chassis_param_value');
        $s->dropTable('catalog_chassis_param');
        $s->dropTable('catalog_chassis_param_category');
        $s->dropTable('catalog_chassis');
    }
};