let debounceSimple;

//!===========================================================
//! DEFAULT INITS
//!===========================================================
Fancybox.bind("[data-fancybox]", {
    Html : {
        videoTpl: '<video class="fancybox__html5video" playsinline controls muted controlsList="nodownload" poster="{{poster}}"><source src="{{src}}" type="{{format}}" />Sorry, your browser doesn\'t support embedded videos.</video>'
    }
});
window.dataLayer = window.dataLayer || [];

//!===========================================================
//! API CLIENT
//!===========================================================
/**
 * Global API client for frontend-to-backend calls.
 * Uses callback signature: `(params…, onSuccess, onError)`.
 * @namespace window.api
 */
window.api = {
    /**
     * Search-related endpoints.
     * @namespace window.api.search
     */
    search: {
        /**
         * Fetch city suggestions.
         * @param {string} q - Query string
         * @param {Function} onSuccess - Called with parsed JSON on 2xx
         * @param {Function} [onError] - Called on network/error
         */
        city(q, onSuccess, onError) {
            fetch(`/qs/?a=city&q=${encodeURIComponent(q)}`, {
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
            })
                .then(resp => {
                    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
                    return resp.json();
                })
                .then(onSuccess)
                .catch(err => {
                    console.error('search.city error:', err);
                    onError && onError(err);
                });
        },

        /**
         * Fetch product suggestions.
         * @param {string} q
         * @param {Function} onSuccess
         * @param {Function} [onError]
         */
        products(q, onSuccess, onError) {
            fetch(`/qs/?a=products&q=${encodeURIComponent(q)}`, {
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
            })
                .then(resp => {
                    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
                    return resp.json();
                })
                .then(onSuccess)
                .catch(err => {
                    console.error('search.products error:', err);
                    onError && onError(err);
                });
        },
    },

    /**
     * Feedback submission endpoints.
     * @namespace window.api.feedback
     */
    feedback: {
        /**
         * Submit blog feedback.
         * @param {FormData} fd
         * @param {Function} onSuccess - Called with parsed JSON on 2xx
         * @param {Function} [onError]
         */
        blog(fd, onSuccess, onError) {
            fetch('/blog/', {
                method: 'POST',
                body: fd,
            })
                .then(resp => {
                    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
                    return resp.json();
                })
                .then(onSuccess)
                .catch(err => {
                    console.error('feedback.blog error:', err);
                    onError && onError(err);
                });
        },

        /**
         * Submit a review.
         * @param {FormData} fd
         * @param {Function} onSuccess
         * @param {Function} [onError]
         */
        reviews(fd, onSuccess, onError) {
            fetch('/reviews/', {
                method: 'POST',
                body: fd,
            })
                .then(resp => {
                    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
                    return resp.json();
                })
                .then(onSuccess)
                .catch(err => {
                    console.error('feedback.reviews error:', err);
                    onError && onError(err);
                });
        },
    },

    /**
     * Product comparison endpoints.
     * @namespace window.api.compare
     */
    compare: {
        /**
         * Add a product to compare.
         * @param {number|string} id
         * @param {number|string} variant
         * @param {Function} onSuccess - Called with server response text/JSON on 2xx
         * @param {Function} [onError]
         */
        add(id, variant, onSuccess, onError) {
            fetch(`/compare/?action=add&id=${encodeURIComponent(id)}&variant=${encodeURIComponent(variant)}`, {
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
            })
                .then(resp => {
                    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
                    return resp.text();
                })
                .then(onSuccess)
                .catch(err => {
                    console.error('compare.add error:', err);
                    onError && onError(err);
                });
        },

        /**
         * Remove a product from compare.
         * @param {number|string} id
         * @param {number|string} variant
         * @param {Function} onSuccess
         * @param {Function} [onError]
         */
        remove(id, variant, onSuccess, onError) {
            fetch(`/compare/?action=remove&id=${encodeURIComponent(id)}&variant=${encodeURIComponent(variant)}`, {
                headers: { 'X-Requested-With': 'XMLHttpRequest' },
            })
                .then(resp => {
                    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
                    return resp.text();
                })
                .then(onSuccess)
                .catch(err => {
                    console.error('compare.remove error:', err);
                    onError && onError(err);
                });
        },
    },

    catalog: {
        count: function (fd, callback) {
            let str = (window.location.origin + window.location.pathname).toString();
            if (str.includes('?')) {
                str += '&';
            } else {
                str += '?';
            }

            fetch(str + 'action=count', {
                method: 'POST',
                body: fd,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            }).then(res => res.text()).then(response => {
                if (callback) {
                    callback(response);
                }
            });
        },
    }
};

//!===========================================================
//! YANDEX METRIKA TRACKER
//!===========================================================
/**
 * A class to interact with Yandex Metrika for tracking events.
 * It automatically detects the Yandex Metrika counter ID from the page
 * or uses a default if not found.
 * @example tracker.track('event_name');
 * @class
 */
class YandexMetrikaTracker {
    /**
     * Private property to store the cached counter ID.
     * @private
     * @type {string|null}
     */
    #counterId = null;

    /**
     * The default counter ID to use if no ID is found on the page.
     * This can be overridden by the user.
     * @public
     * @type {string}
     */
    defaultCounterId = '101391549';

    /**
     * Flag to enable or disable logging.
     * Set to `false` to suppress console logs.
     * @public
     * @type {boolean}
     */
    enableLogging = true;

    /**
     * Internal method to log messages conditionally based on `enableLogging`.
     * @private
     * @param {string} level - The console log level (e.g., 'warn', 'error').
     * @param {string} message - The message to log.
     * @param {...any} args - Additional arguments to log.
     */
    #log(level, message, ...args) {
        if (this.enableLogging) {
            console[level](message, ...args);
        }
    }

    /**
     * Retrieves or finds the Yandex Metrika counter ID.
     * It first checks if the ID is already cached. If not, it attempts to find it
     * from the page's `<noscript>` or `<script>` tags. If still not found, it uses
     * the `defaultCounterId`.
     *
     * @public
     * @returns {string} The Yandex Metrika counter ID.
     */
    findCounterId() {
        if (this.#counterId) {
            return this.#counterId;
        }
        this.#counterId = this.#findIdFromNoscript() || this.#findIdFromScripts();
        if (!this.#counterId) {
            this.#log('warn', `[Yandex Metrika] Counter ID not found. Using default ID ${this.defaultCounterId}.`);
            this.#counterId = this.defaultCounterId;
        }
        return this.#counterId;
    }

    /**
     * Searches for the counter ID in `<noscript>` tags containing Yandex Metrika image URLs.
     * @private
     * @returns {string|null} The counter ID if found, otherwise null.
     */
    #findIdFromNoscript() {
        const noscriptImg = document.querySelector('noscript img[src*="mc.yandex.ru/watch/"]');
        if (noscriptImg) {
            const match = noscriptImg.src.match(/watch\/(\d+)/);
            return match ? match[1] : null;
        }
        return null;
    }

    /**
     * Searches for the counter ID in `<script>` tags that initialize Yandex Metrika.
     * Looks for patterns like `ym(counterId, "init")`.
     * @private
     * @returns {string|null} The counter ID if found, otherwise null.
     */
    #findIdFromScripts() {
        const scripts = document.querySelectorAll('script');
        for (const script of scripts) {
            const content = script.textContent || script.innerText;
            if (content.includes('ym(') && content.includes('"init"')) {
                const match = content.match(/ym\((\d+),\s*"init"/);
                if (match) {
                    return match[1];
                }
            }
        }
        return null;
    }

    /**
     * Tracks an event using Yandex Metrika's `reachGoal` method.
     * It ensures the `ym` function is available and uses the counter ID to track the event.
     *
     * @public
     * @param {string} eventName - The name of the event to track.
     * @returns {boolean} True if the event was successfully tracked, false otherwise.
     */
    track(eventName) {
        try {
            if (typeof window === 'undefined' || typeof window.ym !== 'function') {
                this.#log('error', '[Yandex Metrika] ym function is not available.');
                return false;
            }
            const counterId = this.findCounterId();
            window.ym(counterId, 'reachGoal', eventName);
            this.#log('warn', `Event '${eventName}' tracked with counter ID ${counterId}.`);
            return true;
        } catch (error) {
            this.#log('error', '[Yandex Metrika] Error tracking event:', error);
            return false;
        }
    }
}

const tracker = new YandexMetrikaTracker();

//!===========================================================
//! YANDEX ECOMMERCE METRIKA TRACKER
//!===========================================================
/**
 * A class to interact with Yandex Ecommerce for detailed product tracking.
 * @class
 */
class YandexEcommerceTracker {
    /**
     * The name of the data layer used for ecommerce tracking.
     * @type {string}
     */
    #dataLayerName;

    /**
     * Flag to enable or disable logging.
     * Set to `false` to suppress console logs.
     * @public
     * @type {boolean}
     */
    enableLogging = true;

    /**
     * Constructor for YandexEcommerceTracker.
     * @param {string} [dataLayerName='dataLayer'] - The name of the data layer for ecommerce tracking.
     */
    constructor(dataLayerName = 'dataLayer') {
        this.#dataLayerName = dataLayerName;

        if (!window[this.#dataLayerName]) {
            window[this.#dataLayerName] = [];
        }
    }

    /**
     * Internal method to log messages conditionally based on `enableLogging`.
     * @private
     * @param {string} level - The console log level (e.g., 'warn', 'error').
     * @param {string} message - The message to log.
     * @param {...any} args - Additional arguments to log.
     */
    #log(level, message, ...args) {
        if (this.enableLogging) {
            console[level](message, ...args);
        }
    }

    /**
     * Pushes an object to the data layer.
     * @private
     * @param {object} obj - The object to push to the data layer.
     */
    #pushToDataLayer(obj) {
        window[this.#dataLayerName].push(obj);
    }

    /**
     * Formats a product object for ecommerce tracking.
     * @private
     * @param {object} product - The raw product object.
     * @returns {object} A formatted product object.
     */
    #formatProduct(product) {
        return {
            id: product.id,
            name: product.name,
            price: product.price,
            brand: product.brand,
            category: product.category,
            variant: product.variant,
            list: product.list,
            position: product.position,
            quantity: product.quantity
        };
    }

