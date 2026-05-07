(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.promo-slider').forEach(container => {
            const slider = container.querySelector('.promo-slider__slider');
            const prevBtn = container.querySelector('.promo-slider__button-prev');
            const nextBtn = container.querySelector('.promo-slider__button-next');
            const buttonsContainer = container.querySelector('.promo-slider__btn');
            const linkBtn = container.querySelector('.promo-slider__button-link');

            const isMobile = window.innerWidth <= 768;

            if (isMobile) {
                container.querySelectorAll('.promo-slider__image').forEach(el => el.remove());
            } else {
                container.querySelectorAll('.promo-slider__image--mob').forEach(el => el.remove());
            }

            const slides = slider.querySelectorAll('.swiper-slide');
            if (slides.length === 0) return;

            const originalSlides = slider.querySelectorAll('.swiper-slide:not(.swiper-slide-duplicate)');
            const links = Array.from(originalSlides).map(slide => slide.dataset.link);

            const updateLink = (swiperInstance) => {
                if (linkBtn && links.length > 0) {
                    const realIndex = swiperInstance.realIndex;
                    const link = links[realIndex];
                    if (link) {
                        linkBtn.href = link;
                    } else {
                        linkBtn.href = '';
                    }
                }
            };

            const swiperOptions = {
                navigation: {
                    prevEl: prevBtn,
                    nextEl: nextBtn
                },
                spaceBetween: 20,
                on: {
                    slideChange: function () {
                        updateLink(this);
                    }
                }
            };

            if (slides.length > 1) {
                swiperOptions.loop = true;
            } else {
                if (buttonsContainer) {
                    buttonsContainer.style.display = 'none';
                }
            }

            const swiper = swiperManager.create(slider, swiperOptions);

            updateLink(swiper);
        });
    });
})();

window.addEventListener('resize', () => {
    const swiper = document.querySelector('.promo-slider__slider')?.swiper;
    if (swiper) {
        swiper.update();
    }
});