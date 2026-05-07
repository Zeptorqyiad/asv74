<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('case_asv_c', function (Schema\Table $c) {
            $c->id('ac_id');
            $c->integer('case_asv_id')->foreignKey('case_asv');
            $c->integer('category_id')->foreignKey('catalog_category');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('case_asv_c');
    }
};