    /**
     * Formats a promotion object for ecommerce tracking.
     * @private
     * @param {object} promotion - The raw promotion object.
     * @returns {object} A formatted promotion object.
     */
    #formatPromotion(promotion) {
        return {
            id: promotion.id,
            name: promotion.name,
            creative: promotion.creative,
            position: promotion.position
        };
    }

    /**
     * Tracks the viewing of a list of products (Просмотр списка товаров).
     * @param {string} currency - The currency code (e.g., 'RUB').
     * @param {object[]} products - Array of product objects.
     */
    trackImpressions(currency, products) {
        const formattedProducts = products.map(product => this.#formatProduct(product));
        const ecommerceObject = {
            ecommerce: {
                currencyCode: currency,
                impressions: formattedProducts
            }
        };
        this.#log('warn', `Event 'impressions' tracked for ${formattedProducts.length} product(s).`);
        this.#pushToDataLayer(ecommerceObject);
    }

    /**
     * Tracks a click on a product from a list (Клик по товару из списка).
     * @param {string} currency - The currency code (e.g., 'RUB').
     * @param {object} product - The product object.
     */
    trackClick(currency, product) {
        const formattedProduct = this.#formatProduct(product);
        const ecommerceObject = {
            ecommerce: {
                currencyCode: currency,
                click: {
                    products: [formattedProduct]
                }
            }
        };
        this.#log('warn', `Event 'click' tracked for ${formattedProduct.name}.`);
        this.#pushToDataLayer(ecommerceObject);
    }

    /**
     * Tracks the viewing of a product's details (Просмотр товара).
     * @param {string} currency - The currency code (e.g., 'RUB').
     * @param {object} product - The product object.
     */
    trackDetail(currency, product) {
        const formattedProduct = this.#formatProduct(product);
        const ecommerceObject = {
            ecommerce: {
                currencyCode: currency,
                detail: {
                    products: [formattedProduct]
                }
            }
        };
        this.#log('warn', `Event 'detail' tracked for ${formattedProduct.name}.`);
        this.#pushToDataLayer(ecommerceObject);
    }

    /**
     * Tracks adding a product to the cart (Добавление товара в корзину).
     * @param {string} currency - The currency code (e.g., 'RUB').
     * @param {object} product - The product object.
     * @param {number} [quantity=1] - The quantity added to the cart.
     */
    trackAddToCart(currency, product, quantity = 1) {
        const formattedProduct = this.#formatProduct(product);
        formattedProduct.quantity = quantity;
        const ecommerceObject = {
            ecommerce: {
                currencyCode: currency,
                add: {
                    products: [formattedProduct]
                }
            }
        };
        this.#log('warn', `Event 'add to cart' tracked for ${formattedProduct.name} with quantity ${formattedProduct.quantity}.`);
        this.#pushToDataLayer(ecommerceObject);
    }

    /**
     * Tracks removing a product from the cart (Удаление товара из корзины).
     * @param {string} currency - The currency code (e.g., 'RUB').
     * @param {object} product - The product object.
     * @param {number} [quantity=1] - The quantity removed from the cart.
     */
    trackRemoveFromCart(currency, product, quantity = 1) {
        const formattedProduct = this.#formatProduct(product);
        formattedProduct.quantity = quantity;
        const ecommerceObject = {
            ecommerce: {
                currencyCode: currency,
                remove: {
                    products: [formattedProduct]
                }
            }
        };
        this.#log('warn', `Event 'remove from cart' tracked for ${formattedProduct.name} with quantity ${formattedProduct.quantity}.`);
        this.#pushToDataLayer(ecommerceObject);
    }

    /**
     * Tracks a completed purchase (Покупка).
     * @param {string} currency - The currency code (e.g., 'RUB').
     * @param {object} transaction - Transaction details (e.g., id).
     * @param {object[]} products - Array of products in the purchase.
     */
    trackPurchase(currency, transaction, products) {
        const formattedProducts = products.map(product => this.#formatProduct(product));
        const ecommerceObject = {
            ecommerce: {
                currencyCode: currency,
                purchase: {
                    actionField: {
                        id: transaction.id
                    },
                    products: formattedProducts
                }
            }
        };
        this.#log('warn', `Event 'purchase' tracked for transaction ID ${transaction.id}.`);
        this.#pushToDataLayer(ecommerceObject);
    }

    /**
     * Tracks the viewing of internal advertisements (Просмотр внутренней рекламы).
     * @param {object[]} promotions - Array of promotion objects.
     */
    trackPromoView(promotions) {
        const formattedPromotions = promotions.map(promotion => this.#formatPromotion(promotion));
        const ecommerceObject = {
            ecommerce: {
                promoView: {
                    promotions: formattedPromotions
                }
            }
        };
        this.#log('warn', `Event 'promo view' tracked for ${formattedPromotions.length} promotion(s).`);
        this.#pushToDataLayer(ecommerceObject);
    }

    /**
     * Tracks clicks on internal advertisements (Клики внутренней рекламы).
     * @param {object} promotion - The promotion object.
     */
    trackPromoClick(promotion) {
        const formattedPromotion = this.#formatPromotion(promotion);
        const ecommerceObject = {
            ecommerce: {
                promoClick: {
                    promotions: [formattedPromotion]
                }
            }
        };
        this.#log('warn', `Event 'promo click' tracked for ${formattedPromotion.name}.`);
        this.#pushToDataLayer(ecommerceObject);
    }
}

const ecom = new YandexEcommerceTracker('dataLayer');

//!===========================================================
//! MODAL MANAGER
//!===========================================================
/**
 * Class representing a single modal dialog.
 */
class Modal {
    /**
     * Create a modal instance.
     * @param {string} id - The ID of the modal element in the DOM.
     */
    constructor(id) {
        this.id = id;
        this.modalContent = document.getElementById(id);
        if (!this.modalContent) {
            console.error(`Modal content element not found for id: ${id}`);
            return;
        }
        this.isClosing = false;

        // Bind the transition end handler to this instance.
        this.handleTransitionEnd = this.handleTransitionEnd.bind(this);
        this.modalContent.addEventListener('transitionend', this.handleTransitionEnd);
    }

    /**
     * Opens the modal by displaying it and triggering the CSS transition.
     */
    open() {
        if (!this.modalContent) return;
        this.modalContent.style.display = 'block';
        requestAnimationFrame(() => {
            requestAnimationFrame(() => {
                this.modalContent.classList.add('active');
            });
        });
    }

    /**
     * Closes the modal by triggering the CSS transition to fade it out.
     */
    close() {
        if (!this.modalContent || this.isClosing) return;
        this.isClosing = true;
        // Remove the active class to trigger the fade-out transition.
        this.modalContent.classList.remove('active');
    }

    /**
     * Handles the transition end event.
     * Once the modal has finished fading out, it hides the element.
     * @param {TransitionEvent} e - The transition end event.
     */
    handleTransitionEnd(e) {
        if (e.target !== this.modalContent) return;
        if (this.isClosing && !this.modalContent.classList.contains('active')) {
            this.modalContent.style.display = 'none';
            this.isClosing = false;
        }
    }
}

/**
 * Class to manage multiple modals with a common overlay.
 * When opening a new modal while another is open, the current modal closes first,
 * then the new one opens automatically.
 */
class ModalManager {
    constructor() {
        /** @type {Map<string, Modal>} */
        this.modals = new Map();
        /** @type {Modal|null} */
        this.currentModal = null;
        /** @type {string|null} */
        this.queuedModalId = null;
        /** @type {Object|null} */
        this.queuedData = null;

        // Look for the common overlay element. Create it if it doesn’t exist.
        this.overlay = document.getElementById('modal-overlay');
        if (!this.overlay) {
            this.overlay = document.createElement('div');
            this.overlay.id = 'modal-overlay';
            this.overlay.className = 'modal-overlay';
            this.overlay.style.display = 'none';
            document.body.appendChild(this.overlay);
        }

        // Bind event handlers.
        this.handleOverlayTransitionEnd = this.handleOverlayTransitionEnd.bind(this);
        this.handleKeyDown = this.handleKeyDown.bind(this);

        this.overlay.addEventListener('transitionend', this.handleOverlayTransitionEnd);
        this.overlay.addEventListener('click', () => {
            if (this.currentModal) {
                this.close(this.currentModal.id);
            }
        });
        document.addEventListener('keydown', this.handleKeyDown);
    }

    /**
     * Registers a modal with the given ID if not already registered.
     * @param {string} id - The ID of the modal element.
     */
    registerModal(id) {
        if (!this.modals.has(id)) {
            const modal = new Modal(id);
            if (modal.modalContent) {
                this.modals.set(id, modal);
            }
        }
    }

    /**
     * Opens the modal with the specified ID and passes the provided data.
     * @param {string} id - The ID of the modal to open.
     * @param {Object} [data={}] - The dataset to pass to the modal.
     */
    open(id, data = {}) {
        if (this.currentModal && this.currentModal.id !== id) {
            this.queuedModalId = id;
            this.queuedData = data;
            this.close(this.currentModal.id);
            return;
        }
        this.registerModal(id);
        const modal = this.modals.get(id);
        if (!modal) return;

        this.currentModal = modal;

        // Dispatch custom event with the data
        if (modal.modalContent) {
            modal.modalContent.dispatchEvent(new CustomEvent('modalopen', {detail: data}));
        }

        // Show and animate the overlay
        this.overlay.style.display = 'block';
        requestAnimationFrame(() => {
            requestAnimationFrame(() => {
                this.overlay.classList.add('active');
            });
        });

        const scrollEl = document.scrollingElement || document.documentElement;
        scrollEl.style.overflow = 'hidden';
        modal.open();
    }

    /**
     * Closes the modal with the specified ID.
     * @param {string} id - The ID of the modal to close.
     */
    close(id) {
        const modal = this.modals.get(id);
        if (!modal) return;

        modal.close();

        if (!this.queuedModalId) {
            this.overlay.classList.remove('active');
            const scrollEl = document.scrollingElement || document.documentElement;
            scrollEl.style.overflow = '';
        }
        this.currentModal = null;

        const transitionDuration = parseFloat(getComputedStyle(modal.modalContent).transitionDuration) * 1000;
        setTimeout(() => {
            if (this.queuedModalId) {
                const queuedId = this.queuedModalId;
                const queuedData = this.queuedData || {};
                this.queuedModalId = null;
                this.queuedData = null;
                this.open(queuedId, queuedData);
            }
        }, transitionDuration || 300);
    }

    /**
     * Handles the overlay’s transition end event.
     * @param {TransitionEvent} e - The transition end event.
     */
    handleOverlayTransitionEnd(e) {
        if (e.target !== this.overlay) return;
        if (!this.overlay.classList.contains('active')) {
            this.overlay.style.display = 'none';
        }
    }

    /**
     * Handles keydown events.
     * @param {KeyboardEvent} e - The keydown event.
     */
    handleKeyDown(e) {
        if (e.key === 'Escape' && this.currentModal) {
            this.close(this.currentModal.id);
        }
    }
}

// Expose the modalManager globally.
window.modalManager = new ModalManager();

//!===========================================================
//! SWIPER MANAGER
//!===========================================================
/**
 * @class SwiperManager
 * @classdesc Manages Swiper.js slider instances with a singleton pattern.
 * Provides centralized control for creating, retrieving, updating, and destroying Swiper instances.
 * Maintains a registry of all Swiper instances and applies default configuration.
 *
 * @example
 * // Create a new Swiper instance with custom config
 * swiperManager.create('.swiper-container', {
 *   direction: 'vertical',
 *   pagination: { el: '.swiper-pagination' }
 * });
 */
class SwiperManager {
    /**
     * @constructor
     * @description Initializes a new SwiperManager with default configuration.
     * Creates an empty Map to track Swiper instances.
     */
    constructor() {
        /**
         * @member {Map} instances
         * @description Map storing active Swiper instances with CSS selectors as keys
         * @memberof SwiperManager
         */
        this.instances = new Map();
        this.defaultConfig = {
            direction: 'horizontal',
            loop: true,
            grabCursor: true,
            threshold: 5,
            lazy: true,
        };
    }

    /**
     * @method create
     * @description Creates a new Swiper instance or returns existing one
     * @param {string|HTMLElement} selector - CSS selector or DOM element
     * @param {Object} [customConfig={}] - Custom Swiper configuration
     * @returns {Swiper} Created or existing Swiper instance
     * @throws {Error} If Swiper library is not loaded
     */
    create(selector, customConfig = {}) {
        if (this.instances.has(selector)) {
            console.warn(`Swiper instance for ${selector} already exists`);
            return this.instances.get(selector);
        }

        const config = {
            ...this.defaultConfig,
            ...customConfig
        };

        const instance = new Swiper(selector, config);
        this.instances.set(selector, instance);

        return instance;
    }

    /**
     * @method get
     * @description Retrieves a Swiper instance by selector
     * @param {string} selector - Original CSS selector used for creation
     * @returns {Swiper|null} Found Swiper instance or null
     */
    get(selector) {
        return this.instances.get(selector);
    }

    /**
     * @method destroy
     * @description Destroys a Swiper instance and removes from registry
     * @param {string} selector - CSS selector used during creation
     */
    destroy(selector) {
        const instance = this.instances.get(selector);
        if (instance) {
            instance.destroy(true, true);
            this.instances.delete(selector);
        }
    }

    /**
     * @method destroyAll
     * @description Destroys all managed Swiper instances and clears registry
     */
    destroyAll() {
        this.instances.forEach((instance, selector) => {
            this.destroy(selector);
        });
    }

    /**
     * @method update
     * @description Updates an existing Swiper instance with new configuration
     * @param {string} selector - CSS selector of instance to update
     * @param {Object} [newConfig={}] - New configuration to merge
     * @returns {Swiper|null} Recreated instance or null if not found
     */
    update(selector, newConfig = {}) {
        const instance = this.instances.get(selector);
        if (!instance) return null;

        this.destroy(selector);
        return this.create(selector, {...instance.params, ...newConfig});
    }
}

/**
 * @global
 * @type {SwiperManager}
 * @description Singleton instance of SwiperManager for application-wide use
 */
const swiperManager = new SwiperManager();

//!===========================================================
//! SCROLL CLASS HANDLER
//!===========================================================
/**
 * Handles adding/removing classes to elements based on scroll direction with throttling
 * @class
 */
class ScrollClassHandler {
    constructor(options = {}) {
        this.options = {
            element: options.element || '.header',
            className: options.className || 'hidden',
            margin: options.margin || 50,
            throttleDelay: options.throttleDelay || 100
        };
        this.lastScrollY = window.scrollY;
        this.ticking = false;
        this.init();
    }

    /**
     * Initialize the scroll handler
     * @private
     */
    init() {
        this.element = document.querySelector(this.options.element);
        if (!this.element) return;
        window.addEventListener('scroll', this.throttle(this.handleScroll.bind(this)));
    }

    /**
     * Handle scroll events and toggle class based on scroll direction
     * @private
     */
    handleScroll = () => {
        const currentScrollY = window.scrollY;
        if (Math.abs(currentScrollY - this.lastScrollY) < this.options.margin) {
            this.ticking = false;
            return;
        }

        if (currentScrollY > this.lastScrollY) {
            this.element.classList.add(this.options.className);
        } else {
            this.element.classList.remove(this.options.className);
        }

        this.lastScrollY = currentScrollY;
        this.ticking = false;
    }

    /**
     * Throttle function to limit scroll event frequency
     * @param {Function} callback - Function to throttle
     * @returns {Function} Throttled function
     * @private
     */
    throttle(callback) {
        return () => {
            if (this.ticking) return;
            this.ticking = true;
            requestAnimationFrame(callback);
        };
    }

    /**
     * Clean up event listeners
     * @public
     */
    destroy() {
        window.removeEventListener('scroll', this.handleScroll);
    }
}

//!===========================================================
//! STICKY OBSERVER
//!===========================================================
/**
 * Detects when elements become sticky during scroll.
 * -- Add manually position: relative; to parent element
 */
class StickyObserver {
    /**
     * @param {Object} options - Configuration options
     * @param {number} [options.threshold=0] - Intersection threshold
     * @param {string} [options.stickyClass='is-sticky'] - CSS class for sticky state
     */
    constructor(options = {}) {
        this.threshold = options.threshold || 0;
        this.stickyClass = options.stickyClass || 'is-sticky';
        this.observers = new Map();
        this.options = {passive: true};
    }

    /**
     * Start observing an element for sticky state changes.
     * @param {HTMLElement} element - The sticky element to observe
     * @param {HTMLElement} [container=element.parentElement] - The container element
     * @returns {StickyObserver} - This instance
     */
    observe(element, container = element.parentElement) {
        if (this.observers.has(element)) return this;

        // Get computed sticky top value
        const computedStyle = window.getComputedStyle(element);
        const stickyTop = parseInt(computedStyle.top) || 0;

        // Create sentinel element at exact sticky trigger position
        const sentinel = document.createElement('div');
        sentinel.style.cssText = 'position:absolute;height:1px;width:1px;pointer-events:none;opacity:0;';
        sentinel.style.top = `${stickyTop}px`;
        container.prepend(sentinel);

        // Create observer with root margin matching sticky top
        const observer = new IntersectionObserver(
            ([entry]) => {
                const isSticky = !entry.isIntersecting;
                element.classList.toggle(this.stickyClass, isSticky);
                element.dispatchEvent(new CustomEvent('stickyChange', {
                    detail: {isSticky}
                }));
            },
            {
                threshold: this.threshold,
                rootMargin: `-${stickyTop}px 0px 0px 0px`
            }
        );

        observer.observe(sentinel);
        this.observers.set(element, {observer, sentinel});

        return this;
    }

    /**
     * Stop observing an element.
     * @param {HTMLElement} element - The element to stop observing
     * @returns {StickyObserver} - This instance
     */
    unobserve(element) {
        const data = this.observers.get(element);
        if (!data) return this;

        data.observer.disconnect();
        data.sentinel.remove();
        this.observers.delete(element);

        return this;
    }

    /**
     * Clean up all observers and references.
     * @returns {StickyObserver} - This instance
     */
    destroy() {
        this.observers.forEach((_, element) => this.unobserve(element));
        return this;
    }
}

const sticky = new StickyObserver();

//!===========================================================
//! SCROLL TRIGGER
//!===========================================================
/**
 * ScrollTrigger class - Adds/removes class on target when scrolling past trigger
 */
class ScrollTrigger {
    /**
     * Create a new scroll trigger
     * @param {string|Element} target - Target element or selector to add/remove class
     * @param {string|Element} trigger - Trigger element or selector to watch
     * @param {string} className - Class name to toggle
     * @param {Object} [options] - Additional options
     * @param {number} [options.offset=0] - Offset in pixels
     * @param {boolean} [options.removeOnReverse=true] - Remove class when scrolling back up
     */
    constructor(target, trigger, className, options = {}) {
        // Default options
        this.config = {
            offset: 0,
            removeOnReverse: true,
            ...options
        };

        // Store class name
        this.className = className;

        // Convert selectors to elements if needed
        this.targetEl = typeof target === 'string' ? document.querySelector(target) : target;
        this.triggerEl = typeof trigger === 'string' ? document.querySelector(trigger) : trigger;

        // State tracking
        this.lastScrollPosition = window.scrollY;
        this.isClassApplied = false;

        // Bind the scroll handler to this instance
        this.handleScroll = this.throttle(this._handleScroll.bind(this), 100);

        // Validate elements before initialization
        if (!this.targetEl || !this.triggerEl) {
            console.error('Invalid target or trigger element');
            return;
        }

        // Initialize
        this.init();
    }

    /**
     * Initialize the scroll trigger
     */
    init() {
        window.addEventListener('scroll', this.handleScroll, { passive: true });
        // Initial check
        this.handleScroll();
    }

    /**
     * Clean up event listeners
     */
    destroy() {
        window.removeEventListener('scroll', this.handleScroll);
    }

    /**
     * Throttle function to limit scroll event calls
     */
    throttle(fn, delay) {
        let last = 0;
        return function(...args) {
            const now = Date.now();
            if (now - last < delay) return;
            last = now;
            return fn(...args);
        };
    }

    /**
     * Handle scroll event
     */
    _handleScroll() {
        const scrollPos = window.scrollY;
        const triggerPosition = this.triggerEl.getBoundingClientRect().top + window.scrollY;
        const scrollDirection = scrollPos > this.lastScrollPosition ? 'down' : 'up';
        this.lastScrollPosition = scrollPos;

        // Check if we've scrolled past trigger point (including offset)
        if (scrollPos >= triggerPosition - this.config.offset) {
            if (!this.isClassApplied) {
                this.targetEl.classList.add(this.className);
                this.isClassApplied = true;
            }
        } else if (this.config.removeOnReverse && this.isClassApplied) {
            this.targetEl.classList.remove(this.className);
            this.isClassApplied = false;
        }
    }
}


//!===========================================================
//! TAB SWITCHING MANAGER
//!===========================================================
/**
 * TabManager - Manages tab interfaces with configurable selectors and behavior
 * @class
 */
class TabManager {
    /**
     * Creates a new tab manager instance
     * @param {Object} options - Configuration options
     * @param {string} [options.tabListSelector='.sheet__tab-list'] - Selector for the tab container
     * @param {string} [options.tabSelector='.tab-list__tab'] - Selector for individual tabs
     * @param {string} [options.contentListSelector='.sheet__cat-list'] - Selector for content panels
     * @param {string} [options.dataAttribute='data-category'] - Data attribute used for tab-content matching
     * @param {string} [options.activeClass='active'] - Class applied to active elements
     */
    constructor(options = {}) {
        // Default selectors
        const defaults = {
            tabListSelector: '.sheet__tab-list',
            tabSelector: '.tab-list__tab',
            contentListSelector: '.sheet__cat-list',
            dataAttribute: 'data-category',
            activeClass: 'active'
        };

        // Merge defaults with user options
        this.config = {...defaults, ...options};

        // Element references
        this.tabList = document.querySelector(this.config.tabListSelector);
        if (!this.tabList) return;

        this.tabs = Array.from(this.tabList.querySelectorAll(this.config.tabSelector));
        this.contentLists = document.querySelectorAll(this.config.contentListSelector);

        if (!this.tabs.length) {
            console.warn(`[TabManager] No tabs found for selector ${this.config.tabSelector}`);
            return;
        }

        this.init();
    }

    /**
     * Initialize tab functionality
     * @private
     */
    init() {
        // Store bound handler for proper removal later
        this.boundClickHandler = this.handleTabClick.bind(this);

        // Set up event delegation
        this.tabList.addEventListener('click', this.boundClickHandler);

        // Activate first tab by default
        const firstTabCategory = this.tabs[0]?.getAttribute(this.config.dataAttribute);
        if (firstTabCategory) this.activateTab(firstTabCategory);
    }

    /**
     * Handle tab click events
     * @param {Event} event - Click event object
     * @private
     */
    handleTabClick(event) {
        const tab = event.target.closest(this.config.tabSelector);
        if (!tab) return;

        const category = tab.getAttribute(this.config.dataAttribute);
        this.activateTab(category);
    }

    /**
     * Activate a specific tab and its corresponding content
     * @param {string} category - The category identifier to activate
     * @private
     */
    activateTab(category) {
        if (!category) return;

        // Update tab states
        this.tabs.forEach(tab => {
            tab.classList.toggle(
                this.config.activeClass,
                tab.getAttribute(this.config.dataAttribute) === category
            );
        });

        // Update content visibility
        this.contentLists.forEach(list => {
            list.classList.toggle(
                this.config.activeClass,
                list.getAttribute(this.config.dataAttribute) === category
            );
        });
    }

    /**
     * Programmatically switch to a specific tab
     * @param {string} category - The category identifier to activate
     * @public
     */
    switchToTab(category) {
        this.activateTab(category);
    }

    /**
     * Clean up event listeners to prevent memory leaks
     * @public
     */
    destroy() {
        if (this.tabList) {
            this.tabList.removeEventListener('click', this.boundClickHandler);
            this.boundClickHandler = null;
        }
    }
}

//!===========================================================
//! COPY TO CLIPBOARD
//!===========================================================
/**
 * @class ShareLink
 * Handles copying the current URL with UTM parameters to clipboard,
 * providing fallback support, UI feedback, and debouncing.
 */
class ShareLink {
    /**
     * @param {string} selector - CSS selector for share buttons.
     * @param {Object} options - Optional configuration.
     * @param {string} [options.utm='utm_source=clipboard&utm_medium=copy&utm_campaign=share'] - UTM query string to append.
     * @param {number} [options.debounceDelay=300] - Debounce delay in ms.
     */
    constructor(selector = '.share-button', options = {}) {
        this.selector = selector;
        this.utm = options.utm || 'utm_source=clipboard&utm_medium=copy&utm_campaign=share';
        this.debounceDelay = options.debounceDelay || 300;
        this.revertTimeouts = new WeakMap();
        this.attachHandlers();
    }

    /**
     * Adds click event listeners with debounce to matching buttons.
     */
    attachHandlers() {
        const handler = this.debounce(this.handleCopy.bind(this), this.debounceDelay);
        document.querySelectorAll(this.selector)
            .forEach(btn => btn.addEventListener('click', handler));
    }

    /**
     * Returns the current page URL without hash, with appended UTM parameters.
     * @returns {string}
     */
    getUrlWithUtm() {
        const url = new URL(window.location.href.split('#')[0]);
        const utmParams = new URLSearchParams(this.utm);
        utmParams.forEach((value, key) => url.searchParams.set(key, value));
        return url.toString();
    }

    /**
     * Attempts to write text to clipboard using the modern API.
     * @param {string} text
     * @returns {Promise<boolean>}
     */
    async copyToClipboard(text) {
        if (navigator.clipboard && window.isSecureContext) {
            await navigator.clipboard.writeText(text);
            return true;
        }
        return false;
    }

    /**
     * Fallback copy method using a temporary textarea element.
     * @param {string} text
     * @returns {boolean}
     */
    fallbackCopy(text) {
        const textarea = document.createElement('textarea');
        textarea.value = text;
        textarea.style.position = 'fixed';
        textarea.style.top = '-1000px';
        textarea.style.left = '-1000px';
        document.body.appendChild(textarea);
        textarea.focus();
        textarea.select();
        const success = document.execCommand('copy');
        document.body.removeChild(textarea);
        return success;
    }

    /**
     * Notifies the user about success or failure.
     * @param {boolean} success
     */
    notify(success) {
        const message = success ? 'Ссылка скопирована!' : 'Не удалось скопировать ссылку.';
        if (typeof toastManager !== 'undefined') {
            toastManager.show({message, type: success ? 'default' : 'error'});
        } else {
            alert(message);
        }
    }

    /**
     * Updates button UI to indicate copy success, reverts after delay.
     * @param {HTMLElement} button
     */
    updateButtonUI(button) {
        const svgUse = button.querySelector('svg use');
        const textEl = button.querySelector('.btn__text');
        if (!svgUse || !textEl) return;

        // Cache default states
        button.dataset.defaultIconHref ??= svgUse.getAttribute('href');
        button.dataset.defaultText ??= textEl.textContent;

        // Clear existing revert timeout
        if (this.revertTimeouts.has(button)) {
            clearTimeout(this.revertTimeouts.get(button));
        }

        // Update UI
        svgUse.setAttribute('href', '/assets/icons/icons.svg#icon-true');
        textEl.textContent = 'Скопировано!';

        // Schedule UI revert
        const timeoutId = setTimeout(() => {
            svgUse.setAttribute('href', button.dataset.defaultIconHref);
            textEl.textContent = button.dataset.defaultText;
            this.revertTimeouts.delete(button);
        }, 2000);
        this.revertTimeouts.set(button, timeoutId);
    }

    /**
     * Handles the copy action: gets the UTM URL, copies it, and updates UI.
     * @param {Event} event
     */
    async handleCopy(event) {
        const button = event.currentTarget;
        const url = this.getUrlWithUtm();
        let success = false;

        try {
            success = await this.copyToClipboard(url);
            if (!success) {
                success = this.fallbackCopy(url);
            }
        } catch (e) {
            console.error('Copy failed:', e);
        }

        this.notify(success);
        if (success) {
            this.updateButtonUI(button);
        }
    }

    /**
     * Debounce function (leading edge only).
     * @param {Function} fn
     * @param {number} delay
     * @returns {Function}
     */
    debounce(fn, delay) {
        let timer = null;
        return function (...args) {
            if (timer) return;
            fn.apply(this, args);
            timer = setTimeout(() => {
                timer = null;
            }, delay);
        };
    }
}

const shareLinksHandler = new ShareLink();

//!===========================================================
//! SEARCH MODAL HANDLER
//!===========================================================
/**
 * Search Modal class with configurable selectors
 */
class SearchModal {
    /**
     * @param {Object} options - Configuration options
     */
    constructor(options = {}) {
        // Configuration
        this.DEBOUNCE_DELAY = options.debounceDelay || 300;
        this.MIN_QUERY_LENGTH = options.minQueryLength || 1;

        // Selectors
        this.selectors = {
            form: options.formSelector || '.search-modal__container',
            input: options.inputSelector || 'input[name="q"]',
            productsList: options.productsListSelector || '.js--products',
            categoriesList: options.categoriesListSelector || '.js--categories',
            actionsElement: options.actionsElement || '.js--actions',
            countButton: options.countButtonSelector || '.search-modal__button-count',
            infoText: options.infoTextSelector || '.js--info-text',
            templateId: options.templateId || 'search-card-template'
        };

        // API function
        this.apiSearchFunction = options.apiSearchFunction || window.api.search.products;

        // DOM elements
        this.form = null;
        this.input = null;
        this.productsList = null;
        this.categoriesList = null;
        this.actionsElement = null;
        this.countButton = null;
        this.infoText = null;
        this.searchCardTemplate = null;

        // Bind methods
        this.onSearchInput = this.onSearchInput.bind(this);
        this.onFormSubmit = this.onFormSubmit.bind(this);
    }

    /** Initialize the search modal */
    init() {
        this.form = document.querySelector(this.selectors.form);
        if (!this.form) return;

        this.input = this.form.querySelector(this.selectors.input);
        this.productsList = this.form.querySelector(this.selectors.productsList);
        this.categoriesList = this.form.querySelector(this.selectors.categoriesList);
        this.actionsElement = this.form.querySelector(this.selectors.actionsElement);
        this.countButton = this.form.querySelector(this.selectors.countButton);
        this.infoText = this.form.querySelector(this.selectors.infoText);
        this.searchCardTemplate = document.getElementById(this.selectors.templateId);

        this.input?.addEventListener('input', this.debounce(this.onSearchInput, this.DEBOUNCE_DELAY));
        this.form.addEventListener('submit', this.onFormSubmit);

        this.initState();
    }

    /** Initialize starting state */
    initState() {
        this.clearResults();
        this.infoText.classList.remove('hidden');
        this.infoText.textContent = 'Начните вводить запрос';
        this.actionsElement?.classList.add('hidden');
    }

    /** Handle search input */
    onSearchInput() {
        const query = this.input.value.trim();

        if (query.length < this.MIN_QUERY_LENGTH) {
            this.initState();
            return;
        }

        this.clearResults();
        this.infoText.textContent = 'Поиск…';
        this.infoText.classList.remove('hidden');
        this.actionsElement.classList.add('hidden');

        // Success callback
        const onSuccess = (response) => {
            const items = response.items || [];
            const cats  = response.cats  || [];
            const hasItems = items.length > 0;
            const hasCats  = cats.length  > 0;

            if (!hasItems && !hasCats) {
                this.clearResults();
                this.infoText.textContent = 'Ничего не найдено';
                this.infoText.classList.remove('hidden');
                this.actionsElement.classList.add('hidden');
            } else {
                this.infoText.classList.add('hidden');
                this.renderResults(response);

                if (response.tot > 0) {
                    this.actionsElement.classList.remove('hidden');
                } else {
                    this.actionsElement.classList.add('hidden');
                }
            }
        };

        // Error callback
        const onError = (err) => {
            console.error('Search error:', err);
            this.clearResults();
            this.infoText.textContent = 'Возникла ошибка при поиске';
            this.infoText.classList.remove('hidden');
            this.actionsElement.classList.add('hidden');
        };

        // Fire off search
        this.apiSearchFunction(query, onSuccess, onError);
    }

    /** Render search results */
    renderResults(response) {
        this.renderProductList(response.items);
        this.renderCategoryList(response.cats);
        this.updateTotalCount(response.tot, response.tot_text);
    }

    /** Render product list (max 5 items) */
    renderProductList(items) {
        const list = this.productsList.querySelector('.search-modal__list');
        list.innerHTML = '';

        if (items?.length) {
            items.slice(0, 5).forEach(item =>
                list.appendChild(this.createItemElement(item, 'product'))
            );
            this.productsList.classList.remove('hidden');
        } else {
            this.productsList.classList.add('hidden');
        }
    }

    /** Render category list (max 3 categories) */
    renderCategoryList(categories) {
        const list = this.categoriesList.querySelector('.search-modal__list');
        list.innerHTML = '';

        if (categories?.length) {
            categories.slice(0, 3).forEach(cat =>
                list.appendChild(this.createItemElement(cat, 'category'))
            );
            this.categoriesList.classList.remove('hidden');
        } else {
            this.categoriesList.classList.add('hidden');
        }
    }

    /** Create item element */
    createItemElement(item, type) {
        const fragment = this.searchCardTemplate.content.cloneNode(true);
        const card = fragment.querySelector('.search-card');
        const link = card.querySelector('.search-card__link');
        const img = card.querySelector('.search-card__image');

        card.title = item.name || '';
        card.dataset.productId = type === 'product' ? item.product_id : item.cat_id;

        link.href = item.path || '#';
        link.setAttribute('aria-label', item.name || '');

        img.src = item.img || '/assets/images/placeholders/fallback-img.webp';
        img.alt = item.name || '';

        card.querySelector('.search-card__title').textContent = item.name || '';
        card.querySelector('.search-card__desc').textContent = type === 'product' ? (`Код: ${item.sku}` || '') : '';

        return fragment;
    }

    /** Update total count display */
    updateTotalCount(total, totalText) {
        const btnTextEl = this.countButton.querySelector('.btn__text') || this.countButton;
        const text = total > 0 ? `Показать ${total === 1 ? '' : 'все'} ${totalText || `${total} товаров`}` : '';
        btnTextEl.textContent = text;
    }

    /** Clear search results */
    clearResults() {
        this.productsList.classList.add('hidden');
        this.categoriesList.classList.add('hidden');
        this.updateTotalCount(0, '0 товаров');
    }

    /** Form submit handler */
    onFormSubmit(e) {
        e.preventDefault();
        const query = this.input.value.trim();
        if (query.length >= this.MIN_QUERY_LENGTH) {
            this.form.submit();
        }
    }

    /** Debounce utility */
    debounce(func, wait) {
        let timeout;
        return (...args) => {
            clearTimeout(timeout);
            timeout = setTimeout(() => func.apply(this, args), wait);
        };
    }
}

//!===========================================================
//! PRODUCT LAYOUT HANDLER
//!===========================================================
(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', () => {
        const productGroups = document.querySelectorAll('.product-layout__group');
        // const anchors = document.querySelectorAll('a[href^="#"]');

        if (window.location.hash) {
            openGroupById(window.location.hash.slice(1));
        }

        window.addEventListener('hashchange', () => {
            openGroupById(window.location.hash.slice(1));
        });

        // anchors.forEach(a => {
        //     a.addEventListener('click', () => {
        //         const id = a.getAttribute('href').slice(1);
        //         openGroupById(id);
        //     });
        // });

        productGroups.forEach(group => {
            const trigger = group.querySelector('.product-layout__group-top');
            trigger.addEventListener('click', () => {
                if (group.classList.contains('collapsed')) {
                    group.classList.remove('collapsed');
                } else {
                    group.classList.add('collapsed');
                }
            });
        });
    });
})();

