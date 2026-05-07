(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.products-slider').forEach(container => {
            const slider = container.querySelector('.products-slider__slider');

            swiperManager.create(slider, {
                navigation: {
                    prevEl: container.querySelector('.products-slider__button-prev'),
                    nextEl: container.querySelector('.products-slider__button-next')
                },
                breakpoints: {
                    0: {spaceBetween: 16, slidesPerView: 1.2},
                    481: {spaceBetween: 16, slidesPerView: 2.7},
                    811: {spaceBetween: 16, slidesPerView: 3.1},
                    1401: {spaceBetween: 20, slidesPerView: 3.53}
                }
            });
        });
    });
})();