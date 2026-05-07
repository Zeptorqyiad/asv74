<?php

namespace App\Extensions\Blog\Component;

use Simflex\Core\Container;
use Simflex\Core\Factory;
use Simflex\Core\Log;
use App\Extensions\Breadcrumbs\Breadcrumbs;
use Simflex\Core\Page;
use Simflex\Core\Request;
use Simflex\Extensions\Content\Content;
use Simflex\Extensions\Content\Model\ModelContent;

class Blog extends Content
{
    protected ?\App\Extensions\Blog\Model\Blog $post;
    protected string $path = '/blog/';
    protected int $c = 0;

    public function __construct(protected Request $request, protected Factory $factory)
    {
        parent::__construct($this->factory);
    }

    public function get($path = ''): ?ModelContent
    {
        $ret = parent::get($this->path);
        if ($this->post) {
            $ret['title'] = $this->post->category->name;
        }

        return $ret;
    }

    /**
     * /blog/?action=like&like=<1/0>&had_old=<1/0>&post_id=<post id>
     *
     * like - if set to 1, will change likes
     * had_old - if set to 1, will change dislikes if likes changing, and vice versa
     * post_id - id of the blog post
     *
     * @return array|false[]
     * @throws \Exception
     */
    protected function like(): array
    {
        $post = \App\Extensions\Blog\Model\Blog::findOne(['blog_id' => $this->request->request('post_id')]);
        if (!$post) {
            return ['success' => false];
        }

        $isLike = $this->request->request('like');
        $hadOld = $this->request->request('had_old');

        if ($isLike) {
            ++$post->likes;
            if ($hadOld) {
                --$post->dislikes;
            }
        } else {
            ++$post->dislikes;
            if ($hadOld) {
                --$post->likes;
            }
        }

        $post->likes = max($post->likes, 0);
        $post->dislikes = max($post->dislikes, 0);

        return ['success' => $post->save()];
    }

    protected function content(): void
    {
        if ($act = $this->request->request('action')) {
            if (method_exists($this, $act)) {
                exit(json_encode($this->{$act}(), JSON_UNESCAPED_UNICODE));
            }
        }

        $this->c = $this->request->request('c', 0);

        $this->post = \App\Extensions\Blog\Model\Blog::findOne(['alias' => Container::getRequest()->getUrlLastPart()]);
        if ($this->post) {
            Breadcrumbs::remove('/blog/post/');
            Breadcrumbs::add($this->post->name, '/blog/' . $this->post->alias . '/');
            $this->path = '/blog/post/';

            Page::$override['description'] = $this->post->meta_desc;
            Page::$override['keywords'] = $this->post->meta_kw;

            if($this->post->meta_title) {
                Page::$override['title'] = $this->post->meta_title;
            } else {
                Page::$override['title'] = $this->post->name;
            }

            $this->post->views++;
            $this->post->save();
        }

        parent::content();
    }
}