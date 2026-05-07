<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_product_list', function (Schema\Table $c) {
            $c->id('list_id');
            $c->string('name');
            $c->integer('npp');
        });

        $s->createTable('catalog_product_list_c', function (Schema\Table $c) {
            $c->id('lc_id');
            $c->integer('list_id')->foreignKey('catalog_product_list');
            $c->integer('category_id')->foreignKey('catalog_category');
        });

        $s->createTable('catalog_product_list_p', function (Schema\Table $c) {
            $c->id('lp_id');
            $c->integer('list_id')->foreignKey('catalog_product_list');
            $c->integer('product_id')->foreignKey('catalog_product');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_product_list_p');
        $s->dropTable('catalog_product_list_c');
        $s->dropTable('catalog_product_list');
    }
};