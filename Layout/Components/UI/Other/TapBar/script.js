const createDropdownItem = (key, name) => {
    const item = `
    <li class="dropdown-tab__option">
        <a 
            href="#${key}" 
            class="tab tab-secondary tab-size_s tab-theme_light dropdown-tab__link"
        >
            <span class="tab__text">${name}</span>
        </a>
    </li>`
    return item;
}

const cbClickLink = function (e) {
    e.preventDefault();

    window.location.hash = this.href;

    const id = this.getAttribute('href').slice(1);
    openGroupById(id);
}

document.addEventListener('DOMContentLoaded', () => {
    const tapbar = document.querySelector('.tap-bar--product');

    if(!tapbar) return;

    const productGroups = document.querySelectorAll('.product-layout__group ');
    const tapbarMenu = {};

    productGroups.forEach(group => {
        const sections = group.querySelectorAll('.js--prod-subsection');

        tapbarMenu[group.id] = {};
        sections.forEach(section => tapbarMenu[group.id][section.id] = section.dataset.title);
    });

    Object.keys(tapbarMenu).forEach(key => {
        const obj = tapbarMenu[key];
        const link = document.querySelector(`[href="#${key}"]`);
        const dropdown = link.closest('.tap-bar__button--anchor').querySelector('.dropdown-tab__menu');
        let html = '';

        if(link && !Object.keys(obj).length) {
            const chevron = link.querySelector('.dropdown-tab__chevron');

            if(!chevron) return;

            chevron.style.display = 'none';
            dropdown.remove();

            return;
        }

        Object.keys(obj).forEach(key => {
            html += createDropdownItem(key, obj[key]);
        });

        dropdown.innerHTML = '';
        dropdown.insertAdjacentHTML('afterbegin', html);
    });

    const anchors = document.querySelectorAll('.tap-bar--product a[href^="#"]');

    if(anchors.length) {
        anchors.forEach(link => link.addEventListener('click', cbClickLink));
    }

    tapbar.classList.add('show');
})