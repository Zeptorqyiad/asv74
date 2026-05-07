<?php
/** @var array $data */

$buttonSocialClasses = [
    'btn-social',
    "btn-social-type--{$data['type']}",
    "btn-social-size--{$data['size']}",
    "btn-social-theme--{$data['theme']}",
    $data['className'] ?? ''
];

if (!function_exists('autoGenerateSvgUniqueIds')) {
    /**
     * Automatically generates unique IDs for any id attributes and corresponding url() references in an SVG.
     *
     * @param string $svg The SVG markup.
     * @return string The SVG markup with unique IDs.
     */
    function autoGenerateSvgUniqueIds(string $svg): string
    {
        $uniqueIds = [];

        $svg = preg_replace_callback('/(id\s*=\s*")([^"]+)(")/i', static function ($matches) use (&$uniqueIds) {
            $originalId = $matches[2];

            $newId = uniqid($originalId . '-');

            $uniqueIds[$originalId] = $newId;
            return $matches[1] . $newId . $matches[3];
        }, $svg);

        return preg_replace_callback('/(url\(#)([^)]+)(\))/', static function ($matches) use ($uniqueIds) {
            $originalId = $matches[2];
            if (isset($uniqueIds[$originalId])) {
                return $matches[1] . $uniqueIds[$originalId] . $matches[3];
            }
            return $matches[0];
        }, $svg);
    }
}

