<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_category_div', function (Schema\Table $c) {
            $c->id('div_id');
            $c->string('name');
            $c->string('icon');
        });

        $s->table('catalog_category', function (Schema\Table $c) {
            $c->integer('div_id')->foreignKey('catalog_category_div');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_category', function (Schema\Table $c) {
            $c->dropColumns('div_id');
        });

        $s->dropTable('catalog_category_div');
    }
};