<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('manager_sec', function (Schema\Table $c) {
            $c->id('sec_id');
            $c->boolean('is_active');
            $c->integer('npp');
            $c->string('title');
        });

        $s->createTable('manager_sec_user', function (Schema\Table $c) {
            $c->id('sec_user_id');
            $c->integer('user_id');
            $c->integer('sec_id');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('manager_sec_user');
        $s->dropTable('manager_sec');
    }
};