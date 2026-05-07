(function() {
    'use strict';

    const DEFAULT_CONFIG = {
        modalSelector: '.cookie-modal',
        buttonSelector: '.cookie-modal__submit',
        cookieName: 'cookieConsent',
        activeClass: 'active'
    };

    function modalCookieHandler(config = DEFAULT_CONFIG) {
        const { modalSelector, buttonSelector, cookieName, activeClass } = config;
        const cookieModal = document.querySelector(modalSelector);
        const submitButton = document.querySelector(buttonSelector);

        if (!cookieModal || !submitButton) {
            console.warn('Cookie modal elements not found in the DOM.');
            return;
        }

        submitButton.addEventListener('click', () => {
            cookieModal.classList.remove(activeClass);

            cookieModal.addEventListener('transitionend', function onTransitionEnd(event) {
                if (event.propertyName === 'transform') {
                    cookieModal.removeEventListener('transitionend', onTransitionEnd);
                    if (cookieModal.parentNode) {
                        cookieModal.parentNode.removeChild(cookieModal);
                    }
                }
            });

            setCookie(cookieName, 'true', 365);
        });
    }

    function setCookie(name, value, days) {
        const date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        document.cookie = `${name}=${value};expires=${date.toUTCString()};path=/;SameSite=Lax`;
    }

    document.addEventListener('DOMContentLoaded', () => modalCookieHandler());
})();