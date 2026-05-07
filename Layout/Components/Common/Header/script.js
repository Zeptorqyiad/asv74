(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', () => {
        const headerScrollHandler = new ScrollClassHandler({
            element: '.header',
            className: 'collapsed',
            margin: 100
        });
    });
}());