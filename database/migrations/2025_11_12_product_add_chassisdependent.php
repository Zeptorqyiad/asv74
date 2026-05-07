<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->boolean('chassis_dependent');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->dropColumns('chassis_dependent');
        });
    }
};