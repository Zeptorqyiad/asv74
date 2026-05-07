<?php

return [
    '/' => \App\Extensions\Content\Content::class,
    '/blog' => \App\Extensions\Blog\Component\Blog::class,
    '/cases' => \App\Extensions\Site\Component\CaseDetail::class,
    '/geo' => \App\Extensions\GeoIp\Component\GeoIp::class,
    '/form' => \App\Extensions\Form\Component\AjaxForm::class,
    '/api/prod' => \App\Extensions\Site\Component\Product::class,
    '/catalog' =>  \App\Extensions\Site\Component\Catalog::class,
    '/qs' => \App\Extensions\Site\Component\Search::class,
    '/compare' => \App\Extensions\Site\Component\Compare::class,
    '/services' => \App\Extensions\Services\Component\Services::class,
];