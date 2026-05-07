<?php
use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_product', function (Schema\Table $c) {
            $c->id('product_id');
            $c->boolean('is_active');
            $c->integer('npp');
            $c->string('alias');
            $c->string('path');
            $c->string('name');
            $c->text('desc');
            $c->text('photo');
            $c->string('meta_title');
            $c->text('meta_desc');
            $c->text('meta_keywords');
            $c->boolean('is_new');
            $c->integer('new_timeout');
            $c->boolean('is_popular');
            $c->text('seo');
            $c->string('sku');
            $c->price('price');
            $c->price('price-base');
            $c->integer('stock');
            $c->text('seo2');
            $c->string('seo_title');
            $c->string('seo_title2');
            $c->text('about');
            $c->text('tags_prim');
            $c->text('tags_sec');
            $c->string('button_text');
            $c->text('docs');
            $c->boolean('is_of_the_day');
            $c->integer('brand_id');
            $c->string('weight');
            $c->string('size');
            $c->string('guarantee');
            $c->integer('bulk_amount');
            $c->string('bulk_help');
        });

        $s->createTable('catalog_product_variant', function (Schema\Table $c) {
            $c->id('variant_id');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->price('price');
            $c->price('price_base');
        });

        $s->createTable('catalog_product_name_cache', function (Schema\Table $c) {
            $c->id('cache_id');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->integer('variant_id')->foreignKey('catalog_product_variant');
            $c->string('name');
        });

        $s->createTable('catalog_p2c', function (Schema\Table $c) {
            $c->id('p2c_id');
            $c->integer('category_id');
            $c->integer('product_id');
        });

        $s->createTable('catalog_p2p', function (Schema\Table $c) {
            $c->id('p2p_id');
            $c->integer('left_id');
            $c->integer('right_id');
        });

        $s->createTable('catalog_p2p_add', function (Schema\Table $c) {
            $c->id('p2p_id');
            $c->integer('product_id');
            $c->integer('link_id');
        });

        $s->createTable('catalog_p2p_cache', function (Schema\Table $c) {
            $c->id('cache_id');
            $c->integer('source_id')->foreignKey('catalog_product', 'product_id');
            $c->integer('product_id')->foreignKey('catalog_product');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_p2p_cache');
        $s->dropTable('catalog_p2p_add');
        $s->dropTable('catalog_p2p');
        $s->dropTable('catalog_p2c');
        $s->dropTable('catalog_product_name_cache');
        $s->dropTable('catalog_product_variant');
        $s->dropTable('catalog_product');
    }
};