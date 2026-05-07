<?php
/** @var array $data */

$email = Simflex\Core\Core::siteParam('email');
$phone = Simflex\Core\Core::siteParam('phone');

$title = $data['title'] ?? '<span>Обсудить сотрудничество</span> или нужна консультация?';
$desc = $data['desc'] ?? 'Заполните форму и наш менеджер свяжется с вами в течении 15 минут (в рабочее время)';
$img = $data['image'] ? '/uf/images/source/' . $data['image'] : '/assets/images/default/consult-promo.webp';
?>

<section class="consult-promo">
    <svg class="consult-promo__shape" xmlns="http://www.w3.org/2000/svg" height="775" fill="none"
         viewBox="0 0 1920 775">
        <path d="m769 374.499 79 135c106.772 241.985-777.803-50.014-848-70v132c288.266 80.714 598.649 211.749 902.5 203 60.217-.613 99.5-5.499 155-35 84.03-52.512 47.74-165.282-2-230-35.5-56.702-62.148-108.43-39.5-175 44.85-109.187 197.99-53.477 274-16l630 362.5v-302l-137.5-82.5-217.5-132c-140.58-88.858-200.7-119.014-278-142.5-89.44-24.7-142.71-27.166-242-14.5-89.683 18.423-134.02 35.114-197 81.5-84.552 65.919-143.61 185.971-79 285.5Z"/>
    </svg>

    <div class="consult-promo__container">
        <?php if ($data['manager']): ?>
            <div class="consult-promo__left">
                <h2 class="section-title consult-promo__title"><?= $title ?></h2>
                <p class="consult-promo__desc"><?= $desc ?></p>
                <?php App\Layout\Components\Cards\ManagerCard\Layout::drawManagerCard(
                    name: $data['manager']['name'] ?? '',
                    image: $data['manager']['image'] ?? '',
                    job: $data['manager']['job'] ?? '',
                    phone: $data['manager']['phone'] ?? '',
                    email: $data['manager']['email'] ?? '',
                ); ?>
            </div>
        <?php else: ?>
            <div class="consult-promo__left">
                <h2 class="consult-promo__title"><?= $title ?></h2>
                <p class="consult-promo__desc"><?= $desc ?></p>
                <img class="consult-promo__image <?= $data['contacts'] ? 'consult-promo__image--contacts' : '' ?>"
                     src="<?= $img ?>"
                     alt=""
                     draggable="false"
                     loading="lazy"
                     aria-hidden="true"
                >

                <?php
                if ($data['contacts']) {
                    if ($phone) {
                        App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                            className: 'consult-promo__button-phone',
                            text: '{phone}',
                            link: 'tel:{phone}',
                            style: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactStyle::Filled,
                        );
                    }

                    if ($email) {
                        App\Layout\Components\UI\Core\Buttons\ButtonContact\Layout::drawButtonContact(
                            className: 'consult-promo__button-email',
                            text: '{email}',
                            link: 'mailto:{email}',
                            style: \App\Layout\Components\UI\Core\Buttons\ButtonContact\ButtonContactStyle::Filled,
                        );
                    }
                }
                ?>
            </div>
        <?php endif; ?>
        <div class="consult-promo__right">
            <?php App\Layout\Components\UI\Core\Form\Layout::draw([
                'className' => 'consult-promo__form',
                'nonModal' => true,
                'form_placement' => 'Подвал'
            ]); ?>
        </div>
    </div>
</section>