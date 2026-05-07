<?php

use Simflex\Admin\Migration\Struct;
use \Simflex\Core\DB\Schema;

return new class implements \Simflex\Core\DB\Migration {
    public function up(Schema $s)
    {
        $s->table('fs_banner', function (Schema\Table $c) {
            $c->string('image_mob');
        });
    }

    public function down(Schema $s)
    {
        $s->table('fs_banner', function (Schema\Table $c) {
            $c->dropColumns('image_mob');
        });
    }
};