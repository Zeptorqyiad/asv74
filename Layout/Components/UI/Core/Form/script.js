/**
 * Honeypot Validator Module
 * @module HoneypotValidator
 * @description Detects bot form submissions using hidden decoy fields with convincing names
 */
// const HoneypotValidator = {
//     /** @private */
//     FAKE_FIELD_NAMES: [
//         'credit_card_number',
//         'phone_number',
//         'ssn',
//         'birthdate',
//         'security_answer',
//         'card_cvc',
//         'billing_zip',
//         'account_pin',
//         'passport_number',
//         'mother_maiden_name',
//         'autofill_card_number',
//         'auto_complete_email',
//         'encrypted_password',
//         '2fa_backup_code'
//     ],
//
//     /** @private */
//     _currentRotationIndex: 0,
//
//     /**
//      * Initializes honeypot fields
//      * @public
//      */
//     init() {
//         this.setupFields();
//     },
//
//     /**
//      * Configures honeypot fields with random realistic names and hiding styles
//      * @private
//      */
//     setupFields() {
//         document.querySelectorAll('.honey-input').forEach(input => {
//             this.configureField(input);
//         });
//     },
//
//     /**
//      * Applies honeypot configuration to a single field
//      * @private
//      * @param {HTMLInputElement} input - The honeypot field to configure
//      */
//     configureField(input) {
//         input.name = this.getNextFieldName();
//         input.autocomplete = 'off';
//         Object.assign(input.style, {
//             opacity: '0',
//             position: 'absolute',
//             left: '-9999px',
//             height: '0',
//             width: '0',
//             pointerEvents: 'none'
//         });
//     },
//
//     /**
//      * Gets next realistic field name using rotational pattern
//      * @private
//      * @returns {string} Randomized but convincing field name
//      */
//     getNextFieldName() {
//         this._currentRotationIndex++;
//         return this.FAKE_FIELD_NAMES[
//         this._currentRotationIndex % this.FAKE_FIELD_NAMES.length
//             ];
//     },
//
//     /**
//      * Validates form by checking honeypot fields
//      * @public
//      * @param {HTMLFormElement} form - The form element to validate
//      * @returns {boolean} True if form is valid (no honeypot entries), false if bot detected
//      */
//     validate(form) {
//         return !Array.from(form.querySelectorAll('.honey-input'))
//             .some(field => field.value.trim() !== '');
//     }
// };
// document.addEventListener('DOMContentLoaded', () => HoneypotValidator.init());

/**
 * Automatically initializes client-side validation and AJAX submission
 * for all forms with the `.form` class.
 * @module FormHandler
 */
(function () {
    'use strict';

    const forms = document.querySelectorAll('.form');

    forms.forEach(form => {
        const submitBtn = form.querySelector('.form__button-submit');
        const validators = [
            new BasicTextValidator(form, '.form__text-input--name .text-input__field'),
            new PhoneValidator(form, '.form__text-input--phone .text-input__field'),
            new EmailValidator(form, '.form__text-input--email .text-input__field')
        ];

        /**
         * Handles the form submit event:
         * - Prevents default submission
         * - Validates honeypot and individual input validators
         * - Toggles loading state
         * - Sends form data via fetch
         * - Opens success or error modal
         * @param {SubmitEvent} e - The native submit event
         * @returns {Promise<void>}
         */
        form.addEventListener('submit', async e => {
            e.preventDefault();

            if (!validators.every(v => v.areAllInputsValid())) {
                console.warn('Validation failed');
                return;
            }

            toggleLoading(submitBtn, true);
            const fd = new FormData(form);
            fd.append('from_url', location.href);
            fd.append('from_title', document.title);

            setDataTitleModal(form, fd);

            try {
                const res = await fetch('/form/', {method: 'POST', body: fd});
                const data = await res.json();

                modalManager.open(data.success ? 'success-modal' : 'error-modal');
                if (data.success) { tracker.track('formsuccess') }
            } catch {
                modalManager.open('error-modal');
            } finally {
                toggleLoading(submitBtn, false);
            }
        });
    });

    function toggleLoading(button, isLoading) {
        button.classList.toggle('loading', isLoading);
        button.disabled = isLoading;
    }

    function setDataTitleModal(form, fd) {
        const modal = form.closest('#callback-modal')

        if(!modal) return;

        const title = modal.querySelector('.callback-modal__title');

        if(!title) return;

        fd.append('modal_title', title.textContent);
    }
})();