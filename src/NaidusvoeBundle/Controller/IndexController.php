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
     * @Route("/login")
     * @Route("/signup")
     * @Route("/search/{condition}/{region}/{city}", requirements={"region"="\d+"})
     * @Route("/advertisements/{type}")
     * @Route("/advertisement/{type}/{adv_id}", requirements={"adv_id"="\d+"})
     * @Route("/advertisement/{type}/{adv_id}/additional-features", requirements={"adv_id"="\d+"})
     * @Route("/pay/confirm/{hash}", name="confirm-payment")
     * @return Response
     */
    public function indexAction()
    {
        $session = $this->get('session');
        if (!$session->get('lang')) {
            $session->set('lang', 'ua');
        }
        return $this->render('@Naidusvoe/layout.html.twig');
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
     * @Route("/login-action", name="login", options={"expose"=true})
     * @param Request $request
     * @return Response
     */
    public function loginAction(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $publicKey = '6LeAmw8TAAAAAGyX-P1jTg13C_GMvdRdJOKNpacc';

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $response = $this->get('naidusvoe.recaptcha')->verify($publicKey, $data['captcha']);
        if ($response['success'] !== true) {
            return new JsonResponse([ 'status' => 'failed', 'reason' => 'captcha' ]);
        }

        $user = $em->getRepository('NaidusvoeBundle:User')->findOneBy(['email' => $data['email']]);
        if ($user === null) {
            return new JsonResponse([ 'status' => 'failed', 'reason' => 'user not found' ]);
        } else if ($user->getActive() === false) {
            return new JsonResponse([ 'status' => 'failed', 'reason' => 'user not active' ]);
        }

        if ($this->get('naidusvoe.user')->forceSignIn($request, $user, $data['password']) === false) {
            return new JsonResponse([ 'status' => 'failed', 'reason' => 'wrong password' ]);
        } else {
            return new JsonResponse([ 'status' => 'success', 'user' => $user->getInArray() ]);
        }
    }

    /**
     * @Route("/signup-action", name="signup", options={"expose"=true})
     * @param Request $request
     * @return Response
     */
    public function signupActAction(Request $request) {
        $data = json_decode($request->getContent(), true);
        $publicKey = '6LeAmw8TAAAAAGyX-P1jTg13C_GMvdRdJOKNpacc';

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $response = $this->get('naidusvoe.recaptcha')->verify($publicKey, $data['captcha']);
        if ($response['success'] !== true) {
            return new JsonResponse([ 'status' => 'failed', 'reason' => 'captcha' ]);
        }

        if ($data['pass'] !== $data['rpass']) {
            return new JsonResponse([ 'status' => 'failed', 'reason' => 'password not match' ]);
        }

        $user = $em->getRepository('NaidusvoeBundle:User')->findOneBy(['email' => $data['email']]);
        if ($user !== null) {
            return new JsonResponse([ 'status' => 'failed', 'reason' => 'user exist' ]);
        } else {
            $this->get('naidusvoe.user')->signUp($data['email'], $data['pass'], $data['name']);
            return new JsonResponse([ 'status' => 'success']);
        }
    }

    /**
     * @Route("/logout-action", name="logout", options={"expose"=true})
     * @param Request $request
     * @return Response
     */
    public function logout(Request $request) {
        $this->get('security.token_storage')->setToken(null);
        return new JsonResponse();
    }

    /**
     * @Route("/search-action", name="search", options={"expose"=true})
     * @param Request $request
     * @return Response
     */
    public function search(Request $request)
    {
        return new JsonResponse();
    }
}