function openGroupById(id) {
    const group = document.getElementById(id);

    if (!group) return;

    if(group.classList.contains('js--prod-group')) {
        group.classList.remove('collapsed');
        group.scrollIntoView({behavior: 'smooth', block: 'start'});
        return;
    }

    const parent = group.closest('.js--prod-group');
    const header = document.querySelector('header');
    const offset = group.getBoundingClientRect().top;

    if(parent.classList.contains('collapsed')) {
        parent.classList.remove('collapsed');
        setTimeout(() => {
            window.scrollTo({
                top: window.scrollY + offset - header.clientHeight,
                behavior: "smooth",
            })
        }, 450);
    } else {
        window.scrollTo({
            top: window.scrollY + offset - header.clientHeight,
            behavior: "smooth",
        })
    }
}

function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/**
 * Filter Manager
 * @classdesc Manages product filtering, sorting, and active filter display
 * @class
 */
class FilterManager {
    /**
     * @param {Object} config - Configuration object
     * @param {string} config.formSelector - CSS selector for the filter forms
     * @param {string} config.sortSelector - CSS selector for the sort dropdown
     * @param {string} config.sortButtonList - CSS selector for the sort button list
     */
    constructor(config) {
        this.config = config;
        this.forms = document.querySelectorAll(config.formSelector);
        this.sortDropdown = document.querySelector(config.sortSelector);
        this.sortButtonList = document.querySelector(config.sortButtonList);
        this.state = new URLSearchParams(window.location.search);
        this.sf = {};

        this.debugger = null;
        this.init();
    }

