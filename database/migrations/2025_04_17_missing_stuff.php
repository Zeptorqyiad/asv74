<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_category', function (Schema\Table $c) {
            $c->integer('manager_id');
        });

        $s->table('catalog_product', function (Schema\Table $c) {
            $c->integer('manager_id');
            $c->text('visualizer');
            $c->string('video');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_category', function (Schema\Table $c) {
            $c->dropColumns('manager_id');
        });

        $s->table('catalog_product', function (Schema\Table $c) {
            $c->dropColumns(['manager_id', 'visualizer', 'video']);
        });
    }
};