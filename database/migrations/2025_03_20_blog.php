<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('blog_category', function (Schema\Table $c) {
            $c->id('bc_id');
            $c->integer('npp');
            $c->string('name');
            $c->string('type');
        });

        $s->createTable('blog', function (Schema\Table $c) {
            $c->id('blog_id');
            $c->integer('npp');
            $c->boolean('is_active');
            $c->string('name');
            $c->string('short');
            $c->date('date');
            $c->string('photo');
            $c->string('alias');
            $c->text('content');
            $c->integer('bc_id')->foreignKey('blog_category');
            $c->string('photo_big');
            $c->integer('likes');
            $c->integer('dislikes');
            $c->string('photo_mob');
            $c->integer('views')->setDefault(0);
            $c->boolean('pinned');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('blog');
        $s->dropTable('blog_category');
    }
};