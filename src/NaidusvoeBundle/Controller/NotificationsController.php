<?php

namespace NaidusvoeBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use NaidusvoeBundle\Entity\User;
use NaidusvoeBundle\Entity\Notification;

/**
 * Class NotificationsController
 * @package NaidusvoeBundle\Controller
 * @Route("/notifications")
 */
class NotificationsController extends Controller
{
    /**
     * @Route("/", name="get-notifications", options={"expose"=true})
     * @Method({"GET"})
     * @return JsonResponse
     */
    public function index() {
        $em = $this->getDoctrine()->getManager();
        $user = $this->getUser();
        $data = $em->getRepository('NaidusvoeBundle:Notification')->findBy(['userId'=>$user->getId()]);
        $result= [];
        foreach($data as $notification)
        {
            $result[] = $notification->getInArray();
        }
        return new JsonResponse($result);
    }

    /**
     * @Route("/test", name="test-notification")
     */
    public function testAction()
    {
        return $this->render('@Naidusvoe/mail.html.twig', [
            'content'=>"content",
            'Initiator'=>"initiator"
        ]);
    }
}