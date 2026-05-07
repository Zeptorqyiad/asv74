<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('fs_banner', function (Schema\Table $c) {
            $c->id('banner_id');
            $c->integer('npp');
            $c->boolean('is_active');
            $c->string('title');
            $c->text('desc');
            $c->string('image');
            $c->text('video');
            $c->string('link');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('fs_banner');
    }
};