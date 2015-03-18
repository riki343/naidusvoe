<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class IndexController extends Controller
{
    public function indexAction()
    {
        return $this->render('@Naidusvoe/index.html.twig');
    }

    /**
     * @Route("/login")
     * @return Response
     */
    public function loginAction()
    {
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
        if ($this->get('security.authorization_checker')->isGranted('ROLE_USER')) {
            //return $this->redirectToRoute('zectranet_user_page');
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
