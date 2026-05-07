(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.service-examples').forEach(container => {
            const slider = container.querySelector('.service-examples__slider');

            swiperManager.create(slider, {
                pagination: {
                    el: container.querySelector('.service-examples__pagination'),
                    clickable: true,
                },
                navigation: {
                    prevEl: container.querySelector('.service-examples__button-prev'),
                    nextEl: container.querySelector('.service-examples__button-next')
                },
                spaceBetween: 20,
                slidesPerView: 1,
                autoHeight: true
            });
        });
    });
})();