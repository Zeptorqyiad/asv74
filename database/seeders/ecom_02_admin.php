<?php

use Simflex\Core\Models\AdminMenu;
use Simflex\Core\Models\UserPriv;

return new class implements \Simflex\Core\DB\Seeder {
    public function seed(): void
    {
        $adminPriv = UserPriv::byName('admin');
        $shop = AdminMenu::byLink('/admin/shop/');

        AdminMenu::bulkInsert([
            [
                'menu_pid' => $shop->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 0,
                'name' => 'Заказы',
                'link' => '/admin/shop/order/',
                'model' => 'catalog_order',
                'icon' => 'lead-mini',
                'hidden' => 0,
            ],
            [
                'menu_pid' => $shop->menu_id,
                'priv_id' => $adminPriv->priv_id,
                'npp' => 508,
                'name' => 'Способы оплаты',
                'link' => '/admin/shop/payment/',
                'model' => 'catalog_payment',
                'icon' => '',
                'hidden' => 0,
            ],
        ]);
    }
};