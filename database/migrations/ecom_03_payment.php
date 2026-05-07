<?php
use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_payment', function (Schema\Table $c) {
            $c->id('payment_id');
            $c->integer('npp');
            $c->string('name');
            $c->string('class');
            $c->text('desc');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('catalog_payment');
    }
};