<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('icon', function (Schema\Table $c) {
            $c->id('icon_id');
            $c->string('icon');
            $c->string('viewbox');
            $c->longText('content');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('icon');
    }
};