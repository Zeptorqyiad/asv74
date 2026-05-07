<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('faq_category', function (Schema\Table $c) {
            $c->id('faq_category_id');
            $c->integer('npp');
            $c->string('name');
            $c->string('anchor');
        });

        $s->createTable('faq', function (Schema\Table $c) {
            $c->id('faq_id');
            $c->integer('npp');
            $c->integer('faq_category_id')->foreignKey('faq_category');
            $c->string('question');
            $c->text('answer');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('faq_category');
        $s->dropTable('faq');
    }
};