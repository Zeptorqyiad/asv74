(function () {
    'use strict';

    function genSpecs(spec) {
        let html = `<div class="table">
    <h4 class="table__title">${spec.name}</h4>

    <div class="table__wrap">
        <table class="table__content">
            <tbody class="table__body">`;

        for (const s of spec.values) {
            html += `<tr class="table__row">
                    <th class="table__cell table__cell--header">${s.name}</th>
                    <td class="table__cell">${s.value}</td>
                </tr>`;
        }

        html += `</tbody>
        </table>
    </div>
</div>
`;

        return html;
    }

    const specsModal = document.getElementById('specs-modal');

    specsModal.addEventListener('modalopen', function (event) {
        const data = event.detail || {};
        data.specs = JSON.parse(data.specs);

        const title = this.querySelector('.specs-modal__info-title');
        const body = this.querySelector('.specs-modal__body');
        const image = this.querySelector('.specs-modal__info-image');
        const link = this.querySelector('.specs-modal__button-about');
        const price = this.querySelector('.specs-modal__price--current');
        const oldPrice = this.querySelector('.specs-modal__price--old');
        const requestPrice = this.querySelector('.specs-modal__price--request');
        const a = this.querySelector('.spec-a');
        const b = this.querySelector('.spec-b');

        title.textContent = data.title;
        body.innerHTML = '';
        image.src = data.image;
        link.href = data.link;
        requestPrice.classList.toggle('hidden', !data.toOrder && parseInt(data.price));
        price.classList.toggle('hidden', data.toOrder || !parseInt(data.price));
        price.textContent = !data.toOrder && parseInt(data.price) > 0 ? `${data.price} ₽` : 'Узнайте цену сейчас';
        oldPrice.classList.toggle('hidden', data.price == data.priceOld);
        oldPrice.textContent = `${data.priceOld} ₽`;
        a.classList.toggle('hidden', requestPrice.classList.contains('hidden'));
        b.classList.toggle('hidden', price.classList.contains('hidden'));

        if (data.specs.p.length > 0) {
            body.innerHTML += '<h4 class="specs-modal__body-title">Основное</h4>';
            for (const i of data.specs.p) {
                body.innerHTML += genSpecs(i);
            }
        }

        if (data.specs.c.length > 0) {
            body.innerHTML += '<h4 class="specs-modal__body-title">Шасси</h4>';
            for (const i of data.specs.c) {
                body.innerHTML += genSpecs(i);
            }
        }

        if (data.specs.a.length > 0) {
            body.innerHTML += '<h4 class="specs-modal__body-title">Оборудование</h4>';
            for (const i of data.specs.a) {
                body.innerHTML += genSpecs(i);
            }
        }
    });
}());