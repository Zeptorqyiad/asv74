<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('manager_content', function (Schema\Table $c) {
            $c->id('mc_id');
            $c->integer('content_id');
            $c->integer('user_id');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('manager_content');
    }
};