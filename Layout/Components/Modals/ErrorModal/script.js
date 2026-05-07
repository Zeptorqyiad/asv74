(function () {
    'use strict';

    const successModal = document.getElementById('error-modal');
    const defaultTitle = successModal.querySelector('.error-modal__title').textContent;
    const defaultDesc = successModal.querySelector('.error-modal__desc').textContent;

    successModal.addEventListener('modalopen', function(event) {
        const data = event.detail || {};
        const titleElement = this.querySelector('.error-modal__title');
        const descElement = this.querySelector('.error-modal__desc');
        titleElement.textContent = data.title || defaultTitle;
        descElement.textContent = data.desc || defaultDesc;
    });
}());