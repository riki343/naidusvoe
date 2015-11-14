<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
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
     * @Route("/search/{condition}/{region}/{city}")
     * @Route("/advertisements/{type}")
     * @Route("/advertisement/{type}/{adv_id}", name="advertisement-page", requirements={"adv_id"="\d+"})
     * @Route("/advertisement/{type}/{adv_id}/additional-features", requirements={"adv_id"="\d+"})
     * @Route("/pay/confirm/{hash}", name="confirm-payment")
     * @Route("/email-confirm-success", name="email-confirm-success")
     * @Route("/email-confirm-failed" , name="email-confirm-failed" )
     * @return Response
     */
    public function indexAction()
    {
        /** @var User $user */
        $user = $this->getUser();
        $session = $this->get('session');
        if (!$session->get('lang')) {
            $session->set('lang', $user !== null ? $user->getLanguage() : 'ua');
        }
        return $this->render('@Naidusvoe/layout.html.twig');
    }

    /**
     * @Route("/setLang", name="naidusvoe_set_lang", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function setLangAction(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $lang = $data['lang'];
        /** @var User $user */
        if (($user = $this->getUser()) !== null && $user->getLanguage() !== $lang) {
            $user->setLanguage($lang);
            $this->getDoctrine()->getManager()->persist($user);
            $this->getDoctrine()->getManager()->flush();
        }
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
        $publicKey = $this->get('service_container')->getParameter('recaptcha_key');

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $response = $this->get('naidusvoe.recaptcha')->verify($publicKey, $data['captcha']);
        if ($response['success'] !== true) {
            return new JsonResponse(['status' => 'error', 'message' => 'WRONG_CAPTCHA']);
        }

        $user = $em->getRepository('NaidusvoeBundle:User')->findOneBy(['email' => $data['email']]);
        if ($user === null) {
            return new JsonResponse(['status' => 'error', 'message' => 'USER_NOT_FOUND']);
        } else if ($user->getActive() === false) {
            return new JsonResponse(['status' => 'error', 'message' => 'USER_NOT_ACTIVE']);
        }

        if ($this->get('naidusvoe.user')->forceSignIn($request, $user, $data['password']) === false) {
            return new JsonResponse(['status' => 'error', 'message' => 'WRONG_PASSWORD']);
        } else {
            return new JsonResponse(['status' => 'success', 'user' => $user->getInArray()]);
        }
    }

    /**
     * @Route("/signup-action", name="signup", options={"expose"=true})
     * @param Request $request
     * @return Response
     */
    public function signupActAction(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        $publicKey = $this->get('service_container')->getParameter('recaptcha_key');

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $response = $this->get('naidusvoe.recaptcha')->verify($publicKey, $data['captcha']);
        if ($response['success'] !== true) {
            return new JsonResponse(['status' => 'error', 'message' => 'WRONG_CAPTCHA']);
        }

        if ($data['pass'] !== $data['rpass']) {
            return new JsonResponse(['status' => 'error', 'message' => 'PASSWORDS_NOT_MATCH']);
        }

        $user = $em->getRepository('NaidusvoeBundle:User')->findOneBy(['email' => $data['email']]);
        if ($user !== null) {
            return new JsonResponse(['status' => 'error', 'message' => 'USER_ALREADY_EXIST']);
        } else {
            $this->get('naidusvoe.user')->signUp($data['email'], $data['pass'], $data['name']);
            return new JsonResponse(['status' => 'success']);
        }
    }

    /**
     * @Route("/logout-action", name="logout", options={"expose"=true})
     * @param Request $request
     * @return Response
     */
    public function logout(Request $request)
    {
        $this->get('security.token_storage')->setToken(null);
        return new JsonResponse();
    }

    /**
     * @Route("/login-oauth", name="oauth-login", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function oAuthLogin(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        /** @var User|null $user */
        $result = $this->get('naidusvoe.user')->oAuthLogin($request, $data);

        if ($result === true) {
            $token = $this->get('security.token_storage')->getToken();
            if ($token !== null && ($user = $token->getUser()) !== null) {
                /** @var User $user */
                if ($user->getActive() === false) {
                    return new JsonResponse(['status' => 'error', 'message' => 'USER_NOT_ACTIVE']);
                } else {
                    return new JsonResponse(['status' => 'ok', 'user' => $user->getInArray()]);
                }
            } else {
                return new JsonResponse(['status' => 'error', 'message' => 'USER_NOT_FOUND']);
            }
        } else if ($result === 'credentials') {
            return new JsonResponse(['status' => 'credential_required']);
        } else if ($result === 'registered') {
            return new JsonResponse(['status' => 'registered']);
        } else if ($result === 'not_active') {
            return new JsonResponse(['status' => 'error', 'message' => 'USER_NOT_ACTIVE']);
        } else {
            return new JsonResponse(['status' => 'error', 'message' => 'AUTH_FAILED']);
        }
    }

    /**
     * @Route("/confirm-token/email/{token}", name="email-confirmation")
     * @param string $token
     * @return RedirectResponse
     */
    public function confirmEmailToken($token)
    {
        $confirmed = $this->get('naidusvoe.user')->confirmEmail($token);
        if ($confirmed === true) {
            return $this->redirectToRoute('email-confirm-success');
        } else {
            return $this->redirectToRoute('email-confirm-failed');
        }
    }

    /**
     * @Route("/generate/reset-password-token/{email}", name="generate-reset-password-token", options={"expose"=true})
     * @param string $email
     * @return JsonResponse
     */
    public function generateRecoverPasswordToken($email) {
        $user = $this->getDoctrine()->getRepository('NaidusvoeBundle:User')->findOneBy([
            'email' => $email
        ]);

        if ($user !== null) {
            $user->setConfirmationToken(User::generateToken());
            return new JsonResponse(['status' => 'ok']);
        } else {
            return new JsonResponse([
                'status' => 'error', 'message' => 'USER_NOT_FOUND'
            ]);
        }
    }

    /**
     * @Route("/confirm-token/password/{token}", name="password-recover")
     * @param string $token
     * @return RedirectResponse
     */
    public function passwordRecoverToken($token)
    {
        $user = $this->getDoctrine()->getManager()->getRepository('NaidusvoeBundle:User')->findOneBy([
            'confirmationToken' => $token
        ]);
        if ($user === true) {
            $this->get('session')->set('password-token', $token);
            return $this->redirectToRoute('set-new-password');
        } else {
            return $this->redirectToRoute('email-confirm-failed');
        }
    }

    /**
     * @Route("/confirm/reset-password", name="set-new-pass")
     * @param Request $request
     * @return JsonResponse
     */
    public function confirmResetPassword(Request $request) {
        if (($token = $this->get('session')->get('password-token')) !== null) {
            $data = json_decode($request->getContent(), true);
            $this->get('naidusvoe.user')->changePassword($token, $data);

            return new JsonResponse([ 'status' => 'ok' ]);
        } else {
            return new JsonResponse([ 'status' => 'error', 'message' => 'TOKEN_NOT_FOUND' ]);
        }
    }
}
