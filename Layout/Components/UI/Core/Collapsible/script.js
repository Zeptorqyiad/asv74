class Collapsible {
    constructor(options = {}) {
        const defaults = {
            selector: '.collapsible',
            buttonClass: 'collapsible__trigger',
            contentClass: 'collapsible__menu',
            activeClass: 'active',
            multipleOpen: false
        };

        this.options = { ...defaults, ...options };
        this.panels = document.querySelectorAll(this.options.selector);
        this.init();
    }

    init() {
        if (!this.panels.length) {
            console.warn(`No collapsible panels found with selector: ${this.options.selector}`);
            return;
        }

        this.panels.forEach(panel => {
            const toggleButton = panel.querySelector(`.${this.options.buttonClass}`);
            const content = panel.querySelector(`.${this.options.contentClass}`);

            if (!toggleButton || !content) {
                console.warn('Panel missing required elements:', panel);
                return;
            }

            toggleButton.addEventListener('click', (e) => this.handleClick(e, panel, toggleButton));

            content.addEventListener('click', (e) => e.stopPropagation());
        });
    }

    handleClick(event, panel, toggleButton) {
        event.preventDefault();

        const isActive = panel.classList.contains(this.options.activeClass);

        if (!this.options.multipleOpen) {
            this.closeOthers(panel);
        }

        this.toggleState(panel, toggleButton, !isActive);
    }

    closeOthers(exceptPanel) {
        this.panels.forEach(panel => {
            if (panel !== exceptPanel && panel.classList.contains(this.options.activeClass)) {
                const button = panel.querySelector(`.${this.options.buttonClass}`);
                this.toggleState(panel, button, false);
            }
        });
    }

    toggleState(panel, button, active) {
        panel.classList.toggle(this.options.activeClass, active);
        button.classList.toggle(this.options.activeClass, active);
    }
}

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    const collapsible = new Collapsible({
        multipleOpen: true
    });
});