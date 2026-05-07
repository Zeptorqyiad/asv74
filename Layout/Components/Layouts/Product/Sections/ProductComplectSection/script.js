document.addEventListener('DOMContentLoaded', () => {
    const slider = document.querySelector('.js--product-variant-slider');

    if(!slider) return;

    swiperManager.create(slider, {
        loop: false,
        slidesPerView: 'auto',
    });
})