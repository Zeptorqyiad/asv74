(function () {
    'use strict';

    const floatingVideos = document.querySelectorAll('.floating-video');

    if (!floatingVideos.length) return;

    floatingVideos.forEach(video => {
        const link = video.querySelector('.floating-video__link');
        const button = video.querySelector('.floating-video__button-close');

        if(link) {
            link.addEventListener('click', () => {
                video.remove();
            });
        }

        button.addEventListener('click', () => {
            video.remove();
        });
    });

})();