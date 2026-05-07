(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', () => {
        const categoriesGridTabs = new TabManager({
            tabListSelector: '.category-grid__tab-list',
            contentListSelector: '.category-grid__wrap-list',
        });
    });
})();