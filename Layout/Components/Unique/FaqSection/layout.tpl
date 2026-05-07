<?php
/** @var array $data */

$cats = App\Extensions\Site\Model\FaqCategory::findAdv()->all();
?>

<section class="faq-section">
    <div class="faq-section__container container">
        <?php App\Layout\Components\Common\AsideMenu\Layout::drawAsideMenu(); ?>

        <div class="faq-section__body">
            <?php foreach ($cats as $c): ?>
                <?php if ($children = $c->getChildren()): ?>
                    <div class="faq-section__category" id="<?= $c->anchor ?>">
                        <h3 class="faq-section__category-title"><?= $c->name ?></h3>

                        <div class="faq-section__category-list-wrap">
                            <ul class="faq-section__category-list" role="tablist">
                                <?php foreach ($children as $index => $item) {
                                    if ($index % 2 === 0) {
                                        App\Layout\Components\UI\Core\Accordion\Layout::drawAccordion(
                                            title: $item->question,
                                            description: $item->answer
                                        );
                                    }
                                } ?>
                            </ul>

                            <ul class="faq-section__category-list" role="tablist">
                                <?php foreach ($children as $index => $item) {
                                    if ($index % 2 === 1) {
                                        App\Layout\Components\UI\Core\Accordion\Layout::drawAccordion(
                                            title: $item->question,
                                            description: $item->answer
                                        );
                                    }
                                } ?>
                            </ul>
                        </div>
                    </div>
                <?php endif; ?>
            <?php endforeach; ?>
        </div>
    </div>
</section>