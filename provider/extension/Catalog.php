<?php
return new class extends \Simflex\Core\ExtensionConfig
{
    public function __construct()
    {
        $this->name = 'catalog';
        $this->loadOrder = 0;

        $this->routes = [
            '/catalog' => \App\Extensions\Catalog\Component\Catalog::class,
            '/reviews' => \App\Extensions\Catalog\Component\Review::class,
            '/question' => \App\Extensions\Catalog\Component\Question::class,
            '/qs' => \App\Extensions\Catalog\Component\Search::class,
            '/brand' => \App\Extensions\Catalog\Component\Catalog::class,
            '/search' => \App\Extensions\Catalog\Component\Catalog::class,
            '/filter' => \App\Extensions\Catalog\Component\Catalog::class,
            '/fav' => \App\Extensions\Catalog\Component\Fav::class,
            '/favorite' => \App\Extensions\Catalog\Component\Catalog::class,
            '/compare' => \App\Extensions\Catalog\Component\Compare::class,
            '/refund' => \App\Extensions\Catalog\Component\Refund::class,
        ];

        $this->commands = [
            'catalog' => \App\Extensions\Catalog\ConsoleCatalog::class,
        ];
    }
};