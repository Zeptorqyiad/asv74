<?php
/** @var array $data */
$images = [];

if($data['items']):
    $images = array_filter($data['items'], fn($item) => $item['img'] !== '');
endif;
?>

<?php if (!empty($images)): ?>
    <script>
        const arrVisual = [];
    </script>
<?php endif; ?>

<div class="product-visual-section">
    <div class="product-visual-section__container wrapper-sm">
        <?php if($data['items']): foreach ($data['items'] as $key => $item): ?>
            <?php if($item['img']) :?>
                <div class="product-visual-section__panorama-wrap" id="prod-visual-pan_<?= $key ?>"></div>
                <script>
                    arrVisual.push({
                        container: 'prod-visual-pan_<?= $key ?>',
                        panorama: '<?= $item['img'] ?>'
                    })
                </script>
            <?php endif; ?>

            <?php if($item['iframe']) :?>
                <iframe
                    class="product-visual-section__panorama-wrap"
                    src="<?= $item['iframe'] ?>"
                    frameborder="0"
                    loading="lazy"
                    onerror="this.src=null;this.src='/assets/images/placeholders/fallback-img.webp'"
                ></iframe>
            <?php endif; ?>
        <?php endforeach; endif; ?>
    </div>
</div>

<?php if (!empty($images)): ?>
    <script type="module">
        import { Viewer } from '@photo-sphere-viewer/core';

        (async function () {
            arrVisual.forEach(({ container, panorama }) => {
                new Viewer({
                    container,
                    panorama,
                    navbar: ['zoom', 'move', 'fullscreen'],
                    defaultZoomLvl: 0,
                    minFov: 30,
                    maxFov: 100,
                    moveSpeed: 1,
                    touchmoveTwoFingers: true,
                    mousewheelCtrlKey: true
                })
            })
        })();
    </script>
<?php endif; ?>