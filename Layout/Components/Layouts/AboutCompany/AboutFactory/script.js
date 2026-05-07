(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.about-factory').forEach(container => {
            const slider = container.querySelector('.about-factory__slider');

            swiperManager.create(slider, {
                loop: false,
                navigation: {
                    prevEl: container.querySelector('.about-factory__button-prev'),
                    nextEl: container.querySelector('.about-factory__button-next')
                },
                breakpoints: {
                    0: { spaceBetween: 16, slidesPerView: 1.2 },
                    481: { spaceBetween: 16, slidesPerView: 1.5 },
                    811: { spaceBetween: 16, slidesPerView: 3.15 },
                    1401: { spaceBetween: 20, slidesPerView: 3.7 },
                },
            });
        });
    });
})();