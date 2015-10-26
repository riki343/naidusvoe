<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class IndexController extends Controller
{
    /**
     * @Route("/", name="naidusvoe_homepage")
     * @Route("/cabinet")
     * @Route("/cabinet/advs")
     * @Route("/cabinet/messages")
     * @Route("/cabinet/conversation/{conv_id}", requirements={"conv_id"="\d+"})
     * @Route("/cabinet/settings")
     * @Route("/cabinet/favorites")
     * @Route("/add-adv")
     * @Route("/features")
     * @Route("/test")
     * @Route("/advertisements/{type}")
     * @Route("/advertisement/{type}/{adv_id}", requirements={"adv_id"="\d+"})
     * @Route("/adv/search/{slug}", requirements={"adv_id"="\d+"})
     * @return Response
     */
    public function indexAction()
    {
        $session = $this->get('session');
        if (!$session->get('lang')) {
            $session->set('lang', 'ua');
        }
        return $this->render('@Naidusvoe/index.html.twig');
    }

    /**
     * @Route("/setLang", name="naidusvoe_set_lang", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function setLangAction(Request $request) {
        $data = json_decode($request->getContent(), true);
        $lang = $data['lang'];
        $session = $this->get('session');
        $session->set('lang', $lang);
        return new JsonResponse(true);
    }

    /**
     * @Route("/login", name="naidusvoe_login")
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

        $vk_url = "https://oauth.vk.com/authorize?client_id=5069614&scope=1&redirect_uri=" . $this->generateUrl('vk_login',[],true) . "&response_type=code";
        $fb_url = "https://www.facebook.com/dialog/oauth?client_id=1707370132827740&redirect_uri=" . $this->generateUrl('fb_login',[],true) . "&response_type=code&scope=public_profile";
        $parameters = array(
            'last_username' => $lastUsername,
            'error' => $error,
            'vk_url' => $vk_url,
            'fb_url' => $fb_url,
        );

        return $this->render('@Naidusvoe/login.html.twig', $parameters);
    }

    /**
     * @Route("/login_check", name="naidusvoe_login_check")
     */
    public function loginCheckAction() { }

    /**
     * @Route("/signup", name="naidusvoe_signup")
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
     * @Route("/signup/signup_action", name="naidusvoe_signup_action")
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
