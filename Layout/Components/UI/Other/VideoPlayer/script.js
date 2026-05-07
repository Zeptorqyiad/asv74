/**
 * @fileoverview Enhanced video player management script with performance optimizations
 */

(function () {
    'use strict';

    // Configuration constants
    const CONFIG = {
        SELECTORS: {
            VIDEO_PLAYER: '.video-player',
            PLAY_BUTTON: '.video-player__play-button',
            VIDEO: '.video-player__content',
            IFRAME: 'iframe',
            SOURCE: 'source'
        },
        TOUCH_CLICK_THRESHOLD: 200
    };

    /**
     * VideoPlayerManager - Core class to handle all video player functionality
     */
    class VideoPlayerManager {
        /**
         * Creates a new VideoPlayerManager instance
         */
        constructor() {
            this.players = [];
            this.initialized = false;
        }

        /**
         * Initialize the video player system
         */
        init() {
            if (this.initialized) return;

            const videoBlocks = document.querySelectorAll(CONFIG.SELECTORS.VIDEO_PLAYER);
            if (!videoBlocks.length) return;

            videoBlocks.forEach(block => {
                const player = {
                    element: block,
                    identifier: this.getVideoIdentifier(block),
                    isExternal: block.querySelector(CONFIG.SELECTORS.IFRAME) !== null,
                    isPlaying: false
                };

                if (player.identifier) {
                    this.players.push(player);

                    if (!player.isExternal) {
                        this.setupLocalVideo(player);
                    }
                }
            });

            document.addEventListener('visibilitychange', () => {
                if (document.hidden) {
                    this.pauseAllVideos();
                }
            });

            this.initialized = true;
        }

        /**
         * Get unique identifier for video
         * @param {HTMLElement} videoBlock - Video player container
         * @returns {string|null} Video URL or null
         */
        getVideoIdentifier(videoBlock) {
            const iframe = videoBlock.querySelector(CONFIG.SELECTORS.IFRAME);
            if (iframe && iframe.src) return iframe.src;

            const video = videoBlock.querySelector('video');
            if (!video) return null;

            const source = video.querySelector(CONFIG.SELECTORS.SOURCE);
            return source && source.src ? source.src : (video.src || null);
        }

        /**
         * Setup local video with controls and event handlers
         * @param {Object} player - Player object
         */
        setupLocalVideo(player) {
            const videoEl = player.element.querySelector('video');
            const playButton = player.element.querySelector(CONFIG.SELECTORS.PLAY_BUTTON);

            if (!videoEl || !playButton) return;

            player.videoEl = videoEl;
            player.playButton = playButton;

            // Media events
            videoEl.addEventListener('play', () => this.handleVideoPlay(player));
            videoEl.addEventListener('pause', () => this.handleVideoPause(player));
            videoEl.addEventListener('ended', () => this.handleVideoEnded(player));

            // UI events
            playButton.addEventListener('click', (e) => {
                e.stopPropagation();
                this.playVideo(player);
            });

            videoEl.addEventListener('click', (e) => {
                if (e.target === videoEl) {
                    e.preventDefault();
                    if (!player.isPlaying) {
                        this.playVideo(player);
                    } else {
                        this.pauseVideo(player);
                    }
                }
            });

            let touchStartTime;
            videoEl.addEventListener('touchstart', () => {
                touchStartTime = Date.now();
            });

            videoEl.addEventListener('touchend', (e) => {
                const touchDuration = Date.now() - touchStartTime;
                if (touchDuration < CONFIG.TOUCH_CLICK_THRESHOLD && e.target === videoEl) {
                    e.preventDefault();
                    if (!player.isPlaying) {
                        this.playVideo(player);
                    } else {
                        this.pauseVideo(player);
                    }
                }
            });
        }

        /**
         * Handle video play event
         * @param {Object} player - Player object
         */
        handleVideoPlay(player) {
            player.isPlaying = true;
            this.toggleControls(player, true);

            // Pause other players with same content
            this.players.forEach(otherPlayer => {
                if (otherPlayer !== player && otherPlayer.identifier === player.identifier) {
                    this.pauseVideo(otherPlayer);
                }
            });
        }

        /**
         * Handle video pause event
         * @param {Object} player - Player object
         */
        handleVideoPause(player) {
            if (!player.videoEl.seeking) {
                player.isPlaying = false;
                this.toggleControls(player, false);
            }
        }

        /**
         * Handle video ended event
         * @param {Object} player - Player object
         */
        handleVideoEnded(player) {
            player.isPlaying = false;
            this.toggleControls(player, false);
        }

        /**
         * Toggle video controls display
         * @param {Object} player - Player object
         * @param {boolean} showControls - Whether to show video controls
         */
        toggleControls(player, showControls) {
            if (player.videoEl) {
                player.videoEl.controls = showControls;
            }

            if (player.playButton) {
                player.playButton.style.display = showControls ? 'none' : 'block';
            }
        }

        /**
         * Play a video
         * @param {Object} player - Player object
         */
        playVideo(player) {
            if (!player.videoEl) return;

            // Stop other videos first
            this.pauseAllVideos();

            player.videoEl.play()
                .then(() => {
                    player.isPlaying = true;
                    this.toggleControls(player, true);
                })
                .catch(error => {
                    console.warn('Video playback error:', error.message);
                });
        }

        /**
         * Pause a video
         * @param {Object} player - Player object
         */
        pauseVideo(player) {
            if (!player.videoEl) return;

            player.videoEl.pause();
            player.isPlaying = false;
            this.toggleControls(player, false);
        }

        /**
         * Pause all videos on the page
         */
        pauseAllVideos() {
            this.players.forEach(player => {
                if (!player.isExternal && player.isPlaying) {
                    this.pauseVideo(player);
                }
            });
        }

        /**
         * Check if element is in viewport
         * @param {HTMLElement} element - Element to check
         * @returns {boolean} True if visible
         */
        isElementInViewport(element) {
            const rect = element.getBoundingClientRect();
            const windowHeight = window.innerHeight || document.documentElement.clientHeight;
            const windowWidth = window.innerWidth || document.documentElement.clientWidth;

            return (
                rect.top >= 0 &&
                rect.left >= 0 &&
                rect.bottom <= windowHeight &&
                rect.right <= windowWidth
            );
        }
    }

    // Initialize when DOM is ready
    document.addEventListener('DOMContentLoaded', () => {
        const manager = new VideoPlayerManager();
        manager.init();

        window.videoPlayerManager = manager;
    });
})();