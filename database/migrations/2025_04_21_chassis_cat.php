<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_c2c', function (Schema\Table $c) {
            $c->id('c2c_id');
            $c->integer('chassis_id');
            $c->integer('category_id');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_c2c');
    }
};