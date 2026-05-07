<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_addon_param_category', function (Schema\Table $c) {
            $c->id('addon_param_category_id');
            $c->string('name');
        });

        $s->createTable('catalog_addon_param', function (Schema\Table $c) {
            $c->id('addon_param_id');
            $c->string('name');
        });

        $s->createTable('catalog_addon_param_value', function (Schema\Table $c) {
            $c->id('addon_param_value_id');
            $c->integer('addon_param_id')->foreignKey('catalog_addon_param');
            $c->integer('addon_id')->foreignKey('catalog_addon');
            $c->string('value');
        });

    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_addon_param_value');
        $s->dropTable('catalog_addon_param');
        $s->dropTable('catalog_addon_param_category');
    }
};