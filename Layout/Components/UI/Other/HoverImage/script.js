/**
 * @class HoverImage
 * @description Manages image gallery with hover sections and pagination
 */
class HoverImage {
    /**
     * @param {HTMLElement} element - Container element with the hover-image component
     * @param {Object} [options] - Configuration options
     * @param {number} [options.defaultIndex=0] - Initial active image index
     * @param {boolean} [options.enableKeyboardNavigation=true] - Enable keyboard arrow navigation
     * @param {string} [options.imageSelector='.hover-image__img'] - Selector for images
     */
    constructor(element, options = {}) {
        // Core elements
        this.container = element;
        this.options = {
            defaultIndex: 0,
            enableKeyboardNavigation: true,
            imageSelector: '.hover-image__img',
            ...options
        };

        this.images = Array.from(this.container.querySelectorAll(this.options.imageSelector));
        this.sectionsContainer = this.container.querySelector('.hover-image__sections');
        this.paginationContainer = this.container.querySelector('.hover-image__pagination');
        this.activeIndex = this.options.defaultIndex;

        // Early return if no images found
        if (this.images.length === 0) {
            console.warn('HoverImage: No images found in container', this.container);
            return;
        }

        // Make DOM elements easily accessible as class properties
        this.sections = [];
        this.dots = [];

        this.init();
    }

    /**
     * @private
     * @description Initialize the component
     */
    init() {
        this.createSections();
        this.createPagination();
        this.bindEvents();

        // Show initial image
        this.showImage(this.activeIndex);
    }

    /**
     * @private
     * @description Create section elements for hover detection
     */
    createSections() {
        // Clear existing content
        if (!this.sectionsContainer) return;
        this.sectionsContainer.innerHTML = '';

        // Create sections
        this.sections = this.images.map((_, index) => {
            const section = document.createElement('div');
            section.className = 'hover-image__section';
            section.dataset.index = index;
            this.sectionsContainer.appendChild(section);
            return section;
        });
    }

    /**
     * @private
     * @description Create pagination dots
     */
    createPagination() {
        // Clear existing content
        if (!this.paginationContainer) return;
        this.paginationContainer.innerHTML = '';

        // Create pagination dots
        this.dots = this.images.map((_, index) => {
            const dot = document.createElement('div');
            dot.className = 'hover-image__dot';
            dot.dataset.index = index;
            this.paginationContainer.appendChild(dot);
            return dot;
        });

        if (this.dots.length <= 1) {
            this.paginationContainer.style.display = 'none';
        }
    }

    /**
     * @private
     * @description Attach event listeners
     */
    bindEvents() {
        // Section hover events with event delegation
        if (this.sectionsContainer) {
            this.sectionsContainer.addEventListener('mouseover', this.handleSectionHover.bind(this));
        }

        // Pagination click events with event delegation
        if (this.paginationContainer) {
            this.paginationContainer.addEventListener('click', this.handlePaginationClick.bind(this));
        }

        // Reset on mouse leave
        this.container.addEventListener('mouseleave', () => this.showImage(this.options.defaultIndex));

        // Keyboard navigation
        if (this.options.enableKeyboardNavigation) {
            this.handleKeyboardNavigation = this.handleKeyboardNavigation.bind(this);
            this.container.addEventListener('focus', () => {
                document.addEventListener('keydown', this.handleKeyboardNavigation);
            });
            this.container.addEventListener('blur', () => {
                document.removeEventListener('keydown', this.handleKeyboardNavigation);
            });

            // Make container focusable
            if (this.container.tabIndex === -1 || !this.container.hasAttribute('tabindex')) {
                this.container.tabIndex = 0;
            }
        }
    }

    /**
     * @private
     * @param {Event} e - MouseEvent object
     */
    handleSectionHover(e) {
        const section = e.target.closest('.hover-image__section');
        if (section) {
            const index = parseInt(section.dataset.index, 10);
            this.showImage(index);
        }
        e.stopPropagation();
    }

    /**
     * @private
     * @param {Event} e - MouseEvent object
     */
    handlePaginationClick(e) {
        const dot = e.target.closest('.hover-image__dot');
        if (dot) {
            const index = parseInt(dot.dataset.index, 10);
            this.showImage(index);

            // Focus the container for keyboard navigation
            if (this.options.enableKeyboardNavigation) {
                this.container.focus();
            }
        }
    }

    /**
     * @private
     * @param {KeyboardEvent} e - Keyboard event object
     */
    handleKeyboardNavigation(e) {
        // Only respond to arrow keys
        if (e.key === 'ArrowLeft') {
            e.preventDefault();
            this.prev();
        } else if (e.key === 'ArrowRight') {
            e.preventDefault();
            this.next();
        }
    }

    /**
     * @public
     * @description Show the next image
     * @returns {number} New active index
     */
    next() {
        const newIndex = (this.activeIndex + 1) % this.images.length;
        this.showImage(newIndex);
        return newIndex;
    }

    /**
     * @public
     * @description Show the previous image
     * @returns {number} New active index
     */
    prev() {
        const newIndex = (this.activeIndex - 1 + this.images.length) % this.images.length;
        this.showImage(newIndex);
        return newIndex;
    }

    /**
     * @public
     * @description Display image at specified index
     * @param {number} index - Index of image to show
     * @returns {boolean} Success status
     */
    showImage(index) {
        if (index < 0 || index >= this.images.length || !Number.isInteger(index)) {
            console.warn(`HoverImage: Invalid index ${index}`);
            return false;
        }

        // Update images with classList toggle
        this.images.forEach((img, i) => {
            img.classList.toggle('hover-image__img--active', i === index);
        });

        // Update pagination dots
        this.dots.forEach((dot, i) => {
            dot.classList.toggle('hover-image__dot--active', i === index);
        });

        // Update active index
        this.activeIndex = index;

        // Dispatch custom event
        const event = new CustomEvent('hoverimage:change', {
            detail: { index: this.activeIndex }
        });
        this.container.dispatchEvent(event);

        return true;
    }

    /**
     * @public
     * @description Clean up event listeners and references
     */
    destroy() {
        // Remove event listeners
        if (this.sectionsContainer) {
            this.sectionsContainer.removeEventListener('mouseover', this.handleSectionHover);
        }

        if (this.paginationContainer) {
            this.paginationContainer.removeEventListener('click', this.handlePaginationClick);
        }

        this.container.removeEventListener('mouseleave', () => this.showImage(0));

        if (this.options.enableKeyboardNavigation) {
            document.removeEventListener('keydown', this.handleKeyboardNavigation);
        }

        // Clear references
        this.images = null;
        this.sections = null;
        this.dots = null;
        this.container = null;
    }
}

/**
 * @function initHoverImages
 * @description Initialize all hover-image components on the page
 * @param {string} [selector='[data-hover-image]'] - Selector for hover image containers
 * @param {Object} [options] - Default options for all instances
 * @returns {Array<HoverImage>} Array of initialized HoverImage instances
 */
function initHoverImages(selector = '[data-hover-image]', options = {}) {
    const containers = document.querySelectorAll(selector);
    const instances = [];

    containers.forEach(container => {
        // Parse data attributes as options
        const containerOptions = { ...options };
        if (container.dataset.defaultIndex) {
            containerOptions.defaultIndex = parseInt(container.dataset.defaultIndex, 10);
        }

        // Create and store instance
        const instance = new HoverImage(container, containerOptions);
        instances.push(instance);

        // Store reference on DOM element
        container._hoverImage = instance;
    });

    return instances;
}

// Initialize all hover-image components when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    initHoverImages();
});