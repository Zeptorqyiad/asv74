<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('services', function (Schema\Table $c) {
            $c->id('services_id');
            $c->integer('npp');
            $c->boolean('is_on_home');
            $c->boolean('is_active');
            $c->string('alias');
            $c->string('title');
            $c->string('fs_photo');
            $c->text('fs_description');
            $c->text('fs_badges');
            $c->text('fs_list');
            $c->string('fs_btn_link');
            $c->string('promo_title');
            $c->text('promo_cards');
            $c->text('gallery_images');
            $c->string('about_title');
            $c->string('about_image');
            $c->text('about_steps');
            $c->string('process_title');
            $c->text('process_steps');
            $c->string('cta_title');
            $c->text('cta_text');
            $c->string('cta_image');
            $c->string('examples_title');
            $c->text('examples_slides');
            $c->string('slider_title');
            $c->string('meta_title');
            $c->text('meta_desc');
            $c->text('meta_kw');
        });
    }

    public function down(Schema $s)
    {
        $s->dropTable('services');
    }
};