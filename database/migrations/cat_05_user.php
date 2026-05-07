<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->createTable('catalog_compare', function (Schema\Table $c) {
            $c->id('compare_id');
            $c->integer('user_id')->foreignKey('user');
            $c->string('sess_id');
        });

        $s->createTable('catalog_compare_product', function (Schema\Table $c) {
            $c->id('cp_id');
            $c->integer('compare_id')->foreignKey('catalog_compare');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->integer('variant_id');
        });

        $s->createTable('catalog_fav', function (Schema\Table $c) {
            $c->id('fav_id');
            $c->integer('user_id')->foreignKey('user');
            $c->string('sess_id');
        });

        $s->createTable('catalog_fav_product', function (Schema\Table $c) {
            $c->id('fav_product_id');
            $c->integer('fav_id')->foreignKey('catalog_fav');
            $c->integer('product_id')->foreignKey('catalog_product');
            $c->integer('variant_id');
        });

        $s->table('user', function (Schema\Table $c) {
            $c->string('city');
            $c->string('address');
            $c->string('phone');
            $c->string('last_name');
            $c->string('patronym');
            $c->boolean('org_active');
            $c->string('org_name');
            $c->string('org_inn');
            $c->boolean('other_active');
            $c->string('other_name');
            $c->string('other_last_name');
            $c->string('other_patronym');
            $c->string('other_phone');
            $c->integer('discount');
            $c->boolean('mail_verified');
            $c->integer('mail_code');
            $c->integer('transcomp_id');
            $c->price('spent');
            $c->string('other_email');
            $c->string('org_account');
            $c->string('org_bic');
        });
    }

    public function down(Schema $s)
    {
        $s->table('user', function (Schema\Table $c) {
            $c->dropColumns([
                'city',
                'address',
                'phone',
                'last_name',
                'patronym',
                'org_active',
                'org_name',
                'org_inn',
                'other_active',
                'other_name',
                'other_last_name',
                'other_patronym',
                'other_phone',
                'discount',
                'mail_verified',
                'mail_code',
                'transcomp_id',
                'spent',
                'other_email',
                'org_account',
                'org_bic'
            ]);
        });

        $s->dropTable('catalog_fav_product');
        $s->dropTable('catalog_fav');
        $s->dropTable('catalog_compare_product');
        $s->dropTable('catalog_compare');
    }
};