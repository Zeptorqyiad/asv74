<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('case_asv', function (Schema\Table $c) {
            $c->string('link');
        });
    }

    public function down(Schema $s)
    {
        $s->table('case_asv', function (Schema\Table $c) {
            $c->dropColumns('link');
        });
    }
};