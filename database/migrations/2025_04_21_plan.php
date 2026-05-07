<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->text('plan');
            $c->string('plan_photo');
            $c->string('plan_desc');
        });

        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->text('plan');
            $c->string('plan_photo');
            $c->string('plan_desc');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->dropColumns(['plan', 'plan_photo', 'plan_desc']);
        });

        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->dropColumns(['plan', 'plan_photo', 'plan_desc']);
        });
    }
};