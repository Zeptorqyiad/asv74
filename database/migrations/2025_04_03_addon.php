<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_addon', function (Schema\Table $c) {
            $c->id('addon_id');
            $c->string('name');
            $c->text('description');
            $c->string('sku');
            $c->string('image');
            $c->string('image_param');
            $c->string('description');
            $c->price('price');
            $c->price('price_old');
            $c->boolean('is_active');
            $c->boolean('is_new');
        });

        $s->table('catalog_product', function (Schema\Table $c) {
            $c->integer('addon_id');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->dropColumns('addon_id');
        });

        $s->dropTable('catalog_addon');
    }
};