    /**
     * Initializes component by setting up UI and event listeners
     * @returns {void}
     */
    init() {
        this.handleShowMoreButtons();
        this.attachListeners();
        this.attachSortButtonListeners();
        this.attachTagListeners();
    }

    /**
     * Connects external debugger
     * @param {FilterDebugger} debuggerInstance - Debugger instance to use
     */
    connectDebugger(debuggerInstance) {
        this.debugger = debuggerInstance;
        this.debugger.toggle(true);
        this._log('Debugger connected');
    }

    /**
     * Internal logging method
     * @private
     */
    _log(message, type = 'info') {
        if (this.debugger) {
            this.debugger.logMessage(message, type);
            this.debugger.logCompleteState(this);
        }
    }

    /** Get current state values */
    getState() {
        return Object.fromEntries(this.state.entries());
    }

    /** Get current form values */
    getFormValues(form) {
        const values = {};

        // Get all form controls including switches
        const elements = form.querySelectorAll(
            'input, select, textarea, [role="switch"]'
        );

        elements.forEach(element => {
            const key = element.name || element.closest('[data-filter-group]')?.dataset.filterGroup;

            if (!key) return;

            if (element.type === 'checkbox' || element.getAttribute('role') === 'switch') {
                values[key] = values[key] || [];
                if (element.checked) {
                    values[key].push(element.value || 'true');
                }
            } else if (element.type === 'radio') {
                if (element.checked) {
                    values[key] = element.value;
                }
            } else if (element.tagName === 'SELECT') {
                values[key] = Array.from(element.selectedOptions).map(option => option.value);
            } else {
                values[key] = element.value;
            }
        });

        return values;
    }

