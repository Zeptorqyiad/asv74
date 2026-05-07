<?php

namespace App\Extensions\Services\Component;

use Simflex\Core\Container;
use Simflex\Core\Factory;
use Simflex\Core\Log;
use App\Extensions\Breadcrumbs\Breadcrumbs;
use Simflex\Core\Page;
use Simflex\Core\Request;
use Simflex\Extensions\Content\Content;
use Simflex\Extensions\Content\Model\ModelContent;

class Services extends Content
{
    protected ?\App\Extensions\Services\Model\Services $service;
    protected string $path = '/services/';
    protected int $c = 0;

    public function __construct(protected Request $request, protected Factory $factory)
    {
        parent::__construct($this->factory);
    }
    public function get($path = ''): ?ModelContent
    {
        $ret = parent::get($this->path);

        if ($this->service) {
            $ret['title'] = $this->service->title;
        }

        return $ret;
    }

    protected function content(): void
    {
        if ($act = $this->request->request('action')) {
            if (method_exists($this, $act)) {
                exit(json_encode($this->{$act}(), JSON_UNESCAPED_UNICODE));
            }
        }

        $this->c = $this->request->request('c', 0);

        $this->service = \App\Extensions\Services\Model\Services::findOne(['alias' => Container::getRequest()->getUrlLastPart()]);

        if ($this->service) {
            Breadcrumbs::remove('/services/service/');
            Breadcrumbs::add($this->service->title, '/services/' . $this->service->alias . '/');
            $this->path = '/services/service/';

            Page::$override['description'] = $this->service->meta_desc;
            Page::$override['keywords'] = $this->service->meta_kw;

            if($this->service->meta_title) {
                Page::$override['title'] = $this->service->meta_title;
            } else {
                Page::$override['title'] = $this->service->title;
            }
        }

        parent::content();
    }
}