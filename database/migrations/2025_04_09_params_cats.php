<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_addon_param', function (Schema\Table $c) {
            $c->integer('addon_param_category_id');
        });

        $s->table('catalog_chassis_param', function (Schema\Table $c) {
            $c->integer('chassis_param_category_id');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_addon_param', function (Schema\Table $c) {
            $c->dropColumns('addon_param_category_id');
        });

        $s->table('catalog_chassis_param', function (Schema\Table $c) {
            $c->dropColumns('chassis_param_category_id');
        });
    }
};