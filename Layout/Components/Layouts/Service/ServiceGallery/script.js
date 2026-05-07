(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.service-gallery').forEach(container => {
            const sliderMain = container.querySelector('.service-gallery__slider');
            const sliderAsideThumbs = container.querySelector('.service-gallery__thumbs');

            if (!sliderMain || !sliderAsideThumbs) return;

            const thumbsSwiper = swiperManager.create(sliderAsideThumbs, {
                loop: true,
                mousewheel: true,
                spaceBetween: 12,
                slidesPerView: 3,
                watchSlidesProgress: true,
                breakpoints: {
                    0: {
                        direction: 'horizontal'
                    },
                    812: {
                        direction: 'vertical'
                    }
                }
            });

            swiperManager.create(sliderMain, {
                loop: true,
                effect: 'fade',
                fadeEffect: {
                    crossFade: true
                },
                slidesPerView: 1,
                navigation: {
                    prevEl: container.querySelector('.service-gallery__slider-button--prev'),
                    nextEl: container.querySelector('.service-gallery__slider-button--next'),
                },
                pagination: {
                    el: container.querySelector('.service-gallery__slider-pagination'),
                    clickable: true
                },
                thumbs: {
                    swiper: thumbsSwiper
                }
            });
        });
    });
})();
