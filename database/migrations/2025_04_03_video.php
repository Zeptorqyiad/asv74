<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_video', function (Schema\Table $c) {
            $c->id('video_id');
            $c->string('title');
            $c->string('video');
        });

        $s->createTable('catalog_video_cat', function (Schema\Table $c) {
            $c->id('video_cat_id');
            $c->integer('category_id')->foreignKey('catalog_category');
            $c->integer('video_id')->foreignKey('catalog_video');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_video_cat');
        $s->dropTable('catalog_video');
    }
};