<?php

namespace App\Extensions\Site\Component;

use Simflex\Core\Container;
use Simflex\Core\Factory;
use Simflex\Core\Request;
use Simflex\Extensions\Content\Content;
use Simflex\Extensions\Content\Model\ModelContent;

class CaseDetail extends Content
{
    protected ?\App\Extensions\Site\Model\CaseDetail $case;
    protected string $path = '/cases/';
    protected int $c = 0;

    public function __construct(protected Request $request, protected Factory $factory)
    {
        parent::__construct($this->factory);
    }

    public function get($path = ''): ?ModelContent
    {
        $ret = parent::get($this->path);
        if ($this->case) {
            $ret['title'] = $this->case->title;
        }
        return $ret;
    }

    protected function content(): void
    {
        $this->c = $this->request->request('c', 0);

        $this->case = \App\Extensions\Site\Model\CaseDetail::findOne([
            'alias' => Container::getRequest()->getUrlLastPart()
        ]);

        if ($this->case) {
            $this->path = '/cases/case/';
        }

        parent::content();
    }
}
