<?php

namespace App\Extensions\GeoIp\Model;

use App\Extensions\GeoIp\GeoIp;
use Simflex\Core\DB\Where;
use Simflex\Extensions\Content\Model\ModelContent;

class Content extends ModelContent
{
    public static int $defaultCity = 0;

    public static function findOne(Where|array|string $where, bool $returnModelIfNotFound = false): ?static
    {
        $found = parent::findOne($where, $returnModelIfNotFound);
        if (!$found) {
            return $found;
        }

        // get the city
        $fallbackCity = GeoCity::findOne(['raw_city_id' => static::$defaultCity]);
        $myCity = GeoCity::findOne(['raw_city_id' => GeoIp::getSavedData()['id'] ?? static::$defaultCity]);
        if (!$myCity) {
            $myCity = $fallbackCity;
            if (!$myCity) {
                return $found;
            }
        }

        // try locating content override
        $override = GeoData::findOne(['city_id' => $myCity->city_id, 'content_id' => $found->content_id]);
        if (!$override) {
            $override = GeoData::findOne(['city_id' => $fallbackCity->city_id, 'content_id' => $found->content_id]);
            if (!$override) {
                return $found;
            }
        }

        // override data
        $found->title = $override->title;
        $found->params = $override->params;
        return $found;
    }
}