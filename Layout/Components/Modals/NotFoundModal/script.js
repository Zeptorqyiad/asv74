document.addEventListener('DOMContentLoaded', () => {
    const MODAL_KEY = 'not-found-modal-shown';
    const EXPIRE_DAYS = 1; // 24 часа

    function isCatalogPage() {
        return window.location.pathname.startsWith('/catalog/');
    }

    function isModalShownRecently() {
        const stored = localStorage.getItem(MODAL_KEY);
        if (!stored) return false;

        const timestamp = parseInt(stored, 10);
        const now = Date.now();
        const expireTime = now - (EXPIRE_DAYS * 24 * 60 * 60 * 1000);

        return timestamp > expireTime;
    }

    function saveModalShown() {
        localStorage.setItem(MODAL_KEY, Date.now().toString());
    }

    if (!isCatalogPage()) return;

    document.addEventListener('mousemove', (event) => {
        if (isModalShownRecently()) return;

        const clientX = event.clientX;
        const clientY = event.clientY;
        const viewportWidth = window.innerWidth;
        const viewportHeight = window.innerHeight;

        const threshold = 5; // Пиксели погрешности
        if (
            clientX <= threshold ||
            clientX >= (viewportWidth - threshold) ||
            clientY <= threshold ||
            clientY >= (viewportHeight - threshold)
        ) {
            const modal = document.getElementById('not-found-modal');
            if (!modal || !modal.classList.contains('active')) {
                modalManager.open('not-found-modal');
                saveModalShown();
            }
        }
    });
});