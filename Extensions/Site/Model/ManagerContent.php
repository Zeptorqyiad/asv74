<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;
use Simflex\Core\Models\User;

class ManagerContent extends ModelBase
{
    protected static $table = 'manager_content';
    protected static $primaryKeyName = 'mc_id';

    public static function getForContent($contentId)
    {
        return static::findOne(['content_id' => $contentId]);
    }

    public function offsetGetUser()
    {
        return User::findOne(['user_id' => $this->user_id]);
    }
}