/**
 * Manages toast notifications.
 *
 * @class ToastManager
 *
 * @example
 * // Create an instance of ToastManager
 * const toastManager = new ToastManager();
 *
 * // Show a success toast:
 * toastManager.show({
 *   message: 'Operation completed successfully!',
 *   type: 'success',
 *   duration: 4000
 * });
 *
 * // Queue a toast for the next page load:
 * toastManager.queue({
 *   message: 'You have unsaved changes!',
 *   type: 'error',
 *   duration: 5000
 * });
 */
class ToastManager {
    /**
     * Creates a new instance of ToastManager.
     *
     * @param {string} [containerSelector='#toast-container'] - Selector for the toast container.
     * @param {string} [templateSelector='#toast-template'] - Selector for the toast template.
     */
    constructor(containerSelector = '#toast-container', templateSelector = '#toast-template') {
        this.container = document.querySelector(containerSelector);
        this.template = document.querySelector(templateSelector);
        if (!this.container) {
            throw new Error(`Toast container not found using selector: ${containerSelector}`);
        }
        if (!this.template) {
            throw new Error(`Toast template not found using selector: ${templateSelector}`);
        }

        // Display queued toasts from sessionStorage when DOM is ready
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', this.displayQueued.bind(this));
        } else {
            this.displayQueued();
        }
    }

    /**
     * Displays a toast notification.
     *
     * @param {Object} options - Toast options.
     * @param {string} options.message - The toast message.
     * @param {string} [options.link] - Optional URL for a link.
     * @param {string} [options.linkText='Перейти'] - Text for the link.
     * @param {string} [options.type='default'] - Type of toast ('default', 'success', 'error').
     * @param {number} [options.duration=3000] - Duration in milliseconds.
     *
     * @example
     * toastManager.show({
     *   message: 'Data saved successfully!',
     *   type: 'success',
     *   duration: 4000
     * });
     */
    show(options = {}) {
        const {
            message,
            link,
            linkText = 'Перейти',
            type = 'default',
            duration = 3000,
        } = options;

        // Clone the toast template
        const toastElement = this.template.content.firstElementChild.cloneNode(true);

        // For non-default types, add a modifier class like 'toast--error'
        if (type && type !== 'default') {
            toastElement.classList.add(`toast--${type}`);
        }

        // Set the message text
        const messageEl = toastElement.querySelector('.toast__message');
        if (messageEl) {
            messageEl.textContent = message;
        }

        // If a link is provided, create and append the anchor element
        if (link) {
            const linkEl = document.createElement('a');
            linkEl.href = link;
            linkEl.textContent = linkText;
            linkEl.classList.add('toast__link');
            const toastContent = toastElement.querySelector('.toast__content');
            if (toastContent) {
                toastContent.appendChild(linkEl);
            }
        }

        // Append the toast to the container
        this.container.appendChild(toastElement);

        // Set up the progress bar to indicate remaining time
        const progressEl = toastElement.querySelector('.toast__progress');
        if (progressEl) {
            progressEl.style.transition = `width ${duration}ms linear`;
            progressEl.style.width = '100%';
            setTimeout(() => {
                progressEl.style.width = '0%';
            }, 50);
        }

        // Force reflow and then add the 'show' class to trigger the slide-in animation
        void toastElement.offsetWidth;
        toastElement.classList.add('show');

        // Set up the close button
        const closeButton = toastElement.querySelector('.toast__close');
        if (closeButton) {
            closeButton.addEventListener('click', () => {
                this.hide(toastElement);
            });
        }

        // Store the timeout so it can be cleared if the toast is closed manually
        toastElement.hideTimeout = setTimeout(() => {
            this.hide(toastElement);
        }, duration);

        // Add swipe gesture handlers for this toast
        this._addSwipeHandlers(toastElement);
    }

    /**
     * Hides a toast with a slide-out animation and then removes it from the DOM.
     *
     * @param {HTMLElement} toast - The toast element to hide.
     *
     * @example
     * // Assuming 'toastEl' is a reference to a toast element:
     * toastManager.hide(toastEl);
     */
    hide(toast) {
        // Clear any pending auto-hide timeout
        if (toast.hideTimeout) {
            clearTimeout(toast.hideTimeout);
        }
        // Remove the 'show' class and force a reflow before adding the 'hide' class
        toast.classList.remove('show');
        void toast.offsetWidth;
        toast.classList.add('hide');

        // Remove the toast element once the transition ends
        toast.addEventListener('transitionend', () => {
            if (toast.parentElement) {
                toast.parentElement.removeChild(toast);
            }
        }, { once: true });
    }

    /**
     * Queues a toast for display on the next page load by saving it to sessionStorage.
     *
     * @param {Object} options - Toast options (same as for show).
     *
     * @example
     * toastManager.queue({
     *   message: 'Please sign in to continue.',
     *   type: 'error',
     *   duration: 5000
     * });
     */
    queue(options = {}) {
        const queuedToasts = JSON.parse(sessionStorage.getItem('pendingToasts')) || [];
        queuedToasts.push(options);
        sessionStorage.setItem('pendingToasts', JSON.stringify(queuedToasts));
    }

    /**
     * Displays any queued toasts from sessionStorage and then clears the queue.
     *
     * @example
     * // This is automatically called on page load.
     * toastManager.displayQueued();
     */
    displayQueued() {
        const queuedToasts = JSON.parse(sessionStorage.getItem('pendingToasts')) || [];
        queuedToasts.forEach(options => {
            this.show(options);
        });
        sessionStorage.removeItem('pendingToasts');
    }

    /**
     * Adds swipe gesture handlers to a toast element
     * Supports both touch and mouse interactions
     *
     * @param {HTMLElement} toast - The toast element
     * @private
     */
    _addSwipeHandlers(toast) {
        let startX = 0;
        let startY = 0;
        let currentX = 0;
        let isSwiping = false;
        const swipeThreshold = 80; // Minimum pixels to swipe for dismissal

        // Touch event handlers
        toast.addEventListener('touchstart', (e) => {
            startX = e.touches[0].clientX;
            startY = e.touches[0].clientY;
            currentX = startX;
            isSwiping = true;
            toast.style.transition = 'none';
        }, { passive: true });

        toast.addEventListener('touchmove', (e) => {
            if (!isSwiping) return;

            const touchX = e.touches[0].clientX;
            const touchY = e.touches[0].clientY;

            // Check if vertical scroll is greater than horizontal (prevent interfering with page scroll)
            const deltaX = Math.abs(touchX - startX);
            const deltaY = Math.abs(touchY - startY);

            if (deltaY > deltaX && deltaY > 10) {
                isSwiping = false;
                toast.style.transform = '';
                toast.style.transition = '';
                return;
            }

            currentX = touchX;
            const offsetX = currentX - startX;

            // Apply horizontal translation
            toast.style.transform = `translateX(${offsetX}px)`;

            // Change opacity based on swipe distance
            toast.style.opacity = Math.max(0.3, 1 - Math.abs(offsetX) / (swipeThreshold * 3));

            // Prevent default to avoid page scrolling while swiping
            e.preventDefault();
        });

        toast.addEventListener('touchend', () => {
            if (!isSwiping) return;
            handleSwipeEnd();
        });

        toast.addEventListener('touchcancel', () => {
            if (!isSwiping) return;
            handleSwipeEnd();
        });

        // Mouse event handlers
        toast.addEventListener('mousedown', (e) => {
            // Only handle left mouse button
            if (e.button !== 0) return;

            startX = e.clientX;
            startY = e.clientY;
            currentX = startX;
            isSwiping = true;
            toast.style.transition = 'none';

            // Prevent text selection during swipe
            e.preventDefault();
        });

        document.addEventListener('mousemove', (e) => {
            if (!isSwiping) return;

            const mouseX = e.clientX;
            const mouseY = e.clientY;

            // Check if vertical movement is greater than horizontal
            const deltaX = Math.abs(mouseX - startX);
            const deltaY = Math.abs(mouseY - startY);

            if (deltaY > deltaX && deltaY > 10) {
                isSwiping = false;
                toast.style.transform = '';
                toast.style.transition = '';
                return;
            }

            currentX = mouseX;
            const offsetX = currentX - startX;

            // Apply horizontal translation
            toast.style.transform = `translateX(${offsetX}px)`;

            // Optional: Change opacity based on swipe distance
            const opacity = Math.max(0.3, 1 - Math.abs(offsetX) / (swipeThreshold * 3));
            toast.style.opacity = opacity;
        });

        document.addEventListener('mouseup', () => {
            if (!isSwiping) return;
            handleSwipeEnd();
        });

        // Shared swipe end handler
        const handleSwipeEnd = () => {
            isSwiping = false;
            toast.style.transition = 'transform 0.6s ease, opacity 0.4s ease';

            const offsetX = currentX - startX;

            if (Math.abs(offsetX) >= swipeThreshold) {
                // Swipe completed - continue animation in the swipe direction
                const direction = offsetX > 0 ? 1 : -1;
                toast.style.transform = `translateX(${direction * window.innerWidth}px)`;
                toast.style.opacity = '0';

                // Hide toast after animation
                setTimeout(() => {
                    this.hide(toast);
                }, 300);
            } else {
                // Swipe not completed - restore position
                toast.style.transform = '';
                toast.style.opacity = '';
            }
        };
    }
}

// Create a ToastManager instance for use in the application
const toastManager = new ToastManager();