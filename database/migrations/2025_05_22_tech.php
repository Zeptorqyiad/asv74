<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_tech', function (Schema\Table $c) {
            $c->id('tech_id');
            $c->string('name');
            $c->string('photo');
        });

        $s->createTable('catalog_tech_category', function (Schema\Table $c) {
            $c->id('tech_category_id');
            $c->integer('tech_id');
            $c->integer('category_id');
        });

        $s->createTable('catalog_tech_product', function (Schema\Table $c) {
            $c->id('tech_product_id');
            $c->integer('tech_id');
            $c->integer('product_id');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_tech_product');
        $s->dropTable('catalog_tech_category');
        $s->dropTable('catalog_tech');
    }
};