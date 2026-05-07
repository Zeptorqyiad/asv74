<?php
use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_category', function (Schema\Table $c) {
            $c->id('category_id');
            $c->boolean('is_active');
            $c->integer('pid');
            $c->integer('npp');
            $c->string('name');
            $c->string('name_2');
            $c->text('short');
            $c->string('alias');
            $c->string('path');
            $c->string('photo');
            $c->string('photo_large');
            $c->boolean('banner_enable');
            $c->boolean('is_sale');
            $c->text('seo');
            $c->text('seo2');
            $c->string('seo_title')->setDefault('');
            $c->string('seo_title2')->setDefault('');
            $c->string('meta_title')->setDefault('');
            $c->text('meta_desc');
            $c->text('meta_keywords');
            $c->string('subtitle')->setDefault('');
            $c->boolean('is_on_home');
            $c->text('banners');
            $c->string('icon');
        });

        $s->createTable('catalog_category_cache', function (Schema\Table $c) {
            $c->id('cache_id');
            $c->integer('category_id')->foreignKey('catalog_category');
            $c->text('filters');
            $c->text('params');
        });

        $s->createTable('catalog_category_count', function (Schema\Table $c) {
            $c->id('ccc_id');
            $c->integer('category_id')->foreignKey('catalog_category');
            $c->integer('count');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_category_count');
        $s->dropTable('catalog_category_cache');
        $s->dropTable('catalog_category');
    }
};