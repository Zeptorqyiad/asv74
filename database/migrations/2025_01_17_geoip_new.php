<?php

use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('g_data', function (Schema\Table $c) {
            $c->id('data_id');
            $c->integer('city_id');
            $c->integer('content_id');
            $c->integer('npp');
            $c->string('title');
            $c->longText('params');
        });

        $s->createTable('g_city', function (Schema\Table $c) {
            $c->id('city_id');
            $c->integer('raw_city_id');
            $c->string('name_ime');
            $c->string('name_rod');
            $c->string('name_vin');
            $c->string('name_dat');
            $c->string('name_tvo');
            $c->string('name_pre');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('g_city');
        $s->dropTable('g_data');
    }
};