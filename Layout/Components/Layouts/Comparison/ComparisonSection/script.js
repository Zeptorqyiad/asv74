(function () {
    'use strict';

    /**
     * Initializes comparison sliders and collapse toggles on DOMContentLoaded.
     * Uses ScrollTrigger for sticky behavior and ScrollClassHandler for collapsing.
     */
    document.addEventListener('DOMContentLoaded', () => {
        // Find each comparison container on the page
        document.querySelectorAll('.comparison').forEach(container => {
            /** @type {HTMLElement} Main product images container */
            const productsSlider = container.querySelector('.comparison__products-slider');
            /** @type {HTMLElement} Comparison sheet slider container */
            const sheetSlider    = document.querySelector('.comparison-sheet__products-slider');
            /** @type {NodeListOf<HTMLElement>} All row/group sliders in this comparison */
            const sliderGroups   = container.querySelectorAll('.comparison__group-slider, .comp-table-row');

            // Initialize "sticky" behavior for the comparison sheet header
            new ScrollTrigger(
                '.comparison-sheet',
                '.comparison__body',
                'sticky',
                { offset: 50 }
            );

            // Add a 'collapsed' class when scrolling past a threshold
            new ScrollClassHandler({
                element: '.comparison-sheet',
                className: 'collapsed',
                margin: 100
            });

            // --- 1) Create swiper instances without controllers to avoid undefined reference ---

            /**
             * Swiper for the main product slider.
             * @type {Swiper}
             */
            const productSwiper = swiperManager.create(productsSlider, {
                a11y: { enabled: false },
                loop: false,
                navigation: {
                    prevEl: container.querySelector('.comparison__button-prev'),
                    nextEl: container.querySelector('.comparison__button-next')
                },
                breakpoints: {
                    0:    { spaceBetween: 16, slidesPerView: 2 },
                    481:  { spaceBetween: 16, slidesPerView: 4 },
                    811:  { spaceBetween: 20, slidesPerView: 4 },
                    1401: { spaceBetween: 20, slidesPerView: 4 }
                }
            });

            /**
             * Swiper for the comparison data sheet.
             * @type {Swiper}
             */
            const sheetSwiper = swiperManager.create(sheetSlider, {
                a11y: { enabled: false },
                loop: false,
                navigation: {
                    prevEl: container.querySelector('.comparison__button-prev'),
                    nextEl: container.querySelector('.comparison__button-next')
                },
                breakpoints: {
                    0:    { spaceBetween: 16, slidesPerView: 2 },
                    481:  { spaceBetween: 16, slidesPerView: 4 },
                    811:  { spaceBetween: 20, slidesPerView: 4 },
                    1401: { spaceBetween: 20, slidesPerView: 4 }
                }
            });

            /**
             * Array of Swipers for each individual comparison row/group.
             * @type {Swiper[]}
             */
            const groupSwipers = Array.from(sliderGroups).map(group => {
                return swiperManager.create(group, {
                    a11y: { enabled: false },
                    loop: false,
                    autoHeight: true,
                    breakpoints: {
                        0:    { spaceBetween: 16, slidesPerView: 2 },
                        481:  { spaceBetween: 16, slidesPerView: 4 },
                        811:  { spaceBetween: 20, slidesPerView: 4 },
                        1401: { spaceBetween: 20, slidesPerView: 4 }
                    }
                });
            });

            // --- 2) Wire controllers to sync slides without infinite loops ---
            /**
             * Master swiper (product slider) controls sheet + group sliders.
             * Other swipers sync back solely to the master.
             */
            productSwiper.controller.control = [ sheetSwiper, ...groupSwipers ];

            /** Make the sheet slider follow productSwiper */
            sheetSwiper.controller.control   = productSwiper;

            /** Make each group slider follow productSwiper */
            groupSwipers.forEach(g => g.controller.control = productSwiper);
        });

        // Collapse/expand toggle for each comparison group header
        document.querySelectorAll('.comparison__group').forEach(group => {
            const trigger = group.querySelector('.comparison__group-top');
            trigger.addEventListener('click', () => {
                group.classList.toggle('collapsed');
            });
        });
    });
})();
