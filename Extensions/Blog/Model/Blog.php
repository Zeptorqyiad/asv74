<?php

namespace App\Extensions\Blog\Model;

use Simflex\Core\ModelBase;

/**
 * @property int blog_id
 * @property int npp
 * @property string name
 * @property string short
 * @property string date
 * @property string photo
 * @property string alias
 * @property string content
 * @property int bc_id
 * @property string photo_big
 * @property string photo_mob
 * @property int likes
 * @property int dislikes
 * @property boolean pinned
 * @property boolean is_active
 * @property int views
 *
 * @property BlogCategory category
 */
class Blog extends ModelBase
{
    protected static $table = 'blog';
    protected static $primaryKeyName = 'blog_id';

    public function offsetGetCategory(): BlogCategory
    {
        return new BlogCategory($this->bc_id);
    }

    public function getContent(): array
    {
        return json_decode($this->content, true)['v'] ?? [];
    }
}