<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->boolean('is_popular');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_addon', function (Schema\Table $c) {
            $c->boolean('is_popular');
        });
    }
};