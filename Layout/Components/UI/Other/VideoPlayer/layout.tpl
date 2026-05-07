<?php
/** @var array $data */

$file = $data['src'];
$fileType = pathinfo($file, PATHINFO_EXTENSION);

?>

<?php if ($data['src'] || $data['link'] || $data['poster']): ?>
    <div class="video-player <?= $data['className'] ?>">
        <div class="video-player__container">
            <?php if (!$data['link']): ?>
                <video class="video-player__content"
                       playsinline
                       <?= buildAttrs($data['attributes'] ?? []) ?>
                       poster="<?= $data['poster'] ?>">
                    <source src="<?= $file ?>" type="video/<?= $fileType ?>">
                    Ваш браузер не поддерживает видео.
                </video>

                <button class="video-player__play-button" aria-label="Включить видео">
                    <div class="video-player__play-button-container">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="#F2F2F2" viewBox="0 0 24 24">
                            <path d="M16.57 12.857a1 1 0 0 0 0-1.714L9.515 6.909A1 1 0 0 0 8 7.766v8.468a1 1 0 0 0 1.514.857l7.057-4.234Z"/>
                        </svg>
                    </div>
                </button>
            <?php else: ?>
                <iframe loading="lazy"
                        class="video-player__content"
                        src="<?= $data['link'] ?>"
                        frameborder="0"
                        allow="encrypted-media; fullscreen; picture-in-picture"
                        data-src="<?= $data['link'] ?>">
                </iframe>
            <?php endif; ?>
        </div>
    </div>
<?php endif; ?>