    /**
     * Handles "Show more" buttons for long filter lists
     * @returns {void}
     */
    handleShowMoreButtons() {
        document.querySelectorAll('[data-filter-group]').forEach(group => {
            const items = group.querySelectorAll('.js--item-more');
            const moreButton = group.querySelector('.filter__button-more');

            // Remove button if not needed
            if (items.length <= 5) {
                moreButton?.remove();
                return;
            }

            items.forEach((item, index) => {
                if(index < 5) return;
                item.classList.add('collapsed');
            })

            if (!moreButton) return;

            let isExpanded = false;

            moreButton.addEventListener('click', () => {
                isExpanded = !isExpanded;

                // Toggle visibility
                items.forEach((item, index) => {
                    if (index < 5) return;

                    if(isExpanded) {
                        item.classList.remove('collapsed');
                    } else {
                        item.classList.add('collapsed');
                    }
                });

                // Update button text
                moreButton.textContent = isExpanded ? 'Свернуть' : 'Показать все';
            });
        });
    }

    /**
     Attach sort button listeners.
     * При клике на кнопку сортировки обновляется параметр sort в state,
     * обновляется URL и синхронизируется внешний вид как кнопок, так и дропдауна (если он присутствует).
     * @returns {void}
     */
    attachSortButtonListeners() {
        if (!this.sortButtonList) return;

        this.sortButtonList.addEventListener('click', (e) => {
            if (e.target.tagName === 'BUTTON' && e.target.dataset.value) {
                e.preventDefault();
                const sortValue = e.target.dataset.value;
                this.state.set('sort', sortValue);
                this.updateURL();

                // Обновляем активное состояние кнопок
                this.sortButtonList.querySelectorAll('button').forEach(btn => {
                    btn.classList.toggle('active', btn === e.target);
                });

                // Синхронизируем выбранное значение в дропдауне (если он есть)
                if (this.sortDropdown) {
                    this.sortDropdown.setAttribute('data-selected', sortValue);
                    const selectedOption = this.sortDropdown.querySelector(`.dropdown-sort__option[data-value="${sortValue}"]`);
                    if (selectedOption) {
                        const previousSelected = this.sortDropdown.querySelector('.dropdown-sort__option--selected');
                        if (previousSelected) {
                            previousSelected.classList.remove('dropdown-sort__option--selected');
                        }
                        selectedOption.classList.add('dropdown-sort__option--selected');
                        const triggerText = this.sortDropdown.querySelector('.dropdown-sort__trigger-text');
                        if (triggerText) {
                            triggerText.textContent = selectedOption.textContent;
                        }
                    }
                }
            }
        });
    }

