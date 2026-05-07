<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('otts_category', function (Schema\Table $c) {
            $c->id('otts_category_id');
            $c->integer('npp');
            $c->string('name');
            $c->string('anchor');
        });

        $s->createTable('otts', function (Schema\Table $c) {
            $c->id('otts_id');
            $c->integer('npp');
            $c->integer('otts_category_id')->foreignKey('otts_category');
            $c->string('image');
            $c->text('text');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('otts_category');
        $s->dropTable('otts');
    }
};