<?php

namespace App\Extensions\Site\Model;

use Simflex\Core\ModelBase;

/**
 * @property int case_asv_id
 * @property int npp
 * @property boolean is_active
 * @property string title
 * @property string date
 * @property string location
 * @property string images
 * @property string content
 * @property string alias
 */
class CaseDetail extends ModelBase
{
    protected static $table = 'case_asv';
    protected static $primaryKeyName = 'case_asv_id';

    public function getImages(): array
    {
        $data = json_decode($this->images, true);
        return $data['v'] ?? [];
    }


    public function getFirstImage(): string
    {
        $images = $this->getImages();
        return $images[0]['image'] ?? '';
    }

    public function getContent(): array
    {
        return json_decode($this->content, true)['v'] ?? [];
    }
}