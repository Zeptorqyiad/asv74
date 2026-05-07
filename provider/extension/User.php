<?php
return new class extends \Simflex\Core\ExtensionConfig
{
    public function __construct()
    {
        $this->name = 'user';
        $this->loadOrder = 0;

        $this->routes = [
            '/auth' => \App\Extensions\Catalog\Component\Auth::class,
            '/user' => \App\Extensions\Catalog\Component\User::class,
        ];
    }
};