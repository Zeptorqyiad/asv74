<?php
use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_param_category', function (Schema\Table $c) {
            $c->id('pc_id');
            $c->string('name');
            $c->integer('npp');
            $c->boolean('in_filter');
        });

        $s->createTable('catalog_param', function (Schema\Table $c) {
            $c->id('param_id');
            $c->integer('pc_id')->foreignKey('catalog_param_category');
            $c->string('name');
            $c->integer('npp');
            $c->boolean('show_on_product');
            $c->boolean('is_numeric');
            $c->boolean('in_filter');
            $c->boolean('is_in_line');
            $c->boolean('show_in_var');
            $c->boolean('is_bool');
            $c->string('desc');
        });

        $s->createTable('catalog_param_value', function (Schema\Table $c) {
            $c->id('value_id');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->integer('param_id')->foreignKey('catalog_param');
            $c->integer('variant_id');
            $c->text('value');
        });

        $s->createTable('catalog_param_p2c', function (Schema\Table $c) {
            $c->id('p2p_id'); // todo: lol fix
            $c->integer('param_id')->foreignKey('catalog_param');
            $c->integer('category_id')->foreignKey('catalog_category');
        });

        $s->createTable('catalog_param_c2c', function (Schema\Table $c) {
            $c->id('c2c_id');
            $c->integer('category_id')->foreignKey('catalog_category');
            $c->integer('pc_id')->foreignKey('catalog_param_category');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_param_c2c');
        $s->dropTable('catalog_param_p2c');
        $s->dropTable('catalog_param_value');
        $s->dropTable('catalog_param');
        $s->dropTable('catalog_param_category');
    }
};