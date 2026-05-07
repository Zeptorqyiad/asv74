<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('new_models_banner', function (Schema\Table $c) {
            $c->id('model_banner_id');
            $c->integer('npp');
            $c->boolean('is_active');
            $c->string('title');
            $c->text('desc');
            $c->string('link');
            $c->string('background');
            $c->string('image');
            $c->boolean('to_order');
            $c->boolean('is_new');
            $c->boolean('in_stock');
            $c->boolean('is_sale');
            $c->text('badges');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('new_models_banner');
    }
};