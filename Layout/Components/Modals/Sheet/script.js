class Sheet {
    constructor(sheetElement) {
        this.sheet = sheetElement;
        this.overlay = document.getElementById('sheet-overlay');
        this.closeButtons = this.sheet.querySelectorAll('.sheet-close');
        this.catalogBtn = document.querySelector('.header__button-catalog');
        this.buttonIcon = this.catalogBtn.querySelector('.btn__icon use');
        this.isOpen = false;

        this.#init();
    }

    #init() {
        this.overlay.addEventListener('click', () => this.toggle());
        this.closeButtons.forEach(btn => btn.addEventListener('click', () => this.toggle()));
        this.sheet.addEventListener('click', (e) => {
            if (e.target === this.sheet) this.toggle();
        });
        this.catalogBtn.addEventListener('click', () => this.toggle());
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.isOpen) this.toggle();
        });

        window.addEventListener('resize', () => this.#checkWindowWidth());
    }

    toggle() {
        this.isOpen ? this.close() : this.open();
        this.buttonIcon.setAttribute('href',
            this.isOpen
                ? '/assets/icons/icons.svg#icon-close'
                : '/assets/icons/icons.svg#icon-unique-dots'
        );
    }

    open() {
        this.sheet.classList.add('active');
        this.overlay.classList.add('active');
        document.body.classList.add('scroll-lock');
        this.isOpen = true;
    }

    close() {
        this.sheet.classList.remove('active');
        this.overlay.classList.remove('active');
        document.body.classList.remove('scroll-lock');
        this.isOpen = false;

        this.buttonIcon.setAttribute('href',
            this.isOpen
                ? '/assets/icons/icons.svg#icon-close'
                : '/assets/icons/icons.svg#icon-unique-dots'
        );
    }

    #checkWindowWidth() {
        if (window.innerWidth < 811 && this.isOpen) {
            this.toggle();
            this.close();
        }
    }
}

const sheet = new Sheet(document.getElementById('sheet'));

(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', () => {
        const sheetTabs = new TabManager();
    });
})();