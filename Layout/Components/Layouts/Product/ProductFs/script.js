(function () {
    'use strict';

    /**
     * @module ProductGallery
     * @description Initializes product image galleries with interactive Swiper sliders and smooth image transitions.
     * This module handles:
     * - Main vertical thumbnail slider
     * - Primary image display with fade transitions
     * - Click interactions for thumbnail navigation
     * - Synchronization between thumbnail selection and main image display
     *
     * @listens DOMContentLoaded
     */
    document.addEventListener('DOMContentLoaded', function () {
        /**
         * @function initializeGallery
         * @description Initializes Swiper sliders and event handlers for each product gallery container
         */
        document.querySelectorAll('.product-fs').forEach(container => {
            const sliderMain = container.querySelector('.product-fs__main-slider');
            const sliderAsideThumbs = container.querySelector('.product-fs__images-aside');
            const sliderMainMobile = container.querySelector('.product-fs__slider-wrap');

            if (!sliderMain || !sliderAsideThumbs) return;

            const thumbsSwiper = swiperManager.create(sliderAsideThumbs, {
                loop: true,
                mousewheel: true,
                direction: 'vertical',
                spaceBetween: 4,
                slidesPerView: 5,
                watchSlidesProgress: true
            });

            const mainSwiper = swiperManager.create(sliderMain, {
                loop: true,
                effect: 'fade',
                fadeEffect: {
                    crossFade: true
                },
                slidesPerView: 1,
                navigation: {
                    prevEl: container.querySelector('.product-fs__slider-button-prev'),
                    nextEl: container.querySelector('.product-fs__slider-button-next'),
                },
                thumbs: {
                    swiper: thumbsSwiper
                }
            });

            if (sliderMainMobile) {
                const mobileSwiper = swiperManager.create(sliderMainMobile, {
                    loop: true,
                    pagination: {
                        el: container.querySelector('.product-fs__slider-pagination'),
                        clickable: true
                    },
                    spaceBetween: 20,
                    slidesPerView: 1
                });
            }
        });
    });
})();
