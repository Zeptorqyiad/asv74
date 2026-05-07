(function () {
    'use strict';

    /**
     * A map to store tooltip instances, keyed by their tooltip elements.
     * @type {Map<HTMLElement, Tooltip>}
     */
    const tooltipInstances = new Map();

    /**
     * Tracks the currently active tooltip instance.
     * @type {Tooltip|null}
     */
    let activeTooltip = null;

    /**
     * A shared ResizeObserver to monitor size changes of all tooltips.
     * Updates the position of visible tooltips when their size changes.
     * @type {ResizeObserver}
     */
    const resizeObserver = new ResizeObserver((entries) => {
        for (const entry of entries) {
            const instance = tooltipInstances.get(entry.target);
            if (instance && instance.tooltip.classList.contains("visible")) {
                instance.updatePosition();
            }
        }
    });

    /**
     * Event listener to update the position of all visible tooltips on window resize.
     */
    window.addEventListener("resize", () => {
        tooltipInstances.forEach((instance) => {
            if (instance.tooltip.classList.contains("visible")) {
                instance.updatePosition();
            }
        });
    });

    /**
     * Manages a single tooltip instance, handling its display and positioning.
     */
    class Tooltip {
        /**
         * Creates a new Tooltip instance.
         * @param {HTMLElement} element - The trigger element that activates the tooltip.
         */
        constructor(element) {
            this.trigger = element;
            this.tooltip = element.querySelector(".tooltip__content");
            if (!this.tooltip) {
                console.warn("Tooltip element not found in trigger:", element);
                return;
            }
            if (this.trigger.dataset.tooltip) {
                this.tooltip.textContent = this.trigger.dataset.tooltip;
            }
            this.defaultPosition = element.dataset.defaultPosition || "top";
            tooltipInstances.set(this.tooltip, this);
            resizeObserver.observe(this.tooltip);
            this.init();
        }

        /**
         * Initializes event listeners for showing and hiding the tooltip.
         */
        init() {
            // Mouse events
            this.trigger.addEventListener("mouseenter", () => this.show());
            this.trigger.addEventListener("mouseleave", () => this.hide());

            // Keyboard events
            this.trigger.addEventListener("focus", () => this.show());
            this.trigger.addEventListener("blur", () => this.hide());
            this.trigger.addEventListener("keydown", (e) => {
                if (e.key === "Escape") this.hide();
            });

            // Touch events for mobile
            this.trigger.addEventListener("touchstart", (e) => {
                e.preventDefault();
                if (this.tooltip.classList.contains("visible")) {
                    this.hide();
                } else {
                    this.show();
                    // Auto-hide after 3 seconds on mobile
                    setTimeout(() => this.hide(), 3000);
                }
            });

            // Close tooltip when tapping outside (mobile improvement)
            document.addEventListener("touchstart", (e) => {
                if (!this.trigger.contains(e.target) && this.tooltip.classList.contains("visible")) {
                    this.hide();
                }
            });
        }

        /**
         * Displays the tooltip, hiding any previously active tooltip.
         */
        show() {
            if (activeTooltip && activeTooltip !== this) {
                activeTooltip.hide();
            }
            this.tooltip.classList.add("visible");
            this.tooltip.setAttribute("aria-hidden", "false");
            this.updatePosition();
            activeTooltip = this;
        }

        /**
         * Hides the tooltip and clears the active tooltip if it’s this instance.
         */
        hide() {
            this.tooltip.classList.remove("visible");
            this.tooltip.setAttribute("aria-hidden", "true");
            if (activeTooltip === this) {
                activeTooltip = null;
            }
        }

        /**
         * Updates the tooltip's position based on the viewport and trigger location.
         */
        updatePosition() {
            const triggerRect = this.trigger.getBoundingClientRect();
            const tooltipRect = this.tooltip.getBoundingClientRect();
            const viewportWidth = window.innerWidth;
            const viewportHeight = window.innerHeight;

            const bestPosition = this.findBestPosition(
                triggerRect,
                tooltipRect,
                viewportWidth,
                viewportHeight
            );

            this.tooltip.dataset.position = bestPosition;
        }

        /**
         * Determines the best position for the tooltip based on available space.
         * @param {DOMRect} triggerRect - The bounding rectangle of the trigger element.
         * @param {DOMRect} tooltipRect - The bounding rectangle of the tooltip element.
         * @param {number} viewportWidth - The width of the viewport.
         * @param {number} viewportHeight - The height of the viewport.
         * @returns {string} The best position ("top", "bottom", "left", or "right").
         */
        findBestPosition(triggerRect, tooltipRect, viewportWidth, viewportHeight) {
            const spacing = parseInt(this.trigger.dataset.spacing, 10) || 8;
            const centerX = triggerRect.left + triggerRect.width / 2;
            const centerY = triggerRect.top + triggerRect.height / 2;

            const positions = {
                top: {
                    fits:
                        triggerRect.top > tooltipRect.height + spacing &&
                        centerX - tooltipRect.width / 2 > 0 &&
                        centerX + tooltipRect.width / 2 < viewportWidth,
                    priority: this.defaultPosition === "top" ? 0 : 1
                },
                bottom: {
                    fits:
                        viewportHeight - triggerRect.bottom > tooltipRect.height + spacing &&
                        centerX - tooltipRect.width / 2 > 0 &&
                        centerX + tooltipRect.width / 2 < viewportWidth,
                    priority: this.defaultPosition === "bottom" ? 0 : 2
                },
                left: {
                    fits:
                        triggerRect.left > tooltipRect.width + spacing &&
                        centerY - tooltipRect.height / 2 > 0 &&
                        centerY + tooltipRect.height / 2 < viewportHeight,
                    priority: this.defaultPosition === "left" ? 0 : 3
                },
                right: {
                    fits:
                        viewportWidth - triggerRect.right > tooltipRect.width + spacing &&
                        centerY - tooltipRect.height / 2 > 0 &&
                        centerY + tooltipRect.height / 2 < viewportHeight,
                    priority: this.defaultPosition === "right" ? 0 : 4
                }
            };

            const fittingPositions = Object.entries(positions)
                .filter(([_, data]) => data.fits)
                .sort((a, b) => a[1].priority - b[1].priority);

            return fittingPositions.length > 0 ? fittingPositions[0][0] : "top";
        }
    }

    /**
     * Initializes tooltips for all elements with the class "tooltip".
     */
    document.querySelectorAll(".tooltip").forEach((trigger) => new Tooltip(trigger));
})();