<?php

use Simflex\Core\Models\AdminMenu;
use Simflex\Core\Models\UserPriv;

return new class implements \Simflex\Core\DB\Seeder {
    public function seed(): void
    {
        $adminPriv = UserPriv::byName('admin');

        $shop = AdminMenu::insertStatic([
            'menu_pid' => null,
            'priv_id' => $adminPriv->priv_id,
            'npp' => 400,
            'name' => 'Интернет-магазин',
            'link' => '/admin/shop/',
            'model' => '',
            'icon' => 'cart',
            'hidden' => 0,
        ]);

        $editor = AdminMenu::insertStatic([
            'menu_pid' => $shop->menu_id,
            'priv_id' => $adminPriv->priv_id,
            'npp' => 10,
            'name' => 'Редактор товаров',
            'link' => '/admin/shop/product/',
            'model' => '',
            'icon' => 'edit-mini',
            'hidden' => 0,
        ]);

        AdminMenu::bulkInsert([
            [
                'menu_pid' => $editor->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 0,
                'name' => 'Категории',
                'link' => '/admin/shop/product/category/',
                'model' => 'catalog_category',
                'icon' => '',
                'hidden' => 0,
            ],
            [
                'menu_pid' => $editor->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 1,
                'name' => 'Товары',
                'link' => '/admin/shop/product/product/',
                'model' => 'catalog_product',
                'icon' => '',
                'hidden' => 0,
            ],
            [
                'menu_pid' => $editor->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 503,
                'name' => 'Бренды',
                'link' => '/admin/shop/brand/',
                'model' => 'catalog_brand',
                'icon' => '',
                'hidden' => 0,
            ],
        ]);

        $sale = AdminMenu::insertStatic([
            'menu_pid' => $shop->menu_id,
            'priv_id' => $adminPriv->priv_id,
            'npp' => 50,
            'name' => 'Акции',
            'link' => '/admin/shop/sale/',
            'model' => 'catalog_sale',
            'icon' => 'sale-mini',
            'hidden' => 0,
        ]);

        AdminMenu::bulkInsert([
            [
                'menu_pid' => $sale->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 10,
                'name' => 'Баннеры',
                'link' => '/admin/shop/sale/banner/',
                'model' => 'catalog_sale_banner',
                'icon' => '',
                'hidden' => 0,
            ],
        ]);

        $param = AdminMenu::insertStatic([
            'menu_pid' => $shop->menu_id,
            'priv_id' => $adminPriv->priv_id,
            'npp' => 20,
            'name' => 'Характеристики',
            'link' => '/admin/params/',
            'model' => '',
            'icon' => 'settings-mini',
            'hidden' => 0,
        ]);

        AdminMenu::bulkInsert([
            [
                'menu_pid' => $param->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 0,
                'name' => 'Категории',
                'link' => '/admin/params/category/',
                'model' => 'catalog_param_category',
                'icon' => '',
                'hidden' => 0,
            ],
            [
                'menu_pid' => $param->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 20,
                'name' => 'Характеристики',
                'link' => '/admin/param/param/',
                'model' => 'catalog_param',
                'icon' => '',
                'hidden' => 0,
            ],
        ]);

        AdminMenu::bulkInsert([
            [
                'menu_pid' => $shop->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 30,
                'name' => 'Клиенты',
                'link' => '/admin/shop/user/',
                'model' => 'user',
                'icon' => 'users-mini',
                'hidden' => 0,
            ],
            [
                'menu_pid' => $shop->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 40,
                'name' => 'Отзывы',
                'link' => '/admin/shop/review/',
                'model' => 'review',
                'icon' => 'message-mini',
                'hidden' => 1,
            ],
            [
                'menu_pid' => $shop->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 0,
                'name' => 'Склад',
                'link' => '/admin/shop/stock',
                'model' => 'catalog_stock',
                'icon' => 'container-mini',
                'hidden' => 0,
            ],
            [
                'menu_pid' => $shop->menu_id,
                'priv_id' => 5,
                'npp' => 45,
                'name' => 'Вопросы',
                'link' => '/admin/shop/question/',
                'model' => 'question',
                'icon' => 'message-mini',
                'hidden' => 0,
            ],
            [
                'menu_pid' => $shop->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 505,
                'name' => 'Способы доставки',
                'link' => '/admin/shop/transcomp/',
                'model' => 'catalog_transcomp',
                'icon' => 'geo-mini',
                'hidden' => 0,
            ],
        ]);
    }
};