(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.service-slider').forEach(container => {
            const slider = container.querySelector('.service-slider__slider');

            swiperManager.create(slider, {
                navigation: {
                    prevEl: container.querySelector('.service-slider__button-prev'),
                    nextEl: container.querySelector('.service-slider__button-next')
                },
                breakpoints: {
                    0: { spaceBetween: 16, slidesPerView: 1.4 },
                    481: { spaceBetween: 16, slidesPerView: 2.03 },
                    811: { spaceBetween: 16, slidesPerView: 2.07 },
                    1401: { spaceBetween: 20, slidesPerView: 2.34 },
                },
            });
        });
    });
})();