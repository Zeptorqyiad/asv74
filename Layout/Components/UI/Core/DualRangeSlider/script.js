/**
 * @typedef {Object} DualRangeOptions
 * @property {number} [min=0] - Minimum value of the range
 * @property {number} [max=100] - Maximum value of the range
 * @property {number} [step=1] - Step size for value changes
 * @property {number} [minNow=20] - Initial minimum selected value
 * @property {number} [maxNow=80] - Initial maximum selected value
 * @property {function(number, number): void} [onChange] - Callback when values change
 */

/**
 * DualRangeSlider creates an interactive dual-handle range slider with input fields.
 * Handles both mouse and touch events, and includes keyboard accessibility.
 */
class DualRangeSlider {
    /**
     * Creates a new DualRangeSlider instance.
     * @param {HTMLElement} element - The container element for the slider
     * @param {DualRangeOptions} [options={}] - Configuration options
     */
    constructor(element, options = {}) {
        /** @type {HTMLElement} */
        this.element = element;

        /** @type {DualRangeOptions} */
        this.options = {
            min: options.min,
            max: options.max,
            step: options.step ?? 1,
            minNow: options.minNow,
            maxNow: options.maxNow,
            onChange: options.onChange ?? (() => {
            })
        };

        // Cache DOM elements
        const container = this.element.closest('.dual-range');
        if (!container) {
            console.error('Slider container not found:', this.element);
            return;
        }
        const inputGroup = container.querySelector('.dual-range__input-group');
        if (!inputGroup) {
            console.error('Input group not found in container:', container);
            return;
        }
        const inputs = inputGroup.querySelectorAll('input');
        if (inputs.length < 2) {
            console.error('Not enough inputs found in input group:', inputGroup);
            return;
        }
        this.minInput = inputs[0];
        this.maxInput = inputs[1];
        this.minHandle = this.element.querySelector('.min-handle');
        this.maxHandle = this.element.querySelector('.max-handle');
        this.track = this.element.querySelector('.dual-range__slider-track');

        // State
        /** @type {HTMLElement|null} */
        this.activeHandle = null;
        /** @type {boolean} */
        this.isDragging = false;

        this.init();
        this.bindEvents();
    }

    /**
     * Initializes the slider with default values and ARIA attributes
     * @private
     */
    init() {
        // Set ARIA attributes
        this.minHandle.setAttribute('aria-valuemin', this.options.min.toString());
        this.minHandle.setAttribute('aria-valuemax', this.options.max.toString());
        this.maxHandle.setAttribute('aria-valuemin', this.options.min.toString());
        this.maxHandle.setAttribute('aria-valuemax', this.options.max.toString());

        this.updatePositions();
        this.updateAria();
        this.updateInputs();
    }

    /**
     * Binds all necessary event listeners
     * @private
     */
    bindEvents() {
        // Handle events
        [this.minHandle, this.maxHandle].forEach(handle => {
            handle.addEventListener('mousedown', (e) => this.startDragging(e, handle));
            handle.addEventListener('touchstart', (e) => this.startDragging(e, handle));
            handle.addEventListener('keydown', (e) => this.handleKeyboard(e, handle));
        });

        // Document-level events for drag handling
        document.addEventListener('mousemove', this.drag.bind(this));
        document.addEventListener('touchmove', this.drag.bind(this));
        document.addEventListener('mouseup', this.stopDragging.bind(this));
        document.addEventListener('touchend', this.stopDragging.bind(this));

        // Track click handling
        this.element.addEventListener('click', this.handleTrackClick.bind(this));

        // Input field events
        this.minInput.addEventListener('input', this.handleMinInput.bind(this));
        this.maxInput.addEventListener('input', this.handleMaxInput.bind(this));
        this.minInput.addEventListener('blur', this.validateInput.bind(this));
        this.maxInput.addEventListener('blur', this.validateInput.bind(this));
    }

    /**
     * Handles minimum input field changes
     * @param {Event} e - Input event
     * @private
     */
    handleMinInput(e) {
        const value = parseInt(e.target.value);
        if (isNaN(value)) return;

        if (value >= this.options.maxNow) {
            e.target.classList.add('error');
            return;
        }

        e.target.classList.remove('error');
        const percentage = this.valueToPercentage(value);
        this.updateHandlePosition(this.minHandle, percentage);
    }

    /**
     * Handles maximum input field changes
     * @param {Event} e - Input event
     * @private
     */
    handleMaxInput(e) {
        const value = parseInt(e.target.value);
        if (isNaN(value)) return;

        if (value <= this.options.minNow) {
            e.target.classList.add('error');
            return;
        }

        e.target.classList.remove('error');
        const percentage = this.valueToPercentage(value);
        this.updateHandlePosition(this.maxHandle, percentage);
    }

    /**
     * Validates and normalizes input values on blur
     * @param {Event} e - Blur event
     * @private
     */
    validateInput(e) {
        if (e.target.value === '') {
            return;
        }

        const value = parseInt(e.target.value);
        const isMinInput = e.target === this.minInput;

        if (isNaN(value)) {
            e.target.value = isMinInput ? this.options.minNow : this.options.maxNow;
            return;
        }

        const clampedValue = Math.min(Math.max(value, this.options.min), this.options.max);
        e.target.value = clampedValue;

        const percentage = this.valueToPercentage(clampedValue);
        this.updateHandlePosition(isMinInput ? this.minHandle : this.maxHandle, percentage);
    }

