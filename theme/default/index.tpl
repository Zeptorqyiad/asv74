<!DOCTYPE html>
<html lang="ru">
<head>
    <!-- Initial -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="view-transition" content="same-origin">

    <!-- Favicon -->
    <link rel="apple-touch-icon" href="/assets/meta/favicon/apple-touch-icon.png">
    <link rel="icon" href="/assets/meta/favicon/favicon.ico" sizes="any">
    <link rel="icon" href="/assets/meta/favicon/icon.svg" type="image/svg+xml">

    <!-- Theme -->
    <meta name="theme-color" content="#DB1E16">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="#DB1E16">
    <meta name="msapplication-TileColor" content="#DB1E16">

    <!-- Fonts preload -->
    <link rel="preload" href="/assets/fonts/Commissioner/Commissioner-VF.ttf" as="font" type="font/ttf" crossorigin>
    <link rel="preload" href="/assets/fonts/Commissioner/Commissioner-BoldItalic.ttf" as="font" type="font/ttf" crossorigin>

    <!-- Info data -->
    <link rel="manifest" href="/assets/meta/manifest.webmanifest">
    <link rel="yandex-tableau-widget" href="/assets/meta/tableau.json">

    <!--  Scripts  -->
    <link rel="preconnect" href="https://cdn.sn9.ru" crossorigin>
    <link rel="dns-prefetch" href="https://cdn.sn9.ru">

    <link rel="preload" href="https://cdn.sn9.ru/lib/fancybox/5.0/fancybox.css" as="style">
    <link rel="stylesheet" href="https://cdn.sn9.ru/lib/fancybox/5.0/fancybox.css">
    <link rel="preload" href="https://cdn.sn9.ru/lib/fancybox/5.0/fancybox.umd.js" as="script">
    <script src="https://cdn.sn9.ru/lib/fancybox/5.0/fancybox.umd.js" defer></script>

    <link rel="preload" href="https://cdn.sn9.ru/lib/swiper/11.2.6/swiper-bundle.min.css" as="style">
    <link rel="stylesheet" href="https://cdn.sn9.ru/lib/swiper/11.2.6/swiper-bundle.min.css">
    <link rel="preload" href="https://cdn.sn9.ru/lib/swiper/11.2.6/swiper-bundle.min.js" as="script">
    <script src="https://cdn.sn9.ru/lib/swiper/11.2.6/swiper-bundle.min.js" defer></script>

    <link rel="preload" href="https://cdn.sn9.ru/lib/simplebar/6.3.0/simplebar.min.css" as="style">
    <link rel="stylesheet" href="https://cdn.sn9.ru/lib/simplebar/6.3.0/simplebar.min.css">
    <link rel="preload" href="https://cdn.sn9.ru/lib/simplebar/6.3.0/simplebar.min.js" as="script">
    <script src="https://cdn.sn9.ru/lib/simplebar/6.3.0/simplebar.min.js" defer></script>

    <script type="importmap">
        {
            "imports": {
                "three": "https://cdn.sn9.ru/lib/three/0.174.0/three.module.min.js",
                "@photo-sphere-viewer/core": "https://cdn.sn9.ru/lib/photo-sphere-viewer/5.12.1/index.module.js"
            }
        }
    </script>
    <link rel="stylesheet" href="https://cdn.sn9.ru/lib/photo-sphere-viewer/5.12.1/index.css">

    <!-- Canonical URL -->
    <link rel="canonical" href="<?= url(Simflex\Core\Container::getRequest()->getPath()) ?>">

    <!-- Main meta data -->
    <?php Simflex\Core\Page::meta(); ?>
    <meta name="application-name" content="{site_name}">
    <meta name="description" content="<?= Simflex\Core\Page::$override['description'] ?>">
    <meta name="keywords" content="<?= Simflex\Core\Page::$override['keywords'] ?>">
    <meta name="robots" content="index, follow">

    <!-- Structured data -->
    <script type="application/ld+json">
        {
            "@context": "https://schema.org",
            "@type": "WebPage",
            "name": "{site_name}",
            "description": "<?= Simflex\Core\Page::$override['description'] ?>",
            "url": "<?= url('') ?>",
            "logo": "<?= url('/assets/meta/favicon/icon.svg') ?>",
            "sameAs": [
                "<?= Simflex\Core\Core::siteParam('tg') ?>",
                "<?= Simflex\Core\Core::siteParam('vk') ?>",
                "<?= Simflex\Core\Core::siteParam('whats_app') ?>"
            ],
            "telephone": "{phone}",
            "email": "{email}",
            "openingHours": "{workhours}"
        }
    </script>

    <!-- Speculation rules -->
    <script type="speculationrules">
        {
          "prerender": [
            {
              "where": {
                "and": [
                  { "href_matches": "/*" },
                  {
                    "not": {
                      "selector_matches": "[data-no-prerender]"
                    }
                  }
                ]
              }
            }
          ]
        }
    </script>

    <!-- Open Graph data -->
    <meta property="og:type" content="website">
    <meta property="og:title" content="<?= Simflex\Core\Page::$override['title'] ?>">
    <meta property="og:url" content="<?= url(Simflex\Core\Container::getRequest()->getPath()) ?>">
    <meta property="og:description" content="<?= Simflex\Core\Page::$override['description'] ?>">
    <meta property="og:site_name" content="{site_name}">
    <meta property="og:locale" content="ru_RU"/>
    <meta property="og:image" content="<?= url('/assets/meta/og-image.png') ?>">
    <meta property="og:image:type" content="image/png">
    <meta property="og:image:width" content="2400">
    <meta property="og:image:height" content="1260">
    <meta property="vk:image" content="<?= url('/assets/meta/og-image.png') ?>">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:image" content="<?= url('/assets/meta/og-image.png') ?>">

    <!-- Noscript styles -->
    <noscript>
        <style>
            .simplebar-content-wrapper {
                scrollbar-width: auto;
                -ms-overflow-style: auto;
            }

            .simplebar-content-wrapper::-webkit-scrollbar,
            .simplebar-hide-scrollbar::-webkit-scrollbar {
                display: initial;
                width: initial;
                height: initial;
            }
        </style>
    </noscript>

    <!-- Analytics tools -->
    <?php if(!strpos($_SERVER['SERVER_NAME'], 'et9.ru')): ?>
        <!-- Yandex.Metrika counter -->
        <script type="text/javascript" >
            (function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
                m[i].l=1*new Date();
                for (var j = 0; j < document.scripts.length; j++) {if (document.scripts[j].src === r) { return; }}
                k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)})
            (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

            ym(101391549, "init", {
                clickmap:true,
                trackLinks:true,
                accurateTrackBounce:true,
                webvisor:true,
                ecommerce:"dataLayer"
            });
        </script>
        <noscript><div><img src="https://mc.yandex.ru/watch/101391549" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
        <!-- /Yandex.Metrika counter -->

        <script src="//code.jivosite.com/widget/QDlrtZjt1q" async></script>

        <!-- Top.Mail.Ru counter -->
        <script type="text/javascript">
            var _tmr = window._tmr || (window._tmr = []);
            _tmr.push({id: "3682559", type: "pageView", start: (new Date()).getTime()});
            (function (d, w, id) {
                if (d.getElementById(id)) return;
                var ts = d.createElement("script"); ts.type = "text/javascript"; ts.async = true; ts.id = id;
                ts.src = "https://top-fwz1.mail.ru/js/code.js";
                var f = function () {var s = d.getElementsByTagName("script")[0]; s.parentNode.insertBefore(ts, s);};
                if (w.opera == "[object Opera]") { d.addEventListener("DOMContentLoaded", f, false); } else { f(); }
            })(document, window, "tmr-code");
        </script>
        <noscript><div><img src="https://top-fwz1.mail.ru/counter?id=3682559;js=na" style="position:absolute;left:-9999px;" alt="Top.Mail.Ru" /></div></noscript>
        <!-- /Top.Mail.Ru counter -->

        <script src="//cdn.callibri.ru/callibri.js" type="text/javascript" charset="utf-8" defer></script>
    <?php endif; ?>
</head>
<body>
<?php
\Simflex\Core\Page::content(); ?>

<?php
\Simflex\Core\Page::metaJS(); ?>
</body>
</html>
