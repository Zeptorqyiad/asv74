<?php
use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_sale', function (Schema\Table $c) {
            $c->id('sale_id');
            $c->string('name');
            $c->dateTime('start');
            $c->dateTime('end');
            $c->integer('discount');
            $c->boolean('is_running')->setDefault(0);
            $c->boolean('is_active')->setDefault(0);
        });

        $s->createTable('catalog_sale_banner', function (Schema\Table $c) {
            $c->id('banner_id');
            $c->integer('npp');
            $c->enum('type', ['header', 'offer']);
            $c->string('title');
            $c->string('link');
            $c->string('photo');
            $c->boolean('is_active');
        });

        $s->createTable('catalog_sale_category', function (Schema\Table $c) {
            $c->id('sale_category_id');
            $c->integer('sale_id')->foreignKey('catalog_sale');
            $c->integer('category_id')->foreignKey('catalog_category');
        });

        $s->createTable('catalog_sale_product', function (Schema\Table $c) {
            $c->id('sale_product_id');
            $c->integer('sale_id')->foreignKey('catalog_sale');
            $c->integer('product_id')->foreignKey('catalog_product');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_sale_product');
        $s->dropTable('catalog_sale_category');
        $s->dropTable('catalog_sale_banner');
        $s->dropTable('catalog_sale');
    }
};