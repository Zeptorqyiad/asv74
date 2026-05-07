(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.certificates-slider').forEach(container => {
            const slider = container.querySelector('.certificates-slider__slider');

            swiperManager.create(slider, {
                loopAdditionalSlides: 8,
                navigation: {
                    prevEl: container.querySelector('.certificates-slider__button-prev'),
                    nextEl: container.querySelector('.certificates-slider__button-next')
                },
                breakpoints: {
                    0: {spaceBetween: 16, slidesPerView: 1.8},
                    481: {spaceBetween: 16, slidesPerView: 3.8},
                    811: {spaceBetween: 16, slidesPerView: 6.2},
                    1401: {spaceBetween: 20, slidesPerView: 7.05}
                }
            });
        });
    });
})();