(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.case-fs').forEach(container => {
            const sliderMain = container.querySelector('.case-fs__main-slider');
            const sliderAsideThumbs = container.querySelector('.case-fs__images-aside');
            const sliderMainMobile = container.querySelector('.case-fs__slider-wrap');

            if (!sliderMain || !sliderAsideThumbs) return;

            const thumbsSwiper = swiperManager.create(sliderAsideThumbs, {
                loop: true,
                mousewheel: true,
                direction: 'vertical',
                spaceBetween: 12,
                slidesPerView: 3,
                watchSlidesProgress: true
            });

             swiperManager.create(sliderMain, {
                loop: true,
                effect: 'fade',
                fadeEffect: {
                    crossFade: true
                },
                slidesPerView: 1,
                navigation: {
                    prevEl: container.querySelector('.case-fs__slider-button--prev'),
                    nextEl: container.querySelector('.case-fs__slider-button--next'),
                },
                pagination: {
                    el: container.querySelector('.case-fs__main-slider-pagination'),
                    clickable: true
                },
                thumbs: {
                    swiper: thumbsSwiper
                }
            });

            if (sliderMainMobile) {
                swiperManager.create(sliderMainMobile, {
                    loop: true,
                    pagination: {
                        el: container.querySelector('.case-fs__slider-pagination'),
                        clickable: true
                    },
                    spaceBetween: 20,
                    slidesPerView: 1
                });
            }
        });
    });
})();