    /**
     * Attaches event listeners to tag elements
     * @returns {void}
     */
    attachTagListeners() {
        // Mobile tags
        document.querySelectorAll('.filter-type_tag-list button.tag').forEach(tagButton => {
            tagButton.addEventListener('click', (e) => {
                e.preventDefault();
                tagButton.classList.toggle('active');

                const groupElement = tagButton.closest('[data-filter-group]');
                if (!groupElement) {
                    console.error('No group found for', tagButton);
                    return;
                }
                const group = groupElement.dataset.filterGroup;
                console.debug('Filter group:', group);

                let values = this.state.getAll(group) || [];
                const tagValue = tagButton.dataset.value;
                console.debug('Initial values:', values);
                console.debug('Clicked tag value:', tagValue);

                if (tagButton.classList.contains('active')) {
                    if (!values.includes(tagValue)) {
                        values.push(tagValue);
                    }
                } else {
                    values = values.filter(value => value !== tagValue);
                }

                console.debug('Updated values:', values);
                this.state.delete(group);
                values.forEach(value => this.state.append(group, value));
            });

        });
    }

    getTotalDebounce = debounce(this.getTotal, 250);

    getTotal(form) {
        const bis = document.querySelectorAll('.js--filter-available-count');
        if (!form) {
            return;
        }

        api.catalog.count(new FormData(form), cnt => {
            bis.forEach(e => {
                e.textContent = `Товаров подходит: ${cnt}`;
            })
        });
    }

    /**
     * Attaches event listeners to form elements
     * @returns {void}
     */
    attachListeners() {
        this.forms.forEach(form => {
            form.addEventListener('submit', this.handleSubmit.bind(this));
            form.querySelectorAll('[data-reset-group]').forEach(btn => {
                if (btn.classList.contains('filter__button-reset')) {
                    btn.addEventListener('click', e => {
                        e.preventDefault();
                        this._log(`Reset group button clicked:, ${e.target.dataset.resetGroup}`);

                        if(btn.closest('.js--subfilter-modal')) {
                            this.resetSf(false);
                        } else {
                            this.resetGroup(e.target.dataset.resetGroup);
                        }

                        this.getTotalDebounce(form);
                    });
                }
            });

            const resetAllBtns = form.querySelectorAll('button[type="reset"]');

            if(resetAllBtns.length) {
                resetAllBtns.forEach(btn => btn.addEventListener('click', e =>{
                    e.preventDefault();
                    this._log('Reset all button clicked')
                    this.resetAll();
                    this.getTotalDebounce(form);
                }))
            }

            // Add switch change listeners
            form.querySelectorAll('[role="switch"]').forEach(switchEl => {
                switchEl.addEventListener('change', (e) => {
                    this._log(`Switch changed: ${e.target.checked ? 'ON' : 'OFF'}`);
                    const group = e.target.closest('[data-filter-group]').dataset.filterGroup;
                    this.state.set(group, e.target.checked);
                    this.getTotalDebounce(form);
                });
            });

            form.addEventListener('input', (e) => {
                const { target } = e;

                if(target.closest('.js--search-subfilter')) {
                    clearTimeout(debounceSimple);
                    debounceSimple = setTimeout(() => this.cbSfSearch(), 200)
                    return;
                }

                this._log(`Input changed: ${target.name} = ${target.value}`);
                this.debugger?.logCompleteState(this);
                this.getTotalDebounce(form);
            });

            form.addEventListener('change', (e) => {
                this._log(`Change detected: ${e.target.name} = ${e.target.value}`);
                this.debugger?.logCompleteState(this);
                this.getTotalDebounce(form);
            });

            form.addEventListener('click', (e) => {
                const { target } = e;

                // subfilter events
                if(
                    target.classList.contains('js--show-subfilter') ||
                    target.closest('.js--show-subfilter')
                ) { this.cbSfShow(target) }

                if(
                    target.classList.contains('js--hide-subfilter') ||
                    target.closest('.js--hide-subfilter')
                ) { this.cbSfHide(target) }

                if(target instanceof HTMLElement && (
                    target.classList.contains('js--confirm-subfilter') ||
                    target.closest('.js--confirm-subfilter')
                )) { this.cbSfConfirm(e, target) }

                if(target instanceof HTMLElement &&
                    target.classList.contains('text-input__reset') &&
                    target.closest('.js--search-subfilter')
                ) {
                    clearTimeout(debounceSimple);
                    debounceSimple = setTimeout(() => this.cbSfSearch(), 0)
                }

                // Mobile paramas tags
                if(target.classList.contains(this.config.filterTagItemSelector)) {
                    clearTimeout(debounceSimple);
                    debounceSimple = setTimeout(() => this.eventClickTag(target, form), 200)
                }
            })

            form.querySelectorAll('.dual-range__range-slider').forEach(sliderElement => {
                new DualRangeSlider(sliderElement, {
                    min: parseInt(sliderElement.querySelector('.min-handle').getAttribute('aria-valuemin')),
                    max: parseInt(sliderElement.querySelector('.min-handle').getAttribute('aria-valuemax')),
                    minNow: parseInt(sliderElement.querySelector('.min-handle').getAttribute('aria-valuenow')) || '',
                    maxNow: parseInt(sliderElement.querySelector('.max-handle').getAttribute('aria-valuenow')) || '',
                    step: 1,
                    onChange: (minNow, maxNow) => {
                        this.getTotalDebounce(form);
                    }
                });
            });

            // Track all initial values
            setTimeout(() => {
                this._log('Initial form state');
                this.debugger?.logCompleteState(this);
            }, 100);
        });

        // Sort dropdown handler
        if (this.sortDropdown) {
            // Parse dropdown options
            const options = JSON.parse(this.sortDropdown.dataset.options);

            // Function to update button text
            const updateButtonText = (value) => {
                if (!options || typeof (options.find) === 'undefined')
                    return;

                const selectedOption = options.find(opt => opt.value === value);
                if (selectedOption) {
                    this.sortDropdown.querySelector('.dropdown-sort__trigger-text').textContent = selectedOption.text;
                }
            };

            // Event listener for changes
            this.sortDropdown.addEventListener('change', (event) => {
                const sortValue = event.detail.value || 'default';
                this.state.set('sort', sortValue);
                updateButtonText(sortValue);
                this.updateURL();
            });

            // Initial setup
            const initialSortValue = this.sortDropdown.dataset.selected || 'default';
            this.state.set('sort', initialSortValue);
            updateButtonText(initialSortValue);
        }

        // Reset Filter Tags
        const tags = document.querySelectorAll('.fast-filter__tags .tag');

        tags.forEach(e => {
            e.addEventListener('click', () => {
                const md = e.dataset.tag;
                if (md == 'param') {
                    let loc = location.href;
                    loc = loc.replace('&' + e.dataset.text, '').replace(e.dataset.text, '');
                    location.href = loc;
                } else if (md == 'all') {
                    location.search = '';
                } else if (md == 'price') {
                    const sp = new URLSearchParams(location.search);
                    sp.delete('price_min');
                    sp.delete('price_max');
                    location.search = sp.toString();
                } else {
                    const sp = new URLSearchParams(location.search);
                    sp.delete(md);
                    location.search = sp.toString();
                }
            });
        });

        this.attachMobileSortButtons();
        this.attachHideButtons();
    }

    /**
     * Handles mobile sort buttons
     * @returns {void}
     */
    attachMobileSortButtons() {
        const mobileSortButtons = document.querySelectorAll('.modal-sort__button');
        mobileSortButtons.forEach(button => {
            button.addEventListener('click', () => {
                const value = button.getAttribute('data-value');
                this.state.set('sort', value);
                this.updateURL();
            });
        });
    }

    /**
     * Handles filter section collapse/expand
     * @returns {void}
     */
    attachHideButtons() {
        const filterTops = document.querySelectorAll('.filter__top');

        filterTops.forEach(top => {
            top.addEventListener('click', (e) => {
                if (e.target.classList.contains('filter__button-reset')) return;

                e.preventDefault();
                const filter = top.closest('.filter');
                const filterContent = filter.querySelector('.filter__content');
                const moreButton = filter.querySelector('.filter__button-more');

                top.classList.toggle('active');

                if (filterContent) {
                    filterContent.classList.toggle('collapsed');
                    if (moreButton) {
                        moreButton.classList.toggle('collapsed');
                    }
                }
            });
        });
    }

    /**
     * Resets a specific filter group
     * @param {string} groupName - Name of filter group to reset
     * @returns {void}
     */
    resetGroup(groupName, btn = false) {
        this._log(`Resetting group:, ${groupName}`);
        const group = document.querySelector(`[data-filter-group="${groupName}"]`);

        if (!group) {
            console.error(`Group with name "${groupName}" not found.`);
            return;
        }

        const isRadioGroup = !!group.querySelector('input[type="radio"]');

        group.querySelectorAll('input').forEach(input => {
            if (isRadioGroup) {
                input.checked = input.value === 'any';
            } else {
                input.checked = false;
            }
        });

        const minPriceInput = group.querySelector('input[name="price_min"]');
        const maxPriceInput = group.querySelector('input[name="price_max"]');

        if (minPriceInput && maxPriceInput) {
            minPriceInput.value = minPriceInput.getAttribute('min');
            maxPriceInput.value = maxPriceInput.getAttribute('max');

            minPriceInput.dispatchEvent(new Event('input', {bubbles: true}));
            maxPriceInput.dispatchEvent(new Event('input', {bubbles: true}));
        }

        this.state.delete(groupName);
    }

    /**
     * Resets all filters to default state
     * @returns {void}
     */
    resetAll() {
        this._log('Resetting all filters')
        this.state = new URLSearchParams();
        document.querySelectorAll('[data-filter-group]').forEach(group => {
            const isRadioGroup = !!group.querySelector('input[type="radio"]');
            const tags = group.querySelectorAll('.js--filter__tags-item.active');

            group.querySelectorAll('input').forEach(input => {
                input.checked = isRadioGroup && input.value === 'any';
            });

            if(tags.length) {
                tags.forEach(tag => tag.classList.remove('active'));
            }

            this.renderTags(group);
        });

        const minPriceInput = this.forms[0].querySelector('input[name="price_min"]');
        const maxPriceInput = this.forms[0].querySelector('input[name="price_max"]');

        if (minPriceInput) {
            minPriceInput.value = minPriceInput.getAttribute('min');
            minPriceInput.dispatchEvent(new Event('input', {bubbles: true}));
        }

        if (maxPriceInput) {
            maxPriceInput.value = maxPriceInput.getAttribute('max');
            maxPriceInput.dispatchEvent(new Event('input', {bubbles: true}));
        }
    }

