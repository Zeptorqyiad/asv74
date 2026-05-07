(function () {
    'use strict';

    /**
     * Manages product compare buttons: toggles state, handles API calls, notifications, and accessibility.
     */
    class CompareButtonManager {
        /**
         * @param {string} selector - CSS selector for compare buttons
         * @param {number} [debounceDelay=300] - Delay for debouncing clicks (ms)
         */
        constructor(selector, debounceDelay = 300) {
            this.debounceDelay = debounceDelay;
            this.buttons = Array.from(document.querySelectorAll(selector));
            this.init();
        }

        /**
         * Initializes event listeners on all compare buttons.
         * @private
         */
        init() {
            this.buttons.forEach(btn => {
                const handler = this.debounce(() => this.toggleCompare(btn), this.debounceDelay);
                btn.addEventListener('click', handler);
            });
        }

        /**
         * Creates a debounced function that delays invocation until after delay.
         * @param {Function} fn - Function to debounce
         * @param {number} delay - Delay in milliseconds
         * @returns {Function}
         */
        debounce(fn, delay) {
            let timerId;
            return (...args) => {
                clearTimeout(timerId);
                timerId = setTimeout(() => fn.apply(this, args), delay);
            };
        }

        /**
         * Displays a notification via toastManager or fallback alert.
         * @param {string} message - Notification text
         * @param {string} [link] - Optional URL for toast link
         * @param {string} [type] - Optional toast type ('error' for errors)
         * @private
         */
        notify(message, link, type) {
            if (typeof toastManager !== 'undefined') {
                const options = {message};
                if (link) options.link = link;
                if (type) options.type = type;
                toastManager.show(options);
            } else {
                alert(message);
            }
        }

        /**
         * Toggles compare state for a button
         * updates UI only on success, reverts on error.
         * @param {HTMLElement} btn - Compare button element
         * @private
         */
        toggleCompare(btn) {
            const wasActive = btn.classList.contains('active');
            const {productId, variantId} = btn.dataset;
            const relatedButtons = this.buttons.filter(
                b => b.dataset.productId === productId
            );
            const action = wasActive ? 'remove' : 'add';

            btn.disabled = true;
            btn.classList.add('loading');

            const setQtyCompare = (operation) => {
                const btn = document.querySelector('.header__button-compare');

                if(!btn) return;

                let countEl = btn.querySelector('.btn-menu__badge');

                if(!countEl) {
                    countEl = document.createElement('span');
                    countEl.className = 'btn-menu__badge';
                    countEl.textContent = '1';
                    btn.insertAdjacentElement('afterbegin', countEl);
                    return;
                }

                let count = parseInt(countEl.textContent);

                switch (operation) {
                    case 'add':
                        count += 1;
                        break;
                    case 'reduce':
                        count -= 1;
                        break;
                }

                if(count === 0) {
                    countEl.remove();
                    return;
                }

                countEl.textContent = count;
            }

            const onSuccess = () => {
                const nowActive = !btn.classList.contains('active');

                relatedButtons.forEach(b => {
                    const tooltip = b.querySelector('.tooltip__content');
                    const textEl = b.querySelector('.compare-button__text');
                    b.classList.toggle('active', nowActive);
                    b.disabled = false;
                    b.classList.remove('loading');

                    if (nowActive) {
                        tooltip.textContent = 'Убрать из сравнения';
                        textEl.textContent = 'В сравнении';
                        b.setAttribute('aria-label', 'Убрать из сравнения');
                    } else {
                        tooltip.textContent = 'Добавить в сравнение';
                        textEl.textContent = 'В сравнение';
                        b.setAttribute('aria-label', 'Добавить в сравнение');
                    }
                });

                if (nowActive) {
                    this.notify('Добавлен к сравнению', '/compare/');
                    tracker.track('product_compare_add');
                    setQtyCompare('add');
                } else {
                    this.notify('Товар убран из сравнения');
                    tracker.track('product_compare_remove');
                    setQtyCompare('reduce');
                }
            };

            const onError = err => {
                console.error(`compare.${action} error:`, err);
                this.notify('Ошибка при обновлении сравнения', null, 'error');
                btn.disabled = false;
                btn.classList.remove('loading');
            };

            if (action === 'add') {
                window.api.compare.add(productId, variantId, onSuccess, onError);
            } else {
                window.api.compare.remove(productId, variantId, onSuccess, onError);
            }
        }
    }

    // Initialize
    new CompareButtonManager('.compare-button');
})();
