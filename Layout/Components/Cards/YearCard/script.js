(function () {
    'use strict';

    const yearCards = document.querySelectorAll('.year-card');

    if (yearCards) {
        yearCards.forEach(card => {
            card.addEventListener('click', () => {
                if (card.classList.contains('active')) {
                    card.classList.remove('active');
                } else {
                    yearCards.forEach(card => {
                        card.classList.remove('active');
                    });
                    card.classList.add('active');
                }
            });
        });
    }
})();