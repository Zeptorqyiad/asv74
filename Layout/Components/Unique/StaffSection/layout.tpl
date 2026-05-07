<?php
/** @var array $data */

?>

<section class="staff-section" id="staff">
    <?php foreach (\App\Extensions\Site\Model\ManagerSec::findAdv()->where('is_active = 1')->orderBy('npp')->all() as $sec): ?>
        <div class="staff-section__container container">
            <h3 class="staff-section__title"><?= $sec->title ?></h3>

            <div class="staff-section__list">
                <?php foreach ($sec->getManagers() as $c) {
                    $links = [];
                    if ($c->email) {
                        $links[] = [
                            'type' => 'email',
                            'link' => $c->email,
                        ];
                    }

                    foreach (json_decode($c->phones, true)['v'] ?? [] as $p) {
                        $links[] = [
                            'type' => 'phone',
                            'link' => $p['phone'],
                        ];
                    }

                    \App\Layout\Components\Cards\StaffCard\Layout::drawStaffCard(
                        image: '/uf/images/source/' . $c->avatar,
                        name: $c->name . ' ' . $c->last_name,
                        job: $c->job,
                        links: $links,
                    );
                } ?>
            </div>
        </div>
    <?php endforeach; ?>
</section>