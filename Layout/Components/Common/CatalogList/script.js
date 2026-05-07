(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', () => {
        const catalogGroups = document.querySelectorAll('.catalog-list__group');

        if (catalogGroups) {
            catalogGroups.forEach(group => {
                const trigger = group.querySelector('.catalog-list__group-top');

                trigger.addEventListener('click', () => {
                    if (group.classList.contains('collapsed')) {
                        group.classList.remove('collapsed');
                    } else {
                        group.classList.add('collapsed');
                    }
                });
            });
        }
    });
}());