    /**
     * Handles form submission
     * @param {Event} e - Submit event
     * @returns {void}
     */
    handleSubmit(e) {
        e.preventDefault();
        this._log('Form submitted');
        const form = e.target;
        const formData = new FormData(form);

        // Use the data-selected attribute from the dropdown as the sort value.
        if (this.sortDropdown) {
            // Fallback to 'default' if no value is set.
            formData.append('sort', this.sortDropdown.dataset.selected || 'default');
        }

        // Append tag values to formData
        document.querySelectorAll('.filter-type_tag-list button.tag.active').forEach(tagButton => {
            const group = tagButton.closest('[data-filter-group]').dataset.filterGroup;
            const tagValue = tagButton.dataset.value;
            formData.append(group, tagValue);
        });

        // Update the URL with the new search parameters.
        window.location.search = new URLSearchParams(formData).toString();
    }

    /**
     * Updates browser URL with current state
     * @returns {void}
     */
    updateURL() {
        this._log(`Updating URL with state:, ${this.state.toString()}`)
        window.location.search = this.state.toString();
    }

    cbSfShow(target) {
        this.sf.confirm = false;
        this.sf.group = target.closest('[data-filter-group]');

        if(!this.sf.group) return;

        this.sf.modal = this.sf.group.querySelector('.js--subfilter-modal');
        this.sf.tagsWrap = this.sf.group.querySelector('.js--filter-tags');

        if(!this.sf.modal) return;

        this.sf.inps = this.sf.modal.querySelectorAll('.filter__fieldset input');
        this.sf.search = this.sf.modal.querySelector('.js--search-subfilter input');

        const { modal, inps } = this.sf;
        const modalBody = modal.querySelector('.filter-modal__body');
        const itemsCollapse = modal.querySelectorAll('.collapsed');

        if(modalBody) { new SimpleBar(modalBody); }

        if(itemsCollapse.length) {
            itemsCollapse.forEach(item => item.classList.remove('collapsed'));
        }

        if(inps.length) {
            this.sf.state = [];

            const inpsChecked = Array.from(inps).filter(inp => inp.checked);

            if(inpsChecked.length) {
                inpsChecked.forEach(inp => {
                    let obj = {};

                    obj.name = inp.name;
                    obj.value = inp.value;

                    this.sf.state.push(obj);
                })
            }
        }

        this.modalSfShow();
    }

    cbSfHide(target) {
        this.modalSfHide();
        this.resetSf();

        const form = target.closest('form.filter-modal__container');
        if(form) { this.getTotalDebounce(form) }
    }

    cbSfConfirm() {
        this.renderTags();
        this.modalSfHide();
    }

    eventClickTag(target, form) {
        const group = target.closest('[data-filter-group]');

        if(!group) return;

        if(target.dataset.type === 'radio') {
            const tags = group.querySelectorAll('.js--filter__tags-item');
            const inps = group.querySelectorAll('.filter__fieldset input');

            if(tags.length) {
                tags.forEach(tag => tag.classList.remove('active'));
            }

            if(inps.length) {
                inps.forEach(inp => inp.checked = false)
            }
        }

        const inp = group.querySelector(`[name="${target.dataset.name}"][value="${target.dataset.value}"]`);

        inp.checked = target.classList.contains('active') ? false : true;
        target.classList.toggle('active');
        this.getTotalDebounce(form);
    }

    cbSfSearch() {
        const { modal, search } = this.sf;
        const items = modal.querySelectorAll('.js--item-more');
        const itemsFiltered = Array.from(items).filter(item => this.collaseInp(search.value.toUpperCase(), item));

        if(!itemsFiltered.length) {
            modal.classList.add('subfilter-modal__empty')
            return;
        }

        modal.classList.remove('subfilter-modal__empty')
    }

    collaseInp(val, item) {
        let text = item.querySelector('.checkbox__text');

        if(!text) return;

        text = text.textContent.toUpperCase();

        if(text.includes(val)) {
            item.classList.remove('collapsed');
        } else {
            item.classList.add('collapsed');
        }

        return text.includes(val);
    }

    createTag(name, value, text = value, active = false) {
        const btn = document.createElement('button');
        btn.className = 'tab tab-primary tab-size_xs tab-theme_light filter__tags-item js--filter__tags-item';
        btn.type = 'button';
        btn.dataset.name = name;
        btn.dataset.value = value;

        if(active) { btn.className += ' active' }

        const span = document.createElement('span');
        span.className = 'tab__text';
        span.textContent = text;

        const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
        svg.classList.add('tab__icon');
        svg.setAttribute('aria-hidden', 'true');

        const use = document.createElementNS('http://www.w3.org/2000/svg', 'use');
        use.setAttribute('href', '/assets/icons/icons.svg#icon-close');

        svg.append(use);
        btn.append(span, svg);

        return btn;
    }

    renderTags(group = false) {
        let { inps, tagsWrap } = this.sf;

        if (group) {
            tagsWrap = group.querySelector('.js--filter-tags');
            inps = group.querySelectorAll('.filter__fieldset input');
        }

        if(!inps.length || !tagsWrap) return;

        const tagsContainer = document.createDocumentFragment();
        const inpsChecked = Array.from(inps).filter(inp => inp.checked);
        const defaultCount = 5;
        const setTags = (inp, active = false) => {
            if(!inp) return;

            const text = inp.closest('.js--item-more').querySelector('.checkbox__text');

            tagsContainer.append(this.createTag(
                inp.name, inp.value, text ? text.textContent : undefined, active
            ))
        }

        if(!inpsChecked.length) {
            for (let i = 0; i < defaultCount; i++) { setTags(inps[i]) }
        } else if(inpsChecked.length > 5) {
            inpsChecked.forEach(inp => setTags(inp, true));
        } else {
            const inpsPart = Array
                .from(inps)
                .filter(inp => !inp.checked)
                .slice(0, defaultCount - inpsChecked.length);

            inpsChecked.forEach(inp => setTags(inp, true));
            inpsPart.forEach(inp => setTags(inp, false));
        }

        tagsWrap.innerHTML = '';
        tagsWrap.append(tagsContainer);
    }

    modalSfShow() {
        const { modal } = this.sf;

        modal.style.display = 'block';
        modal.classList.add('active');
    }

    modalSfHide() {
        const { modal } = this.sf;

        modal.classList.remove('active');
        modal.style.display = 'none';
    }

    resetSf(isSetState = true) {
        const { modal, search, inps, state } = this.sf;

        modal.classList.remove('subfilter-modal__empty');

        if(search) { search.value = '' }

        if(!inps.length) return;

        inps.forEach(inp => {
            let wrap = inp.closest('.js--item-more.collapsed');

            if(wrap) { wrap.classList.remove('collapsed') }
            inp.checked = false;
        });

        if(!isSetState || !state.length) return;

        state.forEach(obj => {
            let curInp = Array.from(inps).find(inp => inp.name === obj.name && inp.value === obj.value);

            if(!curInp) return;

            curInp.checked = true;
        })
    }
}

// Инициализация
let filterManager;

document.addEventListener('DOMContentLoaded', () => {
    filterManager = new FilterManager({
        formSelector: 'form.filter-modal__container',
        filterTagItemSelector: 'js--filter__tags-item'
    });
});

//!===========================================================
//! EMAIL INPUT VALIDATOR
//!===========================================================
class EmailValidator {
    /**
     * Creates an instance for the given selector(s).
     * @param {string | NodeList | HTMLInputElement[]} selector - A CSS selector or collection of inputs.
     */
    constructor(form, selector) {
        this.inputs = form.querySelectorAll(selector);
        this.inputs = Array.from(this.inputs).filter(el => el && typeof el.value === 'string');
        this.init();
    }

    /**
     * Attach input listeners to each email input.
     */
    init() {
        this.inputs.forEach(input => {
            input.dataset.touched = 'false';

            input.addEventListener('input', (event) => {
                if (input.dataset.touched === 'false') {
                    input.dataset.touched = 'true';
                }
                this.handleInput(event);
            });

            this.handleInput({target: input, isTrusted: false});
        });
    }

    /**
     * Validate the email input on each change.
     * @param {Event} event
     */
    handleInput(event) {
        const input = event.target;
        const value = input.value.trim();

        const isTouched = input.dataset.touched === 'true' || event.isTrusted;

        if (this.validateEmail(value)) {
            this.toggleValidity(input, true);

            if (isTouched) {
                this.hideError(input);
            }
        } else {
            this.toggleValidity(input, false);

            if (isTouched) {
                this.showError(input, "Введите корректный e-mail.");
            }
        }
    }

    /**
     * Validate email using a simple regex.
     * @param {string} email
     * @returns {boolean} True if valid.
     */
    validateEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    /**
     * Toggle valid/invalid CSS classes.
     * @param {HTMLInputElement} input
     * @param {boolean} isValid
     */
    toggleValidity(input, isValid) {
        if (isValid) {
            input.classList.add('valid');
            input.classList.remove('invalid');
        } else {
            input.classList.add('invalid');
            input.classList.remove('valid');
        }
    }

    /**
     * Show the error message in the nearby error span.
     * @param {HTMLInputElement} input
     * @param {string} message
     */
    showError(input, message) {
        // Look for the closest wrapper with the class .text-input__wrapper
        const wrapper = input.closest('.text-input__wrapper');
        if (wrapper) {
            const errorSpan = wrapper.querySelector('.text-input__error-message');
            if (errorSpan) {
                errorSpan.textContent = message;
                errorSpan.classList.remove('hidden');
            }
        }
    }

    /**
     * Hide the error message.
     * @param {HTMLInputElement} input
     */
    hideError(input) {
        const wrapper = input.closest('.text-input__wrapper');
        if (wrapper) {
            const errorSpan = wrapper.querySelector('.text-input__error-message');
            if (errorSpan) {
                errorSpan.textContent = '';
                errorSpan.classList.add('hidden');
            }
        }
    }

    /**
     * Check if all email inputs are valid.
     * @returns {boolean}
     */
    areAllInputsValid() {
        return Array.from(this.inputs).every(input => {
            return input.value.trim() !== '' && input.classList.contains('valid');
        });
    }
}

window.EmailValidator = EmailValidator;

//!===========================================================
//! PHONE INPUT VALIDATOR
//!===========================================================
/**
 * A class to validate and format phone number inputs in a specific format.
 * Supports Russian phone numbers starting with "+7" or "8", formatted as "+7 (XXX) XXX-XX-XX" or "8 (XXX) XXX-XX-XX".
 */
class PhoneValidator {
    /**
     * Creates an instance for the given phone input selector(s).
     * @param {string | NodeList | HTMLInputElement[]} selector - CSS selector string, NodeList, or array of input elements.
     * @throws {Error} If the selector is invalid or no valid inputs are found.
     */
    constructor(form, selector) {
        this.inputs = form.querySelectorAll(selector);
        this.inputs = Array.from(this.inputs).filter(el => el && typeof el.value === 'string');
        this.init();
    }

