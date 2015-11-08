<?php

namespace NaidusvoeBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;

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
        
    }
}