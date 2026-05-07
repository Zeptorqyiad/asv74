<?php
use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_analytics', function (Schema\Table $c) {
            $c->id('analytic_id');
        });

        $s->createTable('catalog_stock', function (Schema\Table $c) {
            $c->id('stock_id');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->boolean('is_active');
            $c->integer('available');
            $c->integer('in_orders');
            $c->integer('variant_id');
        });

        $s->createTable('catalog_transcomp', function (Schema\Table $c) {
            $c->id('transcomp_id');
            $c->integer('npp');
            $c->string('name');
            $c->string('delivery_time');
            $c->string('price');
            $c->string('template_name');
            $c->integer('pid');
        });

        $s->createTable('question', function (Schema\Table $c) {
            $c->id('question_id');
            $c->boolean('is_anonymous');
            $c->boolean('is_active');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->integer('user_id')->foreignKey('user');
            $c->string('name');
            $c->text('txt');
            $c->text('reply');
            $c->integer('likes');
            $c->integer('dislikes');
            $c->date('date');
            $c->boolean('is_read_by_user');
	});

        $s->createTable('refund', function (Schema\Table $c) {
            $c->id('refund_id');
            $c->integer('user_id')->foreignKey('user');
            $c->text('message');
            $c->dateTime('date');
            $c->enum('status', ['new', 'accepted', 'processed', 'finished', 'cancelled']);
            $c->integer('edited_by')->foreignKey('user', 'user_id');
            $c->dateTime('edited_on');
            $c->integer('order_id');
        });

        $s->createTable('review', function (Schema\Table $c) {
            $c->id('review_id');
            $c->dateTime('date');
            $c->boolean('is_active');
            $c->integer('rating');
            $c->integer('likes');
            $c->integer('dislikes');
            $c->integer('user_id');
            $c->string('name');
            $c->string('email');
            $c->text('pros');
            $c->text('cons');
            $c->text('comment');
            $c->text('reply');
            $c->integer('product_id');
        });

        $s->createTable('review_file', function (Schema\Table $c) {
            $c->id('rf_id');
            $c->integer('review_id');
            $c->string('path');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('review_file');
        $s->dropTable('review');
        $s->dropTable('refund');
        $s->dropTable('question');
        $s->dropTable('catalog_stock');
        $s->dropTable('catalog_transcomp');
        $s->dropTable('catalog_analytics');
    }
};
