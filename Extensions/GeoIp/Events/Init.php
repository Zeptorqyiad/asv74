<?php

namespace App\Extensions\GeoIp\Events;

use App\Extensions\GeoIp\GeoIp;
use App\Extensions\GeoIp\Model\Content;
use App\Extensions\GeoIp\Model\GeoCity;
use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Events\CustomParams;
use Simflex\Core\Events\Event;
use Simflex\Core\Events\EventListener;
use Simflex\Core\Events\GroupEvents;
use Simflex\Core\Factory;
use Simflex\Core\Log;
use Simflex\Extensions\Content\Model\ModelContent;

class Init implements EventListener
{
    use GroupEvents;

    public function onPreInit(Event $ev, Factory $factory)
    {
        if (SF_LOCATION != SF_LOCATION_SITE) {
            return;
        }

        Content::$defaultCity = DB::result('select raw_city_id from g_city where is_default = 1', 0) ?? 0;

        $factory->override(ModelContent::class, Content::class);
    }

    public function onPostPrepareOutput(Event $ev, CustomParams $cParams)
    {
        if (SF_LOCATION != SF_LOCATION_SITE) {
            return;
        }

        $data = $cParams->params[0];

        // also will update it
        $savedName = GeoIp::getCurrentCity();

        $myCity = GeoCity::findOne(['raw_city_id' => GeoIp::getSavedData()['id'] ?? Content::$defaultCity]);
        if (!$myCity) {
            $myCity = GeoCity::findOne(['raw_city_id' => Content::$defaultCity]);
            if (!$myCity) {
                $city = $savedName;
                $myCity = (object)[
                    'name' => $city,
                    'name_ime' => $city,
                    'name_rod' => $city,
                    'name_dat' => $city,
                    'name_vin' => $city,
                    'name_tvo' => $city,
                    'name_pre' => $city,
                ];
            }
        }

        if ($myCity instanceof GeoCity) {
            $myCity->name = DB::result('select name from geo_city where id = ?', 0, [$myCity->raw_city_id]) ?? $savedName;
        }

        $params = [
            'geo_city' => $myCity->name,
            'geo_city_ime' => $myCity->name_ime ?: $myCity->name,
            'geo_city_rod' => $myCity->name_rod ?: $myCity->name,
            'geo_city_dat' => $myCity->name_dat ?: $myCity->name,
            'geo_city_vin' => $myCity->name_vin ?: $myCity->name,
            'geo_city_tvo' => $myCity->name_tvo ?: $myCity->name,
            'geo_city_pre' => $myCity->name_pre ?: $myCity->name,
        ];

        $data = str_replace(array_map(fn(string $key) => '{' . $key . '}', array_keys($params)),
            array_values($params),
            $data);
        Log::debug('fix {a}', ['a' => md5($data)]);
        $cParams->params[0] = $data;
    }
}