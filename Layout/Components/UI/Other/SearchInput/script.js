(function () {
    'use strict';

    class HeaderSearch extends SearchModal {
        constructor() {
            super({
                formSelector: '.search-form',
                inputSelector: 'input[name="q"]',
                productsListSelector: '.js--products',
                categoriesListSelector: '.js--categories',
                actionsElement: '.js--actions',
                countButtonSelector: '.search-form__button-count',
                infoTextSelector: '.js-info-text',
                templateId: 'search-card-template',
            });
            this.resultsContainer = null;
            this.searchOverlay = null;
            this.onKeyDown = this.onKeyDown.bind(this);
        }

        renderProductList(items) {
            const list = this.productsList.querySelector('.search-form__list');
            list.innerHTML = '';

            if (items?.length) {
                items.slice(0, 5).forEach(item => {
                    list.appendChild(this.createItemElement(item, 'product'));
                });
                this.productsList.classList.remove('hidden');
            } else {
                this.productsList.classList.add('hidden');
            }
        }

        renderCategoryList(categories) {
            const list = this.categoriesList.querySelector('.search-form__list');
            list.innerHTML = '';

            if (categories?.length) {
                categories.slice(0, 3).forEach(category => {
                    list.appendChild(this.createItemElement(category, 'category'));
                });
                this.categoriesList.classList.remove('hidden');
            } else {
                this.categoriesList.classList.add('hidden');
            }
        }

        setupInputFocus() {
            this.input.addEventListener('focus', () => {
                this.resultsContainer.classList.add('active');
                this.searchOverlay.classList.add('active');
                document.body.style.overflow = 'hidden';
                sheet.close();
            });

            document.addEventListener('click', (e) => {
                if (!this.form.contains(e.target)) {
                    this.resultsContainer.classList.remove('active');
                    this.searchOverlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
            });
        }

        closeSearch() {
            this.resultsContainer.classList.remove('active');
            this.searchOverlay.classList.remove('active');
            document.body.style.overflow = '';
            if (typeof sheet !== 'undefined') sheet.close();
        }

        onKeyDown(e) {
            if (e.key === 'Escape') {
                if (this.resultsContainer.classList.contains('active')) {
                    this.closeSearch();
                }
            }
        }

        init() {
            super.init();
            this.resultsContainer = this.form.querySelector('.search-form__results');
            this.searchOverlay = document.querySelector('#search-overlay');
            this.setupInputFocus();
            document.addEventListener('keydown', this.onKeyDown);
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
        new HeaderSearch().init();
    });
})();
