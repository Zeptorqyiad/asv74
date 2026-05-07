<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->string('side_video');
            $c->string('chassis_image');
            $c->string('param_image');
            $c->text('otts');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->dropColumns(['side_video', 'chassis_image', 'param_image', 'otts']);
        });
    }
};