if (!function_exists('getButtonSocialSvgContent')) {
    function getButtonSocialSvgContent($icon): string
    {
        $svgContent = [
            'vk' => '<svg class="btn-social__icon btn-social-type--vk" xmlns="http://www.w3.org/2000/svg" fill="#07F" viewBox="0 0 24 24">
                        <path d="M12.982 19C5.466 19 1.18 13.745 1 5h3.765c.124 6.418 2.9 9.137 5.098 9.698V5h3.546v5.536c2.17-.239 4.452-2.761 5.221-5.536h3.546a10.79 10.79 0 0 1-1.698 4.002 10.558 10.558 0 0 1-3.126 2.977 10.895 10.895 0 0 1 3.563 2.893A11.153 11.153 0 0 1 23 19h-3.903a6.94 6.94 0 0 0-2.104-3.377 6.726 6.726 0 0 0-3.584-1.626V19h-.427Z"/>
                    </svg>',
            'tg' => '<svg class="btn-social__icon btn-social-type--tg" xmlns="http://www.w3.org/2000/svg" fill="#27A6E5" viewBox="0 0 24 24">
                        <path d="m21 4.602-3.005 15.69s-.42 1.088-1.576.566l-6.934-5.505-.033-.017c.937-.87 8.2-7.633 8.518-7.94.491-.475.186-.757-.384-.399l-10.73 7.056-4.138-1.442s-.652-.24-.714-.762c-.064-.523.735-.805.735-.805l16.874-6.855S21 3.558 21 4.602Z"/>
                    </svg>',
            'wt' => '<svg class="btn-social__icon btn-social-type--wt" xmlns="http://www.w3.org/2000/svg" fill="#48C95F" viewBox="0 0 24 24">
                        <path d="M19.927 4.063A10.428 10.428 0 0 0 12.537 1C6.757 1 2.073 5.667 2.073 11.427c0 1.823.512 3.646 1.39 5.177L2 22l5.561-1.458c1.537.802 3.22 1.24 4.976 1.24 5.78 0 10.463-4.667 10.463-10.428-.073-2.698-1.098-5.323-3.073-7.291Zm-2.342 11.083c-.22.583-1.244 1.166-1.756 1.24a4.104 4.104 0 0 1-1.61-.073c-.365-.146-.877-.292-1.463-.584-2.634-1.094-4.317-3.719-4.463-3.937-.147-.146-1.098-1.386-1.098-2.698 0-1.313.659-1.896.878-2.188.22-.291.512-.291.732-.291h.512c.146 0 .366-.073.585.437.22.51.732 1.823.805 1.896a.463.463 0 0 1 0 .437 1.527 1.527 0 0 1-.292.438c-.147.146-.293.364-.366.437-.147.146-.293.292-.147.51.147.293.659 1.095 1.464 1.824 1.024.875 1.83 1.166 2.122 1.312.293.146.439.073.585-.073.146-.146.659-.729.805-1.02.146-.292.366-.22.585-.146.22.073 1.537.729 1.757.875.292.146.439.218.512.291.073.22.073.73-.147 1.313Z"/>
                    </svg>',
            'ya' => '<svg class="btn-social__icon btn-social-type--ya" xmlns="http://www.w3.org/2000/svg" fill="#FC3F1D" viewBox="0 0 24 24">
                        <path fill-rule="evenodd" d="M9.66 2.555c-2.762 1.002-4.08 2.947-4.08 6.02 0 2.286.593 3.596 2.393 5.285.769.722 1.398 1.385 1.398 1.474 0 .088-.984 1.625-2.186 3.413L5 22h3.743l2.032-3.082a829.306 829.306 0 0 0 2.495-3.802l.464-.718-1.299-.842c-2.62-1.695-3.608-3.178-3.608-5.414 0-2.23 2.099-3.676 5.334-3.676h.642V22h3.53V2l-3.598.01c-2.869.008-3.899.118-5.075.545Z" clip-rule="evenodd"/>
                    </svg>',
            'in' => '<svg class="btn-social__icon btn-social-type--in" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                    <path class="icon-path-1" fill="url(#inst-gr-1)" d="M7.75 12a4.25 4.25 0 1 1 8.5 0 4.25 4.25 0 0 1-8.5 0Z"/>
                    <path class="icon-path-2" fill="url(#inst-gr-2)" fill-rule="evenodd" d="M8 2a6 6 0 0 0-6 6v8a6 6 0 0 0 6 6h8a6 6 0 0 0 6-6V8a6 6 0 0 0-6-6H8Zm4 4.25a5.75 5.75 0 1 0 0 11.5 5.75 5.75 0 0 0 0-11.5Z" clip-rule="evenodd"/>
                        <defs>
                            <radialGradient id="inst-gr-1" cx="0" cy="0" r="1" gradientTransform="translate(22.402 2.406) scale(46.1859)" gradientUnits="userSpaceOnUse">
                                <stop stop-color="#F9ED32"/>
                                <stop offset=".36" stop-color="#EE2A7B"/>
                                <stop offset=".44" stop-color="#D22A8A"/>
                                <stop offset=".6" stop-color="#8B2AB2"/>
                                <stop offset=".83" stop-color="#1B2AF0"/>
                                <stop offset=".88" stop-color="#002AFF"/>
                            </radialGradient>
                            <radialGradient id="inst-gr-2" cx="0" cy="0" r="1" gradientTransform="translate(22.402 2.406) scale(46.1859)" gradientUnits="userSpaceOnUse">
                                <stop stop-color="#F9ED32"/>
                                <stop offset=".36" stop-color="#EE2A7B"/>
                                <stop offset=".44" stop-color="#D22A8A"/>
                                <stop offset=".6" stop-color="#8B2AB2"/>
                                <stop offset=".83" stop-color="#1B2AF0"/>
                                <stop offset=".88" stop-color="#002AFF"/>
                            </radialGradient>
                        </defs>
                    </svg>',
            'go' => '<svg class="btn-social__icon btn-social-type--go" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <path class="icon-path-1" fill="#4285F4" fill-rule="evenodd" d="M22 12.227c0-.709-.065-1.39-.186-2.045h-9.61v3.868h5.492c-.237 1.25-.956 2.31-2.037 3.018v2.51h3.298c1.93-1.742 3.043-4.305 3.043-7.35Z" clip-rule="evenodd"/>
                        <path class="icon-path-2" fill="#34A853" fill-rule="evenodd" d="M12.208 22c2.755 0 5.065-.895 6.754-2.423l-3.298-2.509c-.914.6-2.083.955-3.456.955-2.657 0-4.907-1.76-5.71-4.123H3.09v2.59C4.77 19.76 8.22 22 12.21 22Z" clip-rule="evenodd"/>
                        <path class="icon-path-3" fill="#FFCE21" fill-rule="evenodd" d="M6.494 13.9a5.903 5.903 0 0 1-.32-1.9c0-.66.116-1.3.32-1.9V7.509H3.085a9.834 9.834 0 0 0 0 8.982l3.41-2.591Z" clip-rule="evenodd"/>
                        <path class="icon-path-4" fill="#EA4335" fill-rule="evenodd" d="M12.208 5.977c1.498 0 2.844.505 3.901 1.496l2.927-2.868C17.269 2.99 14.959 2 12.208 2 8.22 2 4.768 4.24 3.09 7.51L6.5 10.1c.802-2.364 3.052-4.123 5.71-4.123Z" clip-rule="evenodd"/>
                    </svg>',
            'rt' => '<svg class="btn-social__icon btn-social-type--rt" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <mask id="rt-mask-1" width="20" height="20" x="2" y="2" maskUnits="userSpaceOnUse" style="mask-type:luminance">
                            <path class="icon-path-1" fill="#fff" d="M17.151 2H6.848A4.848 4.848 0 0 0 2 6.848v10.303A4.848 4.848 0 0 0 6.848 22h10.303A4.848 4.848 0 0 0 22 17.151V6.848A4.848 4.848 0 0 0 17.151 2Z"/>
                        </mask>
                        <g mask="url(#rt-mask-1)">
                            <path class="icon-path-2" fill="#100943" d="M8.445 11.543h5.909c.345 0 .585-.044.706-.149.12-.105.195-.3.195-.6v-.839c0-.285-.075-.48-.195-.585-.12-.105-.36-.165-.706-.165H8.445v2.338Z"/>
                            <path class="icon-path-3" fill="#100943" fill-rule="evenodd" d="M2 2h20v20H2V2Zm3.94 5h8.82c.554 0 1.004.06 1.365.165.36.12.66.3.93.555.255.27.435.57.54.914.105.345.166.795.166 1.364v.75c0 .96-.166 1.679-.496 2.129-.33.45-.73.723-1.62.855L18.06 17h-2.806l-2.192-3.253H8.445V17H5.94V7Z" clip-rule="evenodd"/>
                            <path class="icon-path-4" fill="#ED143B" d="M32 2c0 5.523-4.477 10-10 10a9.962 9.962 0 0 1-4.246-.943c.005-.1.006-.203.006-.31v-.749c0-.57-.06-1.019-.165-1.364a2.271 2.271 0 0 0-.54-.914 2.442 2.442 0 0 0-.93-.555c-.36-.105-.811-.164-1.366-.164h-1.42A9.955 9.955 0 0 1 12 2c0-5.523 4.477-10 10-10S32-3.523 32 2Z"/>
                        </g>
                    </svg>',
            'yt' => '<svg class="btn-social__icon btn-social-type--yt" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <path class="icon-path-1" fill="#F03" d="M11.987 20s7.519 0 9.384-.48c1.05-.272 1.84-1.056 2.117-2.024C24 15.72 24 11.984 24 11.984s0-3.712-.512-5.472c-.278-.992-1.067-1.76-2.117-2.024C19.506 4 11.987 4 11.987 4s-7.501 0-9.358.488A2.975 2.975 0 0 0 .496 6.512C0 8.272 0 11.984 0 11.984s0 3.736.496 5.512c.294.968 1.1 1.752 2.133 2.024 1.857.48 9.358.48 9.358.48Z"/>
                        <path class="icon-path-2" fill="#fff" d="M15.724 12 9.517 8.6v6.8l6.207-3.4Z"/>
                    </svg>',
            'max' => '<svg class="btn-social__icon btn-social-type--max" xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 22 22" fill="none">
                          <path fill-rule="evenodd" clip-rule="evenodd" d="M11.2364 21.9372C9.07734 21.9372 8.074 21.6207 6.32997 20.3545C5.22682 21.7789 1.73352 22.8922 1.58118 20.9876C1.58118 19.5578 1.26599 18.3496 0.908784 17.0306C0.483284 15.4056 0 13.596 0 10.9739C0 4.71138 5.11651 0 11.1786 0C17.2459 0 21.9999 4.94352 21.9999 11.0319C22.0203 17.0262 17.2046 21.9052 11.2364 21.9372ZM11.3257 5.41308C8.37342 5.26008 6.07257 7.31241 5.56302 10.5307C5.14277 13.195 5.88871 16.4397 6.52434 16.6086C6.82901 16.6824 7.59597 16.0599 8.074 15.5798C8.86444 16.1282 9.78491 16.4576 10.7426 16.5347C13.8016 16.6825 16.4154 14.3435 16.6208 11.2746C16.7403 8.1992 14.3851 5.59435 11.3257 5.41836L11.3257 5.41308Z" fill="url(#paint0_radial_10409_24)"/>
                          <defs>
                            <radialGradient id="paint0_radial_10409_24" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(25.9774 3.68132) rotate(-3.91438) scale(47.3802)">
                              <stop offset="0.068816" stop-color="#9F4FDC"/>
                              <stop offset="0.186949" stop-color="#6C2FDE"/>
                              <stop offset="0.279643" stop-color="#5130E8"/>
                              <stop offset="0.42667" stop-color="#214EFA"/>
                              <stop offset="0.673154" stop-color="#43BBFC"/>
                            </radialGradient>
                          </defs>
                        </svg>',
        ];

        $svg = $svgContent[$icon] ?? '';

        if ($svg) {
            $svg = autoGenerateSvgUniqueIds($svg);
        }

        return $svg;
    }
}
?>

<a href="<?= $data['link'] ?>"
   class="<?= implode(' ', $buttonSocialClasses) ?>"
   target="_blank" <?= buildAttrs($data['attributes'] ?? []) ?>
   aria-label="<?= $data['type'] ?>"
>
    <?= getButtonSocialSvgContent($data['type']) ?>
</a>
