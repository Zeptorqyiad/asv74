(() => {
    'use strict';

    /**
     * Manages catalog panel navigation with improved performance
     */
    class CatalogNavigator {
        constructor() {
            this.wrap = document.querySelector('.catalog-modal__body-wrap');
            this.backButton = document.querySelector('.catalog-modal__button-back');
            this.panelCache = new Map();

            // Cache DOM elements for better performance
            this.cacheAllPanels();
            this.initEventListeners();
            this.hideBackButton();
        }

        /**
         * Cache all panel elements for faster access
         */
        cacheAllPanels() {
            document.querySelectorAll('.catalog-modal__panel').forEach(panel => {
                this.panelCache.set(panel.id, panel);
            });
        }

        /**
         * Initialize event listeners using delegation for better performance
         */
        initEventListeners() {
            // Single event listener using delegation instead of multiple handlers
            this.wrap.addEventListener('click', this.handlePanelClick.bind(this));
            this.backButton.addEventListener('click', this.handleBackClick.bind(this));
        }

        /**
         * Handle clicks within panels to navigate forward
         */
        handlePanelClick(event) {
            const tab = event.target.closest('.catalog-modal__tab-category[data-target]');
            if (!tab) return;

            const sourcePanel = tab.closest('.catalog-modal__panel');
            const targetPanelId = tab.getAttribute('data-target');

            this.navigateToPanel(sourcePanel.id, targetPanelId);
        }

        /**
         * Handle back button navigation
         */
        handleBackClick() {
            const currentPanel = this.getCurrentPanel();
            if (!currentPanel) return;

            const parentId = currentPanel.getAttribute('data-parent');
            if (!parentId) return;

            this.navigateToPanel(currentPanel.id, parentId);

            // Only hide back button if we're at the root panel
            if (parentId === 'panel-root') {
                this.hideBackButton();
            }
        }

        /**
         * Navigate from one panel to another
         */
        navigateToPanel(fromId, toId) {
            const fromPanel = this.panelCache.get(fromId);
            const toPanel = this.panelCache.get(toId);

            if (!fromPanel || !toPanel) return;

            fromPanel.classList.add('hidden');
            toPanel.classList.remove('hidden');

            // Always show back button when navigating forward
            this.showBackButton();
        }

        /**
         * Find currently visible panel
         */
        getCurrentPanel() {
            return [...this.panelCache.values()].find(panel =>
                !panel.classList.contains('hidden'));
        }

        /**
         * Show back navigation button
         */
        showBackButton() {
            this.backButton.classList.remove('hidden');
        }

        /**
         * Hide back navigation button
         */
        hideBackButton() {
            this.backButton.classList.add('hidden');
        }
    }

    // Initialize
    document.addEventListener('DOMContentLoaded', () => new CatalogNavigator());
})();