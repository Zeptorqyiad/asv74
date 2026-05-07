<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('user', function (Schema\Table $c) {
            $c->integer('npp')->setDefault(0);
        });
    }

    public function down(Schema $s)
    {
        $s->table('user', function (Schema\Table $c) {
            $c->dropColumns('npp');
        });
    }
};