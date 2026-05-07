<?php
namespace App\Extensions\GeoIp\Component;

use App\Extensions\GeoIp\Model\GeoCity;
use Simflex\Core\ComponentBase;
use Simflex\Core\Request;

class GeoIp extends ComponentBase
{
    public function __construct(private readonly Request $request)
    {
        parent::__construct();
    }

    protected function content()
    {
        $list = GeoCity::findAdv()->where('name like :n')->bind([
            'n' => '%' . $this->request->get('name') . '%'
        ])->limit('50')->asArray()->all();

        exit(json_encode($list, JSON_UNESCAPED_UNICODE));
    }
}