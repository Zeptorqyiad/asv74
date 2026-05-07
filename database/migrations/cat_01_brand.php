<?php
use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_brand', function (Schema\Table $c) {
            $c->id('brand_id');
            $c->string('name');
            $c->string('photo');
            $c->boolean('show_on_index');
            $c->integer('npp');
            $c->string('desc');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_brand');
    }
};