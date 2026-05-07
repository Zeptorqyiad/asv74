(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.video-reviews-slider').forEach(container => {
            const slider = container.querySelector('.video-reviews-slider__slider');

            swiperManager.create(slider, {
                navigation: {
                    prevEl: container.querySelector('.video-reviews-slider__button-prev'),
                    nextEl: container.querySelector('.video-reviews-slider__button-next')
                },
                breakpoints: {
                    0: { spaceBetween: 16, slidesPerView: 1.5 },
                    481: { spaceBetween: 16, slidesPerView: 3.2 },
                    811: { spaceBetween: 16, slidesPerView: 5.15 },
                    1401: { spaceBetween: 20, slidesPerView: 5.85 }
                }
            });
        });
    });
})();