    /**
     * Initializes the phone validator by attaching event listeners to all managed inputs.
     */
    init() {
        this.inputs.forEach(input => {
            input.dataset.touched = 'false';
            input.addEventListener('input', (event) => {
                if (input.dataset.touched === 'false') {
                    input.dataset.touched = 'true';
                }
                this.handleInput(event);
            });
            this.handleInput({target: input, isTrusted: false});
        });
    }

    /**
     * Handles input events by formatting the phone number and validating it.
     * @param {Event} event - The input event object or a synthetic event for initial setup.
     */
    handleInput(event) {
        const input = event.target;
        this.formatPhoneInput(input);
        const isValid = this.validatePhone(input.value);
        this.toggleValidity(input, isValid);

        if (!isValid && input.dataset.touched === 'true') {
            this.showError(input, "Введите корректный номер.");
        } else {
            this.hideError(input);
        }
    }

    /**
     * Formats the phone number input based on its digits.
     * - Full 11-digit numbers starting with "7" or "8" are formatted as "+7 (XXX) XXX-XX-XX" or "8 (XXX) XXX-XX-XX".
     * - Full 10-digit numbers are prefixed with "+7" (e.g., "3121286805" → "+7 (312) 128-68-05").
     * - Partial inputs are formatted incrementally.
     * @param {HTMLInputElement} input - The input element to format.
     */
    formatPhoneInput(input) {
        let rawInput = input.value.trim();
        let prefix = '';
        let digits = '';

        // Determine the prefix and extract digits
        if (rawInput.startsWith('+7')) {
            prefix = '+7';
            digits = rawInput.slice(2).replace(/\D/g, ''); // Digits after "+7"
        } else if (rawInput.startsWith('8')) {
            prefix = '8';
            digits = rawInput.slice(1).replace(/\D/g, ''); // Digits after "8"
        } else {
            // No recognized prefix; assume raw digits and default to "+7"
            digits = rawInput.replace(/\D/g, '');
            prefix = digits.length > 0 ? '+7' : '';
        }

        // If no digits, set input to prefix (or empty if no prefix)
        if (!digits) {
            input.value = prefix;
            return;
        }

        // Format the digits after the prefix
        let formatted = prefix + ' (';
        if (digits.length > 0) {
            formatted += digits.substring(0, Math.min(3, digits.length));
        }
        if (digits.length >= 4) {
            formatted += ') ' + digits.substring(3, Math.min(6, digits.length));
        }
        if (digits.length >= 7) {
            formatted += '-' + digits.substring(6, Math.min(8, digits.length));
        }
        if (digits.length >= 9) {
            formatted += '-' + digits.substring(8, Math.min(10, digits.length));
        }

        input.value = formatted;
    }

    /**
     * Validates the phone number by checking it has exactly 11 digits and starts with "7" or "8".
     * @param {string} value - The phone number string to validate.
     * @returns {boolean} True if the phone number is valid, false otherwise.
     */
    validatePhone(value) {
        const digits = value.replace(/\D/g, '');
        return digits.length === 11 && ['7', '8'].includes(digits[0]);
    }

    /**
     * Toggles CSS classes "valid" and "invalid" on the input based on its validity.
     * @param {HTMLInputElement} input - The input element to update.
     * @param {boolean} isValid - Whether the input is valid.
     */
    toggleValidity(input, isValid) {
        if (isValid) {
            input.classList.add('valid');
            input.classList.remove('invalid');
        } else {
            input.classList.add('invalid');
            input.classList.remove('valid');
        }
    }

    /**
     * Displays an error message near the input if it exists within a wrapper.
     * @param {HTMLInputElement} input - The input element associated with the error.
     * @param {string} message - The error message to display.
     */
    showError(input, message) {
        const wrapper = input.closest('.text-input__wrapper');
        if (wrapper) {
            const errorSpan = wrapper.querySelector('.text-input__error-message');
            if (errorSpan) {
                errorSpan.textContent = message;
                errorSpan.classList.remove('hidden');
            }
        }
    }

    /**
     * Hides the error message near the input if it exists.
     * @param {HTMLInputElement} input - The input element associated with the error.
     */
    hideError(input) {
        const wrapper = input.closest('.text-input__wrapper');
        if (wrapper) {
            const errorSpan = wrapper.querySelector('.text-input__error-message');
            if (errorSpan) {
                errorSpan.textContent = '';
                errorSpan.classList.add('hidden');
            }
        }
    }

    /**
     * Checks if all managed phone inputs are valid and non-empty.
     * @returns {boolean} True if all inputs are valid, false otherwise.
     */
    areAllInputsValid() {
        return Array.from(this.inputs).every(input => {
            return input.value.trim() !== '' && input.classList.contains('valid');
        });
    }
}

window.PhoneValidator = PhoneValidator;

//!===========================================================
//! BASIC TEXT INPUT VALIDATOR
//!===========================================================
class BasicTextValidator {
    /**
     * Creates an instance for the given selector(s).
     * @param {string | NodeList | HTMLInputElement[]} selector - A CSS selector or collection of inputs.
     */
    constructor(form, selector) {
        this.inputs = form.querySelectorAll(selector);
        this.inputs = Array.from(this.inputs).filter(el => el && typeof el.value === 'string');
        this.init();
    }

    /**
     * Attach input event listeners to each text input.
     */
    init() {
        this.inputs.forEach(input => {
            input.dataset.touched = 'false';

            input.addEventListener('input', (event) => {
                if (input.dataset.touched === 'false') {
                    input.dataset.touched = 'true';
                }
                this.handleInput(event);
            });

            this.handleInput({target: input, isTrusted: false});
        });
    }

    /**
     * Handle the input event: if the trimmed value is empty, mark the field as invalid.
     * @param {Event} event
     */
    handleInput(event) {
        const input = event.target;
        const value = input.value.trim();

        if (value === '') {
            this.toggleValidity(input, false);

            if (input.dataset.touched === 'true') {
                this.showError(input, "Это поле обязательно.");
            }
        } else {
            this.toggleValidity(input, true);
            this.hideError(input);
        }
    }

    /**
     * Toggle valid/invalid CSS classes on the input.
     * @param {HTMLInputElement} input
     * @param {boolean} isValid
     */
    toggleValidity(input, isValid) {
        if (isValid) {
            input.classList.add('valid');
            input.classList.remove('invalid');
        } else {
            input.classList.add('invalid');
            input.classList.remove('valid');
        }
    }

    /**
     * Show the error message in the associated error message span.
     * @param {HTMLInputElement} input
     * @param {string} message
     */
    showError(input, message) {
        // Find the nearest container that holds the error message.
        const container = input.closest('.text-input__wrapper');
        if (container) {
            const errorSpan = container.querySelector('.text-input__error-message');
            if (errorSpan) {
                errorSpan.textContent = message;
                errorSpan.classList.remove('hidden');
            }
        }
    }

    /**
     * Hide the error message.
     * @param {HTMLInputElement} input
     */
    hideError(input) {
        const container = input.closest('.text-input__wrapper');
        if (container) {
            const errorSpan = container.querySelector('.text-input__error-message');
            if (errorSpan) {
                errorSpan.textContent = '';
                errorSpan.classList.add('hidden');
            }
        }
    }

    /**
     * Check if all managed text inputs are valid.
     * @returns {boolean}
     */
    areAllInputsValid() {
        return Array.from(this.inputs).every(input => {
            return input.value.trim() !== '' && input.classList.contains('valid');
        });
    }
}

window.BasicTextValidator = BasicTextValidator;

// ------------------------------ TEMPORARY, REFACTOR LATER 👇👇👇🥶 ------------------------------

//!===========================================================
//! LAZY LOADING IMAGES
//!===========================================================
(function () {
    'use strict';

    function lazyLoadImages() {
        const images = document.querySelectorAll('img[data-src]');

        images.forEach(image => {
            image.style.visibility = 'hidden';

            const preloader = new Image();

            preloader.onload = function () {
                image.src = preloader.src;

                image.style.visibility = 'visible';

                image.removeAttribute('data-src');
            };

            preloader.onerror = function () {
                console.error('Failed to load image:', preloader.src);
            };

            preloader.src = image.getAttribute('data-src');
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', lazyLoadImages);
    } else {
        lazyLoadImages();
    }
})();

//!===========================================================
//! INPUT SANITIZER
//!===========================================================
/**
 * Sanitizes user input to prevent XSS and injection attacks
 * @param {string} input - Raw user input
 * @param {Object} options - Optional configuration parameters
 * @returns {string} Sanitized input
 */
function sanitizeInput(input, options = {}) {
    // Handle non-string inputs
    if (typeof input !== 'string') {
        return '';
    }

    // Default configuration
    const config = {
        maxLength: options.maxLength || 1000,
        trim: options.trim !== false,
        removeHTML: options.removeHTML !== false,
        encodeEntities: options.encodeEntities !== false,
        preventScriptTags: options.preventScriptTags !== false,
        preventEventHandlers: options.preventEventHandlers !== false,
        preventJsURI: options.preventJsURI !== false,
        preventSQLInjection: options.preventSQLInjection !== false,
        preventDataURI: options.preventDataURI !== false
    };

    // Apply trimming
    let sanitized = config.trim ? input.trim() : input;

    // Apply length constraint
    if (sanitized.length > config.maxLength) {
        sanitized = sanitized.substring(0, config.maxLength);
    }

    // Remove HTML tags
    if (config.removeHTML) {
        sanitized = sanitized.replace(/<[^>]*>/g, '');
    }

    // Remove script tags
    if (config.preventScriptTags) {
        sanitized = sanitized.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '');
    }

    // Remove event handlers
    if (config.preventEventHandlers) {
        sanitized = sanitized.replace(/\bon\w+\s*=\s*["']?[^"']*["']?/gi, '');
    }

    // Remove JavaScript URI schemes
    if (config.preventJsURI) {
        sanitized = sanitized.replace(/javascript\s*:/gi, 'blocked:');
    }

    // Remove SQL injection patterns
    if (config.preventSQLInjection) {
        sanitized = sanitized.replace(/(\b(select|insert|update|delete|drop|alter|exec|union)\b|\b--|\b\/\*|\*\/)/gi, '');
    }

    // Remove Data URI exploitation
    if (config.preventDataURI) {
        sanitized = sanitized.replace(/data\s*:[^,]+,[^)]+\)/gi, '');
    }

    // Encode HTML entities
    if (config.encodeEntities) {
        sanitized = sanitized
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    return sanitized;
}