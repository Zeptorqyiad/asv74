<html lang="ru">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8"/>
    <style>
        @page {
            size: A4;
            margin: 2cm;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: DejaVu Sans, Arial, Helvetica, sans-serif;
        }

        body {
            line-height: 1.5;
            color: #333;
            padding: 2cm;
        }

        header {
            display: table;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 0.5cm;
            border-bottom: 1px solid #ccc;
            margin-bottom: 1cm;
            break-after: avoid;
        }

        header, footer {
            width: 100%;
        }

        h1, h2, h3, h4, h5, h6 {
            font-weight: 700;
            margin-bottom: 0.5cm;
            break-after: avoid;
        }

        h1 {
            font-size: 24pt;
            line-height: 1.2;
            color: #000;
        }

        h2 {
            font-size: 18pt;
            line-height: 1.3;
            color: #222;
            border-bottom: 1px solid #eee;
            padding-bottom: 0.2cm;
        }

        h3 {
            font-size: 14pt;
            line-height: 1.4;
            color: #333;
        }

        h4 {
            font-size: 12pt;
            line-height: 1.4;
            color: #444;
        }

        h5 {
            font-size: 11pt;
            line-height: 1.4;
            color: #555;
        }

        h6 {
            font-size: 10pt;
            line-height: 1.4;
            color: #666;
            font-style: italic;
        }

        header img {
            width: 250.5pt;
            height: 45pt;
        }

        section + section {
            margin-top: 1.5cm;
        }

        .print-header_left {
            display: table-cell;
            width: 63%;
            vertical-align: middle;
        }

        .contact-info {
            display: table-cell;
            width: 37%;
            border-left: 0.75pt solid #ccc;
            text-align: right;
            font-size: 10.5pt;
            font-weight: bold;
            font-style: italic;
            vertical-align: middle;
        }

        .contact-info__title {
            font-style: normal;
            font-weight: normal;
        }

        .hero {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            break-inside: avoid;
        }

        .hero-title {
            font-size: 24pt;
            margin-bottom: 0.5cm;
            text-align: left;
        }

        .hero-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 0.5cm;
        }

        .hero-description {
            text-align: left;
            max-width: 80%;
            font-size: 12pt;
        }

        .content-section {
            /*margin-bottom: 1cm;*/
            break-inside: avoid;
        }

        .section-title {
            font-size: 18pt;
            margin-bottom: 0.3cm;
            border-bottom: 1px solid #eee;
            padding-bottom: 0.2cm;
        }

        .section-content {
            display: flex;
            flex-direction: column;
            gap: 0.5cm;
        }

        .section-image {
            max-width: 100%;
            height: auto;
        }

        .section-description {
            flex: 1;

            ul, ol {
                margin: 1cm 0;
            }
        }

        .table-container {
            margin: 1cm 0;
            break-inside: avoid;
        }

        .table-title {
            font-size: 14pt;
            font-weight: bold;
            margin-bottom: 0.3cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 0.5cm;
        }

        th {
            background-color: #f2f2f2;
            border: 1px solid #ddd;
            padding: 0.2cm;
            text-align: left;
            font-weight: bold;
        }

        td {
            border: 1px solid #ddd;
            padding: 0.2cm;
            text-align: left;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        footer {
            margin-top: 1cm;
            padding-top: 0.5cm;
            border-top: 1px solid #ccc;
            font-size: 8pt;
            color: #666;
            break-before: auto;
            break-after: avoid;
        }

        .page-break {
            page-break-after: always;
            break-after: page;
        }

        @media print {
            a {
                text-decoration: none;
                color: #000;
            }

            .content {
                margin-top: 3cm;
                margin-bottom: 2cm;
            }

            @page {
                margin: 2cm;
            }

            body {
                padding: 0;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="print-header_left">
        <img src="<?= url('/assets/images/default/logo_new.png', [], true) ?>" alt="">
    </div>

    <div class="contact-info">
        <p class="contact-info__title">Связаться с нами: </p>
        <p><?= \Simflex\Core\Core::siteParam('phone') ?></p>
        <p><?= \Simflex\Core\Core::siteParam('email') ?></p>
    </div>
</header>

<main>
    <section class="hero">
        <h1 class="hero-title">
            <?= $p->name ?>
        </h1>

        <p><strong>Код: </strong> <?= $p->sku ?></p>
        <p><strong>Цена: </strong> <?= $p->price ? ($p->price . ' ₽') : 'Под заказ' ?></p><br/>

        <img src="<?= url($p->getImages()[0], [], true) ?>" alt="" class="hero-image">

        <div class="hero-description">
            <?= $p->desc ?: $p->description ?>
        </div>
    </section>

    <?php
    $prod = $p;
    if ($prod->plan): ?>
        <section class="content-section">
            <h2 class="section-title">Планировка</h2>
            <div class="section-content">
                <?php if ($prod->plan_photo): ?>
                    <img src="<?= url('/uf/images/source/' . $p->plan_photo, [], true) ?>" alt="" class="section-image">
                <?php endif; ?>
                <div class="section-description">
                    <?= $prod->plan ?>
                </div>
            </div>
        </section>
    <?php endif ?>

    <?php if ($p->chassis_id):
        $c = \App\Extensions\Site\Model\Chassis::findOne(['chassis_id' => $p->chassis_id]); ?>
        <section class="content-section">
            <h2 class="section-title">Шасси</h2>
            <div class="section-content">

                <img src="<?= url('/uf/images/source/' . $p->chassis_image, [], true) ?>" alt="" class="section-image">

                <div class="section-description">
                    <p>
                        <strong><?= $c->name ?></strong>
                    </p>
                    <?= $c->description ?>

                    <?php
                    $params = \App\Extensions\Site\Model\Chassis\Param::all();
                    $vals = \App\Extensions\Site\Model\Chassis\ParamValue::getList($c->chassis_id);

                    $grouped = [];
                    foreach ($params as $par) {
                        $grouped[$par->getCategoryName()][] = $par;
                    }

                    if ($grouped && $vals && array_filter($vals, fn($i) => !!$i)):


                        foreach ($grouped as $cat => $params) :
                            $any = false;
                            foreach ($params as $p) {
                                if ($vals[$p->chassis_param_id] ?? false) {
                                    $any = true;
                                    break;
                                }
                            }

                            if (!$any) {
                                continue;
                            }
                            ?>
                            <div class="table-container">
                                <h3 class="table-title"><?= $cat ?></h3>
                                <table>
                                    <tbody>
                                    <?php foreach ($params as $par):
                                        if (!($vals[$par->chassis_param_id] ?? '')) {
                                            continue;
                                        } ?>
                                        <tr>
                                            <td><?= $par->name ?></td>
                                            <td><?= $vals[$par->chassis_param_id] ?></td>
                                        </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php endforeach; endif; ?>
                </div>
            </div>
        </section>
    <?php endif; ?>

    <?php if ($p->product_id && $p->addon_id):
        $a = \App\Extensions\Site\Model\Addon::findOne(['addon_id' => $p->addon_id]); ?>
        <section class="content-section">
            <h2 class="section-title">Оборудование</h2>
            <div class="section-content">
                <div class="section-description">
                    <p>
                        <strong><?= $a->name ?></strong>
                    </p>
                    <?= $a->description ?>

                    <?php
                    $params = \App\Extensions\Site\Model\Addon\Param::all();
                    $vals = \App\Extensions\Site\Model\Addon\ParamValue::getList($a->addon_id);

                    $grouped = [];
                    foreach ($params as $par) {
                        $grouped[$par->getCategoryName()][] = $par;
                    }

                    if ($grouped && $vals && array_filter($vals, fn($i) => !!$i)):


                        foreach ($grouped as $cat => $params) :
                            $any = false;
                            foreach ($params as $p) {
                                if ($vals[$p->addon_param_id] ?? false) {
                                    $any = true;
                                    break;
                                }
                            }

                            if (!$any) {
                                continue;
                            }
                            ?>
                            <div class="table-container">
                                <h3 class="table-title"><?= $cat ?></h3>
                                <table>
                                    <tbody>
                                    <?php foreach ($params as $par):
                                        if (!($vals[$par->addon_param_id] ?? '')) {
                                            continue;
                                        } ?>
                                        <tr>
                                            <td><?= $par->name ?></td>
                                            <td><?= $vals[$par->addon_param_id] ?></td>
                                        </tr>
                                    <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>
                        <?php endforeach; endif; ?>
                </div>
            </div>
        </section>
    <?php endif; ?>
</main>

<footer>
    <p>&copy; <?= \Simflex\Core\Core::siteParam('company') ?> <?= date('Y') ?></p>
    <p>ИНН: <?= \Simflex\Core\Core::siteParam('inn') ?></p>
</footer>

<?php if ($print): ?>
    <script>
        window.print();
    </script>
<?php endif; ?>
</body>
</html>
