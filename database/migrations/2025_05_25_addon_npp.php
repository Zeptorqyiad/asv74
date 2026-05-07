<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->integer('npp');
            $c->string('alias');
            $c->string('path');
            $c->text('photo');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->dropColumns(['npp', 'alias', 'path', 'photo']);
        });
    }
};