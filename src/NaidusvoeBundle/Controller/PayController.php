<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Order;
use NaidusvoeBundle\Entity\Payment;
use NaidusvoeBundle\Entity\User;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

class PayController extends Controller
{
    private $public_key = 'i30946396380';
    private $private_key = '1Y7ztWA5pwkQYG1UhRBqRnNPizj9iruWV7Qas8Px';

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/pay/add/{adv_id}", name="get-pay-form", options={"expose"=true})
     * @param Request $request
     * @param integer $adv_id
     * @return JsonResponse
     */
    public function payAction(Request $request, $adv_id)
    {
        $data  = (object) json_decode($request->getContent(), true);

        /** @var User $user */
        $user = $this->getUser();

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $user = $em->getReference('NaidusvoeBundle:User', $user->getId());
        $adv  = $em->find('NaidusvoeBundle:Advertisment', $adv_id);
        $order = new Order($user, $adv);
        $hash = Order::generateHash($em, $user->getId(), $adv_id);
        $result = Order::CheckForm($data, $order);

        if ($result['correct'] === true) {
            /** @var Order $order */
            $order = $result['order'];
            $order->setHash($hash);
            $order->setStatus('new');

            $em->persist($order);
            $em->flush();

            $liqpay = new \LiqPay($this->public_key, $this->private_key);
            $html = $liqpay->cnb_form(array(
                'version'        => '3',
                'amount'         => $order->getAmount(),
                'currency'       => 'UAH',
                'description'    => 'Оплата додаткових послуг для сайту ZnaiduSvoe.com',
                'order_id'       => $hash,
                'sandbox'        => 1,
                'pay_way'        => $order->getPayWay(),
                'server_url'     => $this->generateUrl('confirm-payment-callback', [ 'hash' => $hash ], UrlGeneratorInterface::ABSOLUTE_URL),
                'result_url'     => $this->generateUrl('advertisement-page', [
                    'type' => $adv->getType()->getSlug(), 'adv_id' => $adv->getId()
                ], UrlGeneratorInterface::ABSOLUTE_URL)
            ));

            return new JsonResponse([ 'status' => 'ok', 'form' => $html]);
        } else {
            return new JsonResponse([ 'status' => 'error', 'message' => 'PAYMENT_INCORRECT_DATA']);
        }
    }

    /**
     * @Route("/api/pay/confirm/{hash}", name="api-confirm-payment", options={"expose"=true})
     * @param Request $request
     * @param string $hash
     * @return JsonResponse
     */
    public function confirmOrder(Request $request, $hash)
    {
        $liqpay = new \LiqPay($this->public_key, $this->private_key);
        $res = $liqpay->api("payment/status", array(
            'version' => '3',
            'order_id' => $hash
        ));

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        /** @var User $user */
        $user = $this->getUser();
        $order = $em->getRepository('NaidusvoeBundle:Order')->findOneBy(['hash' => $hash]);

        if ($user->getId() !== $order->getUserId()) {
            new JsonResponse([ 'status' => 'error', 'message' => 'NOT_ALLOWED' ]);
        }

        $payment = $em->getRepository('NaidusvoeBundle:Payment')->findOneBy(['hash' => $hash]);
        if ($payment === null) {
            switch ($res['status']) {
                case 'success':
                case 'sandbox':
                    return $this->handleConfirmation($order, $res);
                case 'failure':
                case 'error':
                case '3ds_verify':
                case 'wait_secure':
                case 'wait_accept':
                case 'processing':  break;
                default:            break;
            }

            return new JsonResponse(['status' => 'error', 'message' => 'PAYMENT_FAILED']);
        } else {
            return new JsonResponse(['status' => 'ok', 'details' => $payment->getDetails()]);
        }
    }

    /**
     * @Route("/api/pay/confirm-callback/{hash}", name="confirm-payment-callback", options={"expose"=true})
     * @param Request $request
     * @param string $hash
     * @return Response
     */
    public function callbackConfirmOrder(Request $request, $hash) {
        $res = json_decode(base64_decode($request->request->get('data')), true);
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $order = $em->getRepository('NaidusvoeBundle:Order')->findOneBy(['hash' => $hash]);
        if ($order !== null) {
            $payment = $em->getRepository('NaidusvoeBundle:Payment')->findOneBy(['hash' => $hash]);
            if ($payment === null) {
                switch ($res['status']) {
                    case 'success':
                    case 'sandbox':
                        return $this->handleConfirmation($order, $res);
                    case 'failure':
                    case 'error':
                    case '3ds_verify':
                    case 'wait_secure':
                    case 'wait_accept':
                    case 'processing':  break;
                    default:            break;
                }

                return new JsonResponse(['status' => 'error', 'message' => 'PAYMENT_FAILED']);
            } else {
                return new JsonResponse(['status' => 'ok', 'details' => $payment->getDetails()]);
            }
        } else {
            return new JsonResponse(null);
        }
    }

    /**
     * @param Order $order
     * @param array $details
     * @return JsonResponse
     */
    private function handleConfirmation($order, $details) {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        if ($order !== null) {
            if ($order->getStatus() === 'new') {
                $payment = new Payment($order, $details);
                $em->persist($payment);
                $order->setStatus('confirmed');
                $em->persist($order);

                $adv = $em->find('NaidusvoeBundle:Advertisment', $order->getAdvertisementId());
                $adv = $adv->activateAdditionalFeatures($order);

                if ($adv !== null) {
                    $em->persist($adv);
                }

                $em->flush();
            }

            $mailer = $this->get('mailer');
            /** @var \Swift_Message $message */
            $message = $mailer->createMessage();
            $message->setTo($order->getUser()->getEmail());
            $message->setFrom($this->container->getParameter('system_mail'));
            $message->setSubject('Оплата додаткових послуг на сайті Znaidusvoe.com');
            $message->setBody($this->get('twig')->render(
                '@Naidusvoe/payment-success.email.html.twig', [
                'adv' => $order->getAdvertisement()
            ]), 'text/html');
            $mailer->send($message);

            return new JsonResponse([ 'status' => 'ok', 'details' => $details ]);
        } else {
            return new JsonResponse([ 'status' => 'error', 'message' => 'ORDER_NOT_FOUND' ]);
        }
    }
}
