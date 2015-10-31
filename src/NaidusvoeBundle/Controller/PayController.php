<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

class PayController extends Controller
{
    private $public_key = 'i30946396380';
    private $private_key = '1Y7ztWA5pwkQYG1UhRBqRnNPizj9iruWV7Qas8Px';

    /**
     * @Route("/pay/{ammount}/{pay_way}", name="get-pay-form")
     * @param Request $request
     * @param integer $amount
     * @param string $pay_way
     * @return Response
     */
    public function payAction(Request $request, $amount = 1, $pay_way = 'card')
    {
        $data  = (object) json_decode($request->getContent(), true);
        $total = 0;

        if ($data->advOnMain->checked === true) {
            switch ($data->advOnMain->period) {
                case '3':  $total += 15; break;
                case '7':  $total += 30; break;
                case '15': $total += 50; break;
            }
        }

        if ($data->advOnTop->checked === true) {
            switch ($data->advOnTop->period) {
                case '3':  $total += 15; break;
                case '7':  $total += 30; break;
                case '15': $total += 50; break;
            }
        }

        if ($data->advFilled->checked === true) {
            switch ($data->advFilled->period) {
                case '3':  $total += 15; break;
                case '7':  $total += 30; break;
                case '15': $total += 50; break;
            }
        }

        if ($data->advUrgent->checked === true) {
            switch ($data->advUrgent->period) {
                case '3':  $total += 15; break;
                case '7':  $total += 30; break;
                case '15': $total += 50; break;
            }
        }

        if ($data->advUpdate->checked === true) {
            $total += 15;
        }

        if ($data->advBlock->checked === true) {
            switch ($data->advBlock->period) {
                case '3':  $total += 15; break;
                case '7':  $total += 30; break;
                case '15': $total += 50; break;
            }
        }

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $orderId = $em->getRepository('NaidusvoeBundle:PaymentRequest');

        if ($total === $data->total) {
            $liqpay = new \LiqPay($this->public_key, $this->private_key);
            $html = $liqpay->cnb_form(array(
                'version'        => '3',
                'amount'         => $total,
                'currency'       => 'UAH',
                'description'    => 'Оплата додаткових послуг для сайту ZnaiduSvoe.com',
                'order_id'       => 'order_id_1',
                'sandbox'        => 1,
            ));

            return new JsonResponse([ 'status' => 'ok', 'form' => $html]);
        } else {
            return new JsonResponse([ 'status' => 'error', 'message' => 'INCORRECT_DATA']);
        }
    }
}
