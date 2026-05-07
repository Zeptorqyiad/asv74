/**
 * Carousel component to display a looping, animated slide deck.
 */
class Carousel {
    /**
     * @param {HTMLElement} container - The root element of the carousel.
     * @param {Object} [options] - Configuration options.
     * @param {boolean} [options.autoplay=false] - Whether to auto-advance slides.
     * @param {number} [options.autoplayInterval=5000] - Delay between auto slides (ms).
     * @param {number} [options.animationDuration=1000] - Slide transition duration (ms).
     */
    constructor(container, options = {}) {
        this.container = container;
        this.track = container.querySelector('.carousel__track');
        this.originalSlides = Array.from(container.querySelectorAll('.carousel__slide'));
        this.totalOriginal = this.originalSlides.length;
        this.autoplay = options.autoplay || false;
        this.autoplayInterval = options.autoplayInterval || 5000;
        this.animationDuration = options.animationDuration || 1000;
        this.preloader = container.querySelector('.carousel__preloader');

        if (this.totalOriginal > 2) {
            const firstClone = this.originalSlides[0].cloneNode(true);
            const lastClone = this.originalSlides[this.totalOriginal - 1].cloneNode(true);
            this.track.insertBefore(lastClone, this.track.firstChild);
            this.track.appendChild(firstClone);
            this.slides = Array.from(this.track.children);
            this.currentIndex = 1;
        } else {
            this.slides = this.originalSlides;
            this.currentIndex = 0;
        }

        this.isAnimating = false;
        this.init();
    }

    /**
     * Initialize event handlers, remove preloader, and kick off autoplay if enabled.
     * @private
     */
    init() {
        this.updateSlides();

        this.slides.forEach(slide =>
            slide.addEventListener('click', () => this.handleSlideClick(slide))
        );

        this.addTouchHandlers();
        this.addKeyboardHandlers();

        if (this.preloader) {
            this.preloader.classList.remove('active');
            this.preloader.addEventListener('transitionend', () => {
                this.preloader.remove();
            });
        }

        if (this.autoplay && this.totalOriginal > 1) {
            this.startAutoplay();
            this.container.addEventListener('mouseenter', () => this.stopAutoplay());
            this.container.addEventListener('mouseleave', () => this.startAutoplay());
        }
    }

    /**
     * Advance to current, previous, and next slides with CSS classes and handle transitions.
     * @private
     */
    updateSlides() {
        if (this.isAnimating) return;
        this.isAnimating = true;

        const prevIndex = (this.currentIndex - 1 + this.slides.length) % this.slides.length;
        const nextIndex = (this.currentIndex + 1) % this.slides.length;

        // Reset all classes
        this.slides.forEach(slide =>
            slide.classList.remove('active', 'prev', 'next', 'hidden', 'hiding', 'showing')
        );

        // Mark visible positions
        this.slides[prevIndex].classList.add('prev');
        this.slides[this.currentIndex].classList.add('active');
        this.slides[nextIndex].classList.add('next');

        // Hide all others
        this.slides.forEach((slide, idx) => {
            if (![prevIndex, this.currentIndex, nextIndex].includes(idx)) {
                slide.classList.add('hiding');
            }
        });

        // Animate newly shown slides
        [prevIndex, nextIndex]
            .filter(i => this.slides[i].classList.contains('hidden'))
            .forEach(i => {
                const s = this.slides[i];
                s.classList.remove('hidden');
                s.classList.add('showing');
                void s.offsetWidth; // force reflow
                s.classList.remove('showing');
                s.classList.add(i === prevIndex ? 'prev' : 'next');
            });

        // Finalize after animation
        setTimeout(() => {
            this.slides.forEach(s => {
                if (s.classList.contains('hiding')) {
                    s.classList.replace('hiding', 'hidden');
                }
            });
            this.isAnimating = false;
            this.checkClone();
        }, this.animationDuration);
    }

    /**
     * Apply CSS classes for active, prev, next, and hidden slides without animation.
     * @private
     */
    applySlideClasses() {
        const prevIndex = (this.currentIndex - 1 + this.slides.length) % this.slides.length;
        const nextIndex = (this.currentIndex + 1) % this.slides.length;

        this.slides.forEach((slide, idx) => {
            slide.classList.remove('active', 'prev', 'next', 'hidden', 'hiding', 'showing');
            if (idx === this.currentIndex) slide.classList.add('active');
            else if (idx === prevIndex) slide.classList.add('prev');
            else if (idx === nextIndex) slide.classList.add('next');
            else slide.classList.add('hidden');
        });
    }

