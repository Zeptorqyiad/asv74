(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.cases-slider').forEach(container => {
            const slider = container.querySelector('.cases-slider__slider');

            swiperManager.create(slider, {
                navigation: {
                    prevEl: container.querySelector('.cases-slider__button-prev'),
                    nextEl: container.querySelector('.cases-slider__button-next')
                },
                breakpoints: {
                    0: { spaceBetween: 16, slidesPerView: 1.2 },
                    481: { spaceBetween: 16, slidesPerView: 2.5 },
                    811: { spaceBetween: 16, slidesPerView: 4.15 },
                    1401: { spaceBetween: 20, slidesPerView: 4.7 },
                },
            });
        });
    });
})();