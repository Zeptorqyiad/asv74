<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('blog', function (Schema\Table $c) {
            $c->string('meta_title');
        });
    }

    public function down(Schema $s)
    {
        $s->table('blog', function (Schema\Table $c) {
            $c->dropColumns(['meta_title']);
        });
    }
};