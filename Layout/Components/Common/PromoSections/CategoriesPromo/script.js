(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', () => {
        const categoriesPromoTabs = new TabManager({
            tabListSelector: '.categories-promo__tab-list',
            contentListSelector: '.categories-promo__cat-list',
        });
    });
})();