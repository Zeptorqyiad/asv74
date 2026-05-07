<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('case_asv', function (Schema\Table $c) {
            $c->id('case_asv_id');
            $c->integer('npp');
            $c->boolean('is_active');
            $c->string('title');
            $c->date('date');
            $c->string('location');
            $c->text('images');
            $c->text('content');
            $c->string('alias');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('case_asv');
    }
};