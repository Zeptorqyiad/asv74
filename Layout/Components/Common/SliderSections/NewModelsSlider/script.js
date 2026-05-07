(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.new-models-slider').forEach(container => {
            const slider = container.querySelector('.new-models-slider__slider');

            swiperManager.create(slider, {
                pagination: {
                    el: container.querySelector('.new-models-slider__pagination'),
                    clickable: true,
                },
                navigation: {
                    prevEl: container.querySelector('.new-models-slider__button-prev'),
                    nextEl: container.querySelector('.new-models-slider__button-next')
                },
                spaceBetween: 20,
                slidesPerView: 1,
                autoHeight: true
            });
        });
    });
})();