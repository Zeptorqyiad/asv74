<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('review_asv_category', function (Schema\Table $c) {
            $c->id('review_asv_category_id');
            $c->integer('npp');
            $c->string('name');
            $c->string('type');
        });

        $s->createTable('review_asv', function (Schema\Table $c) {
            $c->id('review_asv_id');
            $c->integer('npp');
            $c->boolean('is_active')->setDefault(1);
            $c->integer('review_asv_category_id')->foreignKey('review_asv_category');
            $c->string('title');
            $c->text('file');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('review_asv_category');
        $s->dropTable('review_asv');
    }
};