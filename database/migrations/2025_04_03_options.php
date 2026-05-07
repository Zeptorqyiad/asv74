<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_option', function (Schema\Table $c) {
            $c->id('option_id');
            $c->string('name');
            $c->string('photo');
        });

        $s->createTable('catalog_option_addon', function (Schema\Table $c) {
            $c->id('oa_id');
            $c->integer('option_id')->foreignKey('catalog_option');
            $c->integer('addon_id')->foreignKey('catalog_addon');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_option_addon');
        $s->dropTable('catalog_option');
    }
};