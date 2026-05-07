<?php
/** @var array $data */

?>



<template id="tour-close-btn">
    <?php
    App\Layout\Components\UI\Core\Buttons\Button\Layout::drawButton(
        text: 'Закрыть',
        icon: 'close',
        iconPos: \App\Layout\Components\UI\Core\Buttons\Button\ButtonIconPos::Right,
    );
    ?>
</template>

<div>
    <style>
        main {
            flex-wrap: wrap;
            justify-content: center;
        }
    </style>

    <?php
    App\Layout\Components\Common\PageHeading\Layout::drawPageHeading(
        title: '3D экскурсия'
    );
    ?>

    <div class="container" id="galleryContainer"></div>

    <script type="module">
        import {Viewer} from '@photo-sphere-viewer/core';

        (async function () {
            // Sample panorama image array
            const panoramas = [
                {
                    url: '/assets/images/tour/key-biscayne-1.jpg',
                    caption: 'Parc national du Mercantour',
                    preview: '/assets/images/tour/key-biscayne-4.jpg'
                },
                {
                    url: '/assets/images/tour/key-biscayne-2.jpg',
                    caption: 'Mountain Landscape',
                    preview: '/assets/images/tour/key-biscayne-2.jpg'
                },
                {
                    url: '/assets/images/tour/key-biscayne-3.jpg',
                    caption: 'Mountain Landscape',
                    preview: '/assets/images/tour/key-biscayne-3.jpg'
                },
                {
                    url: '/assets/images/tour/key-biscayne-4.jpg',
                    caption: 'Mountain Landscape',
                    preview: '/assets/images/tour/key-biscayne-4.jpg'
                },
                {
                    url: '/assets/images/tour/test-sphere.jpg',
                    caption: 'Mountain Landscape',
                    preview: '/assets/images/tour/test-sphere.jpg'
                },
                {
                    url: '/assets/images/tour/tour-1.jpg',
                    caption: 'Mountain Landscape',
                    preview: '/assets/images/tour/tour-1.jpg'
                },
            ];

            function createGallery(images) {
                const container = document.getElementById('galleryContainer');

                images.forEach((image, index) => {
                    // Create gallery container
                    const galleryItem = document.createElement('div');
                    galleryItem.className = 'gallery-container';
                    galleryItem.setAttribute('data-index', index);

                    // Create preview image
                    const previewImg = document.createElement('img');
                    previewImg.src = image.preview;
                    previewImg.className = 'gallery-preview';
                    previewImg.alt = image.caption;

                    // Append preview to container
                    galleryItem.appendChild(previewImg);

                    // Add click event to open panorama
                    galleryItem.addEventListener('click', () => {
                        openPanorama(image);
                    });

                    container.appendChild(galleryItem);
                });
            }

            function openPanorama(imageData) {
                // Remove existing viewer if present
                const existingViewer = document.getElementById('viewer');
                if (existingViewer) existingViewer.remove();

                document.body.style.overflow = 'hidden';

                // Create new viewer container
                const viewerContainer = document.createElement('div');
                viewerContainer.id = 'viewer';
                viewerContainer.style.position = 'fixed';
                viewerContainer.style.top = '0';
                viewerContainer.style.left = '0';
                viewerContainer.style.width = '100%';
                viewerContainer.style.height = '100%';
                viewerContainer.style.zIndex = '1000';
                viewerContainer.style.background = 'rgba(0,0,0,0.9)';

                const buttonTemplate = document.getElementById('tour-close-btn');
                const buttonTemplateContent = buttonTemplate.content.cloneNode(true);

                const closeBtn = buttonTemplateContent.querySelector('button');
                closeBtn.style.position = 'absolute';
                closeBtn.style.top = '10px';
                closeBtn.style.right = '10px';
                closeBtn.style.zIndex = '10';

                viewerContainer.appendChild(buttonTemplateContent);
                document.body.appendChild(viewerContainer);

                // Create Photo Sphere Viewer
                const viewer = new Viewer({
                    container: viewerContainer,
                    panorama: imageData.url,
                    caption: imageData.caption,
                    navbar: ['zoom', 'move', 'caption', 'fullscreen'],
                });

                // Close viewer when close button clicked
                closeBtn.addEventListener('click', () => {
                    document.body.style.overflow = '';
                    viewer.destroy();
                    viewerContainer.remove();
                });
            }

            // Initialize gallery
            createGallery(panoramas);
        })();
    </script>
</div>
