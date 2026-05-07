<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_category', function (Schema\Table $c) {
            $c->enum('type', ['product', 'chassis', 'addon'])->setDefault('product');
        });

        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->text('description');
            $c->integer('manager_id');
        });

        $s->table('catalog_addon_param', function (Schema\Table $c) {
            $c->boolean('in_filters');
        });

        $s->table('catalog_chassis_param', function (Schema\Table $c) {
            $c->boolean('in_filters');
        });

        $s->createTable('catalog_option_category', function (Schema\Table $c) {
            $c->id('oc_id');
            $c->integer('category_id');
            $c->integer('option_id');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_category', function (Schema\Table $c) {
            $c->dropColumns(['type']);
        });

        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->string('description');
            $c->dropColumns(['manager_id']);
        });

        $s->table('catalog_addon_param', function (Schema\Table $c) {
            $c->dropColumns('in_filters');
        });

        $s->table('catalog_chassis_param', function (Schema\Table $c) {
            $c->dropColumns('in_filters');
        });

        $s->dropTable('catalog_option_category');
    }
};