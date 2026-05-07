<?php
use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_order', function (Schema\Table $c) {
            $c->id('order_id');
            $c->integer('user_id')->foreignKey('user');
            $c->dateTime('date');
            $c->enum('status', ['new', 'pay', 'accepted', 'sent', 'delivered', 'finished', 'canceled']);
            $c->string('name');
            $c->string('last_name');
            $c->string('city');
            $c->string('address');
            $c->string('phone');
            $c->string('email');
            $c->string('tracking');
            $c->price('sum_total');
            $c->price('sum_actual');
            $c->integer('qty');
            $c->integer('status_num');
            $c->integer('discount');
            $c->string('invoice');
            $c->integer('edited_on');
            $c->integer('transcomp_id');
            $c->integer('payment_id');
            $c->price('delivery_sum');
            $c->text('documents');
            $c->string('delivery_dates');
	});

        $s->createTable('catalog_order_product', function (Schema\Table $c) {
            $c->id('order_product_id');
            $c->integer('order_id')->foreignKey('catalog_order');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->integer('qty');
            $c->price('sum');
            $c->boolean('is_deleted');
            $c->boolean('is_changed');
            $c->boolean('is_added');
            $c->integer('stock');
            $c->price('price');
            $c->price('price_old');
            $c->integer('variant_id');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_order_product');
        $s->dropTable('catalog_order');
    }
};
