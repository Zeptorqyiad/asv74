(function () {
    'use strict';

    const successModal = document.getElementById('success-modal');
    const defaultTitle = successModal.querySelector('.success-modal__title').textContent;
    const defaultDesc = successModal.querySelector('.success-modal__desc').textContent;

    successModal.addEventListener('modalopen', function(event) {
        const data = event.detail || {};
        const titleElement = this.querySelector('.success-modal__title');
        const descElement = this.querySelector('.success-modal__desc');
        titleElement.textContent = data.title || defaultTitle;
        descElement.textContent = data.desc || defaultDesc;
    });
}());