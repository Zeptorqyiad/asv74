<?php

namespace App\Extensions\Site\Component;

use App\Extensions\Site\Model\Addon;
use Dompdf\Dompdf;
use Dompdf\Options;
use Simflex\Core\Container;
use Simflex\Core\Controller\Action;
use Simflex\Core\ControllerBase;

class Product extends ControllerBase
{
    #[Action('/doc/')]
    protected function downloadDoc(): void
    {
        $req = Container::getRequest();

        $prod = \App\Extensions\Catalog\Model\Product::findOne(['product_id' => $req->request('productId')]);
        if (!$prod) {
            $prod = Addon::findOne(['addon_id' => $req->request('addonId')]);
        }

        $html = $this->renderTemplate($prod, $print = $req->request('print'));
        $html = mb_convert_encoding($html, 'HTML-ENTITIES', 'UTF-8');

        if ($print) {
            echo $html;
            exit;
        }

        $pdf = new Dompdf();
        $pdf->loadHTML($html);
        $pdf->setPaper('A4');
        $pdf->render();
        $pdf->stream();
        exit;
    }

    protected function renderTemplate($p, $print): string
    {
        ob_start();
        include SF_ROOT_PATH . '/Extensions/Site/tpl/pdf/product_doc.tpl';
        return ob_get_clean();
    }
}