    /**
     * Converts a value to its corresponding percentage position
     * @param {number} value - The value to convert
     * @returns {number} - The percentage position (0-100)
     * @private
     */
    valueToPercentage(value) {
        return ((value - this.options.min) / (this.options.max - this.options.min)) * 100;
    }

    /**
     * Converts a percentage position to its corresponding value
     * @param {number} percentage - The percentage to convert (0-100)
     * @returns {number} - The calculated value
     * @private
     */
    percentageToValue(percentage) {
        return Math.round((percentage / 100) * (this.options.max - this.options.min) + this.options.min);
    }

    /**
     * Initiates handle dragging
     * @param {MouseEvent|TouchEvent} e - The event object
     * @param {HTMLElement} handle - The handle element being dragged
     * @private
     */
    startDragging(e, handle) {
        if (e.type === 'mousedown' && e.button !== 0) return;
        e.preventDefault();
        this.isDragging = true;
        this.activeHandle = handle;
        handle.classList.add('dragging');
    }

    /**
     * Stops handle dragging
     * @private
     */
    stopDragging() {
        if (!this.isDragging) return;
        this.isDragging = false;
        this.activeHandle.classList.remove('dragging');
        this.activeHandle = null;
    }

    /**
     * Handles the dragging motion
     * @param {MouseEvent|TouchEvent} e - The event object
     * @private
     */
    drag(e) {
        if (!this.isDragging || !this.activeHandle) return;

        const clientX = e.type === 'touchmove' ? e.touches[0].clientX : e.clientX;
        const rect = this.element.getBoundingClientRect();
        const x = Math.max(0, Math.min(clientX - rect.left, rect.width));
        const percentage = (x / rect.width) * 100;

        this.updateHandlePosition(this.activeHandle, percentage);
    }

    /**
     * Handles clicks on the track
     * @param {MouseEvent} e - The click event
     * @private
     */
    handleTrackClick(e) {
        if (this.isDragging) return;

        const rect = this.element.getBoundingClientRect();
        const x = e.clientX - rect.left;
        const percentage = (x / rect.width) * 100;

        const minHandlePos = this.getHandlePosition(this.minHandle);
        const maxHandlePos = this.getHandlePosition(this.maxHandle);

        // Move the closest handle
        if (Math.abs(percentage - minHandlePos) < Math.abs(percentage - maxHandlePos)) {
            this.updateHandlePosition(this.minHandle, percentage);
        } else {
            this.updateHandlePosition(this.maxHandle, percentage);
        }
    }

    /**
     * Handles keyboard navigation
     * @param {KeyboardEvent} e - The keyboard event
     * @param {HTMLElement} handle - The handle being controlled
     * @private
     */
    handleKeyboard(e, handle) {
        const step = this.options.step;
        const isMinHandle = handle === this.minHandle;
        let newValue = isMinHandle ? this.options.minNow : this.options.maxNow;

        switch (e.key) {
            case 'ArrowRight':
            case 'ArrowUp':
                newValue = Math.min(isMinHandle ? this.options.maxNow : this.options.max, newValue + step);
                break;
            case 'ArrowLeft':
            case 'ArrowDown':
                newValue = Math.max(isMinHandle ? this.options.min : this.options.minNow, newValue - step);
                break;
            case 'Home':
                newValue = isMinHandle ? this.options.min : this.options.minNow;
                break;
            case 'End':
                newValue = isMinHandle ? this.options.maxNow : this.options.max;
                break;
            default:
                return;
        }

        e.preventDefault();
        const percentage = this.valueToPercentage(newValue);
        this.updateHandlePosition(handle, percentage);
    }

    /**
     * Updates the position of a handle and related state
     * @param {HTMLElement} handle - The handle to update
     * @param {number} percentage - The new position as a percentage
     * @private
     */
    updateHandlePosition(handle, percentage) {
        const isMinHandle = handle === this.minHandle;
        const value = Math.min(100, Math.max(0, percentage));
        const actualValue = this.percentageToValue(value);

        if (isMinHandle && actualValue >= this.options.maxNow) return;
        if (!isMinHandle && actualValue <= this.options.minNow) return;

        if (isMinHandle) {
            this.options.minNow = actualValue;
        } else {
            this.options.maxNow = actualValue;
        }

        this.updatePositions();
        this.updateAria();
        this.updateInputs();
        this.options.onChange(this.options.minNow, this.options.maxNow);
    }

    /**
     * Updates input field values
     * @private
     */
    updateInputs() {
        this.minInput.value = this.options.minNow;
        this.maxInput.value = this.options.maxNow;
    }

    /**
     * Updates visual positions of handles and track
     * @private
     */
    updatePositions() {
        const minPercentage = this.valueToPercentage(this.options.minNow);
        const maxPercentage = this.valueToPercentage(this.options.maxNow);

        this.minHandle.style.left = `${minPercentage}%`;
        this.maxHandle.style.left = `${maxPercentage}%`;
        this.track.style.left = `${minPercentage}%`;
        this.track.style.width = `${maxPercentage - minPercentage}%`;
    }

    /**
     * Gets the current position of a handle as a percentage
     * @param {HTMLElement} handle - The handle element
     * @returns {number} - The position as a percentage
     * @private
     */
    getHandlePosition(handle) {
        return parseFloat(handle.style.left) || 0;
    }

    /**
     * Updates ARIA attributes for accessibility
     * @private
     */
    updateAria() {
        this.minHandle.setAttribute('aria-valuenow', this.options.minNow.toString());
        this.maxHandle.setAttribute('aria-valuenow', this.options.maxNow.toString());
    }
}