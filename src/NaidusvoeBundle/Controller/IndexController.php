<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class IndexController extends Controller
{
    public function indexAction()
    {
        $session = $this->get('session');
        if (!$session->get('lang')) {
            $session->set('lang', 'ua');
        }
        return $this->render('@Naidusvoe/index.html.twig');
    }

    public function setLangAction(Request $request) {
        $data = json_decode($request->getContent(), true);
        $lang = $data['lang'];
        $session = $this->get('session');
        $session->set('lang', $lang);
        return new JsonResponse(true);
    }

    /**
     * @Route("/login")
     * @return Response
     */
    public function loginAction()
    {
        $session = $this->get('session');
        if (!$session->get('lang')) {
            $session->set('lang', 'ua');
        }
        $authenticationUtils = $this->get('security.authentication_utils');

        $error = $authenticationUtils->getLastAuthenticationError();

        $lastUsername = $authenticationUtils->getLastUsername();

        $parameters = array(
            'last_username' => $lastUsername,
            'error' => $error,
        );

        return $this->render('@Naidusvoe/login.html.twig', $parameters);
    }

    /**
     * @Route("/login_check")
     */
    public function loginCheckAction() { }

    /**
     * @Route("/signup")
     */
    public function signupAction() {
        $session = $this->get('session');
        if (!$session->get('lang')) {
            $session->set('lang', 'ua');
        }
        if ($this->get('security.authorization_checker')->isGranted('ROLE_USER')) {
            //return $this->redirectToRoute('zectranet_user_page');
        }
        return $this->render('@Naidusvoe/signup.html.twig');
    }

    /**
     * @Route("/signup/signup_action")
     * @param Request $request
     * @return Response
     */
    public function signupActAction(Request $request) {
        $session = $this->get('session');
        if (!$session->get('lang')) {
            $session->set('lang', 'ua');
        }
        if ($this->get('security.authorization_checker')->isGranted('ROLE_USER')) {
            return $this->redirectToRoute('naidusvoe_homepage');
        }

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $parameters = array(
            'email' => $request->request->get('email'),
            'username' => $request->request->get('username'),
            'password' => $request->request->get('password'),
        );

        $user = User::addUser($em, $this->get('security.encoder_factory'), $parameters);
        //User::GenerateDefaultAvatar($em, $user);

        return $this->redirectToRoute('naidusvoe_login');
    }
}
