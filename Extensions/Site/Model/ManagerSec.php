<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;
use Simflex\Core\Models\User;

class ManagerSec extends ModelBase
{
    protected static $table = 'manager_sec';
    protected static $primaryKeyName = 'sec_id';

    public function getManagers()
    {
        return User::findAdv()
            ->leftJoin('manager_sec_user', 'user_id')
            ->where(['sec_id' => $this->getId()])
            ->orderBy('npp')
            ->all();
    }
}