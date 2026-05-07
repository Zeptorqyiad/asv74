<?php
return new class extends \Simflex\Core\ExtensionConfig
{
    public function __construct()
    {
        $this->name = 'ecom';
        $this->loadOrder = 0;

        $this->routes = [
            '/cart' => \App\Extensions\Catalog\Component\Cart::class,
            '/user/order' => \App\Extensions\Catalog\Component\Order::class,
            '/user/orders' => \App\Extensions\Catalog\Component\Order::class,
        ];
    }
};