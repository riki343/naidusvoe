<?php

namespace NaidusvoeBundle\Controller;

use NaidusvoeBundle\Services\LiqPay;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

class PayController extends Controller
{
    private $_public_key = 'i27412534007';
    private $_private_key = 'SPRhLbVWgANFUXSe4vO5afMV8pN6MVTCZvE3HIiU';

    /**
     * @Route("/liqpay", name="liqpay")
     * @param integer $amount
     * @param string $description
     * @param string $pay_way
     * @return Response
     */
    public function LiqPAyAction($amount = 1, $description = '', $pay_way = 'privat24')
    {
        $liqpay = new LiqPay($this->_public_key, $this->_private_key);
        $html = $liqpay->cnb_form(array(
            'version'        => '3',
            'amount'         => $amount,
            'currency'       => 'UAH',
            'description'    => 'Покупка ' . $description,
            'order_id'       => 'order_id_1',
            'pay_way'        => $pay_way
        ));
        return new JsonResponse($html);
    }
}
