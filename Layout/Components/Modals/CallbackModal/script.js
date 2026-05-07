(function () {
    'use strict';

    const successModal = document.getElementById('callback-modal');
    const defaultTitle = successModal.querySelector('.callback-modal__title').innerHTML;
    const defaultDesc = successModal.querySelector('.callback-modal__desc').textContent;

    successModal.addEventListener('modalopen', function(event) {
        const data = event.detail || {};
        const titleElement = this.querySelector('.callback-modal__title');
        const descElement = this.querySelector('.callback-modal__desc');
        titleElement.innerHTML = data.title || defaultTitle;
        descElement.textContent = data.desc || defaultDesc;
    });
}());