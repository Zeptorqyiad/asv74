<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('services_p2c_product', function (Schema\Table $c) {
            $c->id('serv_p2c_id');
            $c->integer('services_id')->foreignKey('services');
            $c->integer('product_id')->foreignKey('catalog_product');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('services_p2c_product');
    }
};