    /**
     * Jump instantly (no CSS transition) to a given slide index.
     * @param {number} newIndex - Index to reset to.
     * @private
     */
    resetToIndex(newIndex) {
        this.track.classList.add('no-transition');
        this.currentIndex = newIndex;
        this.applySlideClasses();
        void this.track.offsetWidth; // flush
        this.track.classList.remove('no-transition');
    }

    /**
     * After looping animation, jump past clones to the real slide.
     * @private
     */
    checkClone() {
        if (this.totalOriginal <= 2) return;
        if (this.currentIndex === 0) {
            this.resetToIndex(this.slides.length - 2);
        } else if (this.currentIndex === this.slides.length - 1) {
            this.resetToIndex(1);
        }
    }

    /**
     * Handle clicks on prev/next slides to navigate.
     * @param {HTMLElement} clickedSlide - The slide element clicked.
     * @private
     */
    handleSlideClick(clickedSlide) {
        if (this.isAnimating || this.totalOriginal <= 1) return;
        const idx = this.slides.indexOf(clickedSlide);
        if (idx === this.currentIndex) return;
        if (clickedSlide.classList.contains('prev')) {
            this.currentIndex = (this.currentIndex - 1 + this.slides.length) % this.slides.length;
        } else if (clickedSlide.classList.contains('next')) {
            this.currentIndex = (this.currentIndex + 1) % this.slides.length;
        }
        this.updateSlides();
    }

    /**
     * Enable swipe gestures to navigate slides.
     * @private
     */
    addTouchHandlers() {
        let startX = 0;
        const threshold = window.innerWidth * 0.1;
        this.container.addEventListener('touchstart', e => {
            if (this.isAnimating || this.totalOriginal <= 1) return;
            startX = e.touches[0].clientX;
        });
        this.container.addEventListener('touchend', e => {
            if (this.isAnimating || this.totalOriginal <= 1) return;
            const delta = e.changedTouches[0].clientX - startX;
            if (Math.abs(delta) > threshold) {
                this.currentIndex = delta > 0
                    ? (this.currentIndex - 1 + this.slides.length) % this.slides.length
                    : (this.currentIndex + 1) % this.slides.length;
                this.updateSlides();
            }
        });
    }

    /**
     * Listen for arrow keys to navigate.
     * @private
     */
    addKeyboardHandlers() {
        this.container.addEventListener('keydown', e => {
            if (this.isAnimating || this.totalOriginal <= 1) return;
            if (e.key === 'ArrowLeft') {
                this.currentIndex = (this.currentIndex - 1 + this.slides.length) % this.slides.length;
                this.updateSlides();
                e.preventDefault();
            } else if (e.key === 'ArrowRight') {
                this.currentIndex = (this.currentIndex + 1) % this.slides.length;
                this.updateSlides();
                e.preventDefault();
            }
        });
    }

    /**
     * Begin automatic slide cycling.
     * @public
     */
    startAutoplay() {
        this.autoplayId = setInterval(() => {
            if (!this.isAnimating && this.totalOriginal > 1) {
                this.currentIndex = (this.currentIndex + 1) % this.slides.length;
                this.updateSlides();
            }
        }, this.autoplayInterval);
    }

    /**
     * Stop automatic slide cycling.
     * @public
     */
    stopAutoplay() {
        clearInterval(this.autoplayId);
    }
}

/**
 * Carousel initialization and Swiper setup.
 */
(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', () => {
        const carouselEl = document.querySelector('.carousel--desktop');
        if (carouselEl) {
            new Carousel(carouselEl, { autoplay: false });
        } else {
            console.error('Carousel element not found.');
        }

        document.querySelectorAll('.carousel--mobile').forEach(container => {
            const slider = container.querySelector('.carousel__swiper');
            swiperManager.create(slider, {
                centeredSlides: true,
                loop: true,
                autoplay: {
                    delay: 5000,
                    disableOnInteraction: true,
                },
                breakpoints: {
                    0: { spaceBetween: 12, slidesPerView: 1.14 },
                    481: { spaceBetween: 12, slidesPerView: 1.5 },
                    811: { spaceBetween: 12, slidesPerView: 1.5 },
                    1401: { spaceBetween: 16, slidesPerView: 1.5 },
                },
                pagination: {
                    el: container.querySelector('.carousel__swiper-pagination'),
                    clickable: true,
                },
            });
        });
    });
})();
