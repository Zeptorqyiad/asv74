(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function() {
        const scrollButton = document.querySelector('.button-scroll');
        const screenHeight = window.innerHeight;

        if (!scrollButton) return;

        function toggleButtonVisibility() {
            if (window.scrollY > screenHeight) {
                scrollButton.classList.add('active');
            } else {
                scrollButton.classList.remove('active');
            }
        }

        toggleButtonVisibility();
        window.addEventListener('scroll', toggleButtonVisibility);

        scrollButton.addEventListener('click', function() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    });
})();