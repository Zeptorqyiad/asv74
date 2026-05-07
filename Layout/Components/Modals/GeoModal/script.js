(function () {
    'use strict';

    /**
     * Manages the GEO selection modal: search, validation and submission.
     */
    class GeoModal {
        /**
         * @param {string} modalId — the ID of the modal container
         */
        constructor(modalId) {
            this.modal        = document.getElementById(modalId);
            this.confirmBtn   = this.modal.querySelector('.geo-modal__button-confirm');
            this.changeBtn    = this.modal.querySelector('.geo-modal__button-change');
            this.saveBtn      = this.modal.querySelector('.geo-modal__button-save');
            this.entryBlock   = this.modal.querySelector('.geo-modal__block--entry');
            this.changeBlock  = this.modal.querySelector('.geo-modal__block--change');
            this.dropdownWrap = this.modal.querySelector('.geo-modal__dropdown');
            this.input        = this.dropdownWrap.querySelector('.geo-modal__dropdown-input .text-input__field');
            this.list         = this.dropdownWrap.querySelector('.geo-modal__dropdown-list');
            this.available    = [];

            this.saveBtn.disabled = true;
            this.saveBtn.classList.add('disabled');

            this._bindEvents();
        }

        /** Attach all event listeners */
        _bindEvents() {
            document.addEventListener('DOMContentLoaded', () => {
                this.input.addEventListener('input', e => this._onInput(e));
                this.saveBtn.addEventListener('click', () => this._onSubmit());
                this.changeBtn.addEventListener('click', () => this._showChange());
                this.confirmBtn.addEventListener('click', () => this._onConfirm());
                document.addEventListener('click', e => this._onDocumentClick(e));
            });
        }

        /**
         * Close dropdown if click occurs outside of it.
         * @param {MouseEvent} e
         */
        _onDocumentClick(e) {
            if (!this.dropdownWrap.contains(e.target)) {
                this._closeDropdown();
            }
        }

        /**
         * Handle typing in the input: fetch cities, render dropdown, validate.
         * @param {InputEvent} e
         */
        async _onInput(e) {
            const q = sanitizeInput(e.target.value.trim());
            if (!q) {
                this._clearDropdown();
                this.available = [];
                return this._validate();
            }

            this._openDropdown();

            const onSuccess = (data) => {
                const items = data.items || [];
                this.available = items.slice();
                this._renderList(items);
                this._validate();
            };

            const onError = () => {
                this._clearDropdown();
                this._validate();
            };

            window.api.search.city(q, onSuccess, onError);
        }

        /**
         * Enable or disable Save based on current input vs availableCities.
         */
        _validate() {
            const ok = this.available.includes(this.input.value.trim());
            this.saveBtn.disabled = !ok;
            this.saveBtn.classList.toggle('disabled', !ok);
        }

        /** Clear and close dropdown. */
        _clearDropdown() {
            this.list.innerHTML = '';
            this._closeDropdown();
        }

        /** Open dropdown list. */
        _openDropdown() {
            this.list.classList.add('active');
        }

        /** Close dropdown list. */
        _closeDropdown() {
            this.list.classList.remove('active');
        }

        /**
         * Render list of cities into dropdown.
         * @param {string[]} items
         */
        _renderList(items) {
            this.list.innerHTML = '';
            if (!items.length) {
                const li = document.createElement('li');
                li.className = 'geo-modal__dropdown-item--no-results';
                li.textContent = 'Ничего не найдено...';
                return this.list.appendChild(li);
            }
            items.forEach(city => {
                const li = document.createElement('li');
                li.className = 'geo-modal__dropdown-item';
                li.textContent = city;
                li.addEventListener('click', () => {
                    this.input.value = city;
                    this._closeDropdown();
                    this._validate();
                });
                this.list.appendChild(li);
            });
        }

        /** Switch to “change” view. */
        _showChange() {
            this.entryBlock.classList.add('hidden');
            this.changeBlock.classList.remove('hidden');
        }

        /** Handle Save click: validate then navigate. */
        _onSubmit() {
            const val = this.input.value.trim();
            if (!this.available.includes(val)) return;
            this.saveBtn.disabled = true;
            this.saveBtn.classList.add('loading');

            const url = new URL(window.location.href);
            url.searchParams.set('_geo', val);
            location.href = url;
        }

        /** Close modal and revert to entry view. */
        _onConfirm() {
            modalManager.close(this.modal.id);
            this.entryBlock.classList.remove('hidden');
            this.changeBlock.classList.add('hidden');
        }
    }

// Initialize
    new GeoModal('geo-modal');
}());