(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.reviews-slider').forEach(container => {
            const slider = container.querySelector('.reviews-slider__slider');

            swiperManager.create(slider, {
                navigation: {
                    prevEl: container.querySelector('.reviews-slider__button-prev'),
                    nextEl: container.querySelector('.reviews-slider__button-next')
                },
                breakpoints: {
                    0: {spaceBetween: 16, slidesPerView: 1.1},
                    481: {spaceBetween: 16, slidesPerView: 2.05},
                    811: {spaceBetween: 16, slidesPerView: 4.13},
                    1401: {spaceBetween: 20, slidesPerView: 4.7}
                }
            });
        });
    });
})();