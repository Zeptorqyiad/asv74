<?php
use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_cart', function (Schema\Table $c) {
            $c->id('cart_id');
            $c->integer('user_id')->foreignKey('user');
            $c->string('sess_id');
            $c->price('sum_total');
            $c->price('sum_actual');
            $c->integer('level');

            // todo: lastupdate -> purge dead ones
        });

        $s->createTable('catalog_cart_product', function (Schema\Table $c) {
            $c->id('cart_product_id');
            $c->integer('cart_id')->foreignKey('catalog_cart');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->price('sum_total');
            $c->price('sum_actual');
            $c->integer('qty');
            $c->integer('variant_id');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_cart_product');
        $s->dropTable('catalog_cart');
    }
};