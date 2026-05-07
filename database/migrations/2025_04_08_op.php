<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_option_product', function (Schema\Table $c) {
            $c->id('oa_id');
            $c->integer('option_id')->foreignKey('catalog_option');
            $c->integer('product_id')->foreignKey('catalog_product');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_option_product');
    }
};