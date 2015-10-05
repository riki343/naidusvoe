<?php

namespace NaidusvoeBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use NaidusvoeBundle\Entity\User;
use Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken;
use Symfony\Component\Security\Http\Event\InteractiveLoginEvent;

class SocialController extends Controller {
    /**
     * @Route("/login/vk_login", name="vk_login")
     * @param Request $request
     * @return Response
     */
    public function VkLoginAction(Request $request)
    {
        $VK_APP_ID = "5069614";
        $VK_SECRET_CODE = "9IclVVd4sqek1MZO9OhI";

        $val = $request->get('code');

        if(!empty($val)){

            $vk_grand_url = "https://api.vk.com/oauth/access_token?client_id=" . $VK_APP_ID . "&client_secret=" . $VK_SECRET_CODE . "&code=" . $val . "&redirect_uri=http://127.0.0.1:8000/login/vk_login";
            $resp = file_get_contents($vk_grand_url);
            $data = json_decode($resp, true);
            $vk_uid = $data['user_id'];

            $user = $this->getDoctrine()->getRepository('NaidusvoeBundle:User')->findOneBy(array('vk_id' => $vk_uid));

            if(empty($user))
            {
                return $this->render('@Naidusvoe/signup_Social.html.twig', array('social_uid' => $vk_uid, 'social_u_field' => "vk_id"));
            }

            $token = new UsernamePasswordToken($user, null, "secured_area", $user->getRoles());
            $this->get("security.context")->setToken($token);
            $event = new InteractiveLoginEvent($request, $token);
            $this->get("event_dispatcher")->dispatch("security.interactive_login", $event);

            return $this->redirectToRoute('naidusvoe_homepage');
        }
        return $this->redirect("https://vk.com");
    }

    /**
     * @Route("/login/fb_login", name="fb_login")
     * @param Request $request
     * @return Response
     */
    public function FbLoginAction(Request $request)
    {
        $client_id = '1707370132827740';
        $client_secret = '48cc85c5066d38d49b4d0905b9da041f';
        $val = $request->get('code');

        if(!empty($val))
        {
            $fb_grand_url = "https://graph.facebook.com/oauth/access_token?client_id=" . $client_id . "&client_secret=" . $client_secret . "&code=" . $val . "&redirect_uri=http://127.0.0.1:8000/login/fb_login";
            $resp = file_get_contents($fb_grand_url);
            parse_str($resp,$token);
            $url = "https://graph.facebook.com/me?" . urldecode(http_build_query(['access_token' => $token['access_token']]));
            $resp = file_get_contents($url);
            $user_info = json_decode($resp, true);
            $fb_uid = $user_info['id'];

            $user = $this->getDoctrine()->getRepository('NaidusvoeBundle:User')->findOneBy(array('vk_id' => $fb_uid));

            if(empty($user))
            {
                return $this->render('@Naidusvoe/signup_Social.html.twig', array('social_uid' => $fb_uid, 'social_u_field' => "fb_id"));
            }

            $token = new UsernamePasswordToken($user, null, "secured_area", $user->getRoles());
            $this->get("security.context")->setToken($token);
            $event = new InteractiveLoginEvent($request, $token);
            $this->get("event_dispatcher")->dispatch("security.interactive_login", $event);

            return $this->redirectToRoute('naidusvoe_homepage');
        }
        return $this->redirect('https://www.facebook.com');
    }

    /**
     * @Route("/vk/register_in_naidusvoe/{social_uid}/{social_u_field}", name="social_register")
     * @param Request $request
     * @param String $social_uid
     * @param String $social_u_field
     * @return Response
     */
    public function SocialRegisterAction(Request $request, $social_uid, $social_u_field)
    {
        $em = $this->getDoctrine()->getEntityManager();
        $password = md5(uniqid(rand(), true));
        $parameters = array(
            $social_u_field => $social_uid,
            'email' => $request->request->get('email'),
            'username' => $social_u_field . "_" . $social_uid,
            'password' => $password,
        );
        $user = User::addUser($em, $this->get('security.encoder_factory'), $parameters);

        $token = new UsernamePasswordToken($user, null, "secured_area", $user->getRoles());
        $this->get("security.context")->setToken($token);
        $event = new InteractiveLoginEvent($request, $token);
        $this->get("event_dispatcher")->dispatch("security.interactive_login", $event);

        return $this->redirectToRoute('naidusvoe_homepage');
    }
}