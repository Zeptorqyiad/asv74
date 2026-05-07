<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('catalog_brand', function (Schema\Table $c) {
            $c->boolean('is_official');
        });
    }

    public function down(Schema $s)
    {
        $s->table('catalog_brand', function (Schema\Table $c) {
            $c->dropColumns('is_official');
        });
    }
};