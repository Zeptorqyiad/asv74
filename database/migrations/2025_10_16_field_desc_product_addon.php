<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->string('card_desc');
        });

        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->string('card_desc');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_product', function (Schema\Table $c) {
            $c->dropColumns('card_desc');
        });

        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->dropColumns('card_desc');
        });
    }
};