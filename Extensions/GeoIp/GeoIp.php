<?php

namespace App\Extensions\GeoIp;

use Simflex\Core\Container;
use Simflex\Core\DB;
use Simflex\Core\Log;
use Transliterator;

class GeoIp
{
    /**
     * Get saved geoIP data
     * @return array|null
     */
    public static function getSavedData(): ?array
    {
        return json_decode($_COOKIE['geo'], true) ?? null;
    }

    /**
     * Save geoIP data
     * @param array $data
     * @return void
     */
    public static function saveData(array $data): void
    {
        $_COOKIE['geo'] = json_encode($data, JSON_UNESCAPED_UNICODE);
        setcookie('geo', $_COOKIE['geo'], time() + 86400 * 30, '/');
    }

    /**
     * Perform city detection from IP
     * @return array|null
     */
    public static function detectCity()
    {
        $ip = explode('.', $_SERVER['HTTP_X_REAL_IP'] ?? $_SERVER['REMOTE_ADDR']);
        $bin = (int)$ip[0] << 24 | (int)$ip[1] << 16 | (int)$ip[2] << 8 | (int)$ip[3];

        $r = DB::query(
            '
            SELECT gci.name cyrillic, gci.id
            FROM `geo_ip` i
            LEFT JOIN geo_city gci ON i.city_id = gci.id
            WHERE ? BETWEEN i.bin_start AND i.bin_stop
            LIMIT 1
        ',
            [$bin]
        );

        return DB::fetch($r);
    }

    public static function getCurrentCity(bool $force = false): ?string
    {
        if (($city = self::getCityFromUser()) && !$force) {
            return $city;
        }

        if (($city = self::getCityFromCookie()) && !$force) {
            return $city;
        }

        $r = self::detectCity();
        if (!$r || !isset($r['cyrillic'])) {
            $r = ['cyrillic' => 'Москва'];
        }

        if (!$force) {
            $r['latin'] = self::toLatin($r['cyrillic']);
            self::checkDomain($r['cyrillic']);
            self::saveData($r);
        }

        return $r['cyrillic'];
    }

    protected static function getCityFromUser(): ?string
    {
        $u = Container::getUser();
        if (!$u) {
            return null;
        }

        if ($u->city) {
            self::overrideCityInCookies(['cyrillic' => $u->city, 'latin' => '', 'id' => $u->city_id]);
        }

        return $u->city;
    }

    protected static function getCityFromCookie(): ?string
    {
        $data = self::getSavedData();
        if (!$data) {
            return null;
        }

        self::overrideCityInCookies($data);
        self::checkDomain($data['latin']);

        return $data['cyrillic'];
    }

    protected static function checkDomain(string $domain)
    {
        // don't do anything if disabled in config
        if (!env('GEO_REDIRECT', 1)) {
            return;
        }

        // check if we are already on this domain, and new one was specified
        $host = $_SERVER['HTTP_HOST'];
        if (strpos($host, $domain) === 0 && $domain) {
            return;
        }

        // don't do anything if we are on sld (prob due to moscow)
        if ($domain == '' && count(explode('.', $host)) == 2) {
            return;
        }

//         perform redirection
        self::redirect($host, $domain);
    }

    protected static function redirect(string $domain, string $latin)
    {
        $split = explode('.', $domain);
        $last = count($split) - 1;

        $tld = $split[$last];
        $sld = $split[$last - 1];

#        header(
#            'Location: http://' . implode(
#                '.',
#                $latin ? [$latin, $sld, $tld] : [$sld, $tld]
#            ) . $_SERVER['REQUEST_URI']
#        );
    }

    protected static function toLatin(string $cyrillic): string
    {
        $r = preg_replace(
            '/[^a-z-]/i',
            '',
            str_replace(
                '\'',
                '',
                Transliterator::create('Any-Latin; Latin-ASCII; Lower()')->transliterate($cyrillic)
            )
        );

        if ($r == 'moskva') {
            $r = '';
        }

        return $r;
    }

    protected static function overrideCityInCookies(array $data = [])
    {
        // check if we have correct array
        if (!isset($data['cyrillic']) || !isset($data['latin'])) {
            return;
        }

        // check if we want to change the city
        if (!($city = $_REQUEST['_geo'] ?? '')) {
            return;
        }

        if ($u = Container::getUser()) {
            DB::query('update user set city = ? where user_id = ?', [$city, $u->user_id]);
            $u->reload();
        }

        // switch over, replace data so the function won't trigger again plus we get new data already
        $data['id'] = DB::result('select id from geo_city where name like ?', 0, [$city]);
        $data['cyrillic'] = $city;
        $data['latin'] = self::toLatin($city);
        self::saveData($data);

        unset($_GET['_geo']);
#        header('Location: ' . explode('?', $_SERVER['REQUEST_URI'])[0] . '?' . http_build_query($_GET));
#        exit;
    }
}
