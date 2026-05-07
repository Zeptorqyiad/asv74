<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_a2c', function (Schema\Table $c) {
            $c->id('a2c_id');
            $c->integer('addon_id');
            $c->integer('category_id');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_a2c');
    }
};