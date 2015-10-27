<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Favorites;
use NaidusvoeBundle\Entity\Functions;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Encoder\EncoderFactory;

class UserController extends Controller
{
    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/get-info", name="user-get-info", options={"expose"=true})
     * @return JsonResponse
     */
    public function getInfoAction() {
        /** @var User $user */
        $user = $this->getUser();
        $contactInfo = array(
            'region' => $user->getRegionID(),
            'city' => $user->getCity(),
            'name' => $user->getName(),
            'telephoneNumber' => $user->getTelephoneNumber(),
            'skype' => $user->getSkype(),
        );

        $addInfo = array(
            'notificationsEmail' => $user->getSettings()->getNotificationsEmail(),
            'notificationsSms' => $user->getSettings()->getNotificationsSms(),
            'emailSpam' => $user->getSettings()->getSpamEmail(),
            'telephoneNumber' => $user->getSettings()->getNumberForSms(),
        );

        $regions = Functions::arrayToJson($this->getDoctrine()
            ->getRepository('NaidusvoeBundle:Region')->findAll())
        ;

        return new JsonResponse(array(
            'contactInfo' => $contactInfo,
            'addInfo' => $addInfo,
            'regions' => $regions
        ));
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/change-contact-info", name="user-change-contact-info", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function saveContactInfoAction(Request $request) {
        $user_id = $this->getUser()->getId();
        $data = json_decode($request->getContent(), true);
        $data = (object) $data['info'];
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        try {
            User::saveContactInfo($em, $user_id, $data);
        } catch (\Exception $ex) {
            $from = "Class: User, function: saveContactInfo";
            $this->get('error_logger')->registerException($ex, $from);
            return new JsonResponse(-1);
        }
        return new JsonResponse(1);
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/change-pass", name="user-change-pass", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function changePasswordAction(Request $request) {
        $user_id = $this->getUser()->getId();
        $data = json_decode($request->getContent(), true);
        $data = (object) $data['changes'];
        /** @var EncoderFactory $encoderFactory */
        $encoderFactory = $this->get('security.encoder_factory');
        /** @var User $user */
        $user = $this->getUser();
        $encoder = $encoderFactory->getEncoder($user);
        $encodedOldPass = $encoder->encodePassword($data->opass, $user->getSalt());
        if ($user->getPassword() == $encodedOldPass && $data->pass
            && $data->pass == $data->rpass) {
            $encodedPass = $encoder->encodePassword($data->pass, $user->getSalt());
            /** @var EntityManager $em */
            $em = $this->getDoctrine()->getManager();
            try {
                User::changePassword($em, $user_id, $encodedPass);
            } catch (\Exception $ex) {
                $from = "Class: User, function: changePassword";
                $this->get('error_logger')->registerException($ex, $from);
                return new JsonResponse(-1);
            }
            return new JsonResponse(1);
        } else {
            return new JsonResponse(0);
        }
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/change-email", name="user-change-email", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function changeEmailAction(Request $request) {
        $user_id = $this->getUser()->getId();
        $data = json_decode($request->getContent(), true);
        $data = (object) $data['changes'];
        if ($data->email && $data->email == $data->remail) {
            /** @var EntityManager $em */
            $em = $this->getDoctrine()->getManager();
            try {
                User::changeEmail($em, $user_id, $data->email);
            } catch (\Exception $ex) {
                $from = "Class: User, function: changeEmail";
                $this->get('error_logger')->registerException($ex, $from);
                return new JsonResponse(-1);
            }
            return new JsonResponse(1);
        } else {
            return new JsonResponse(0);
        }
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/change-email-settings", name="user-change-email-settings", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function saveEmailNotificationSettingsAction(Request $request) {
        $user_id = $this->getUser()->getId();
        $data = json_decode($request->getContent(), true);
        $data = (object) $data['settings'];
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        try {
            User::changeEmailNotificationsSettings($em, $user_id, $data);
        } catch (\Exception $ex) {
            $from = "Class: User, function: changeEmailNotificationsSettings";
            $this->get('error_logger')->registerException($ex, $from);
            return new JsonResponse(-1);
        }
        return new JsonResponse(1);
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/change-sms-settings", name="user-change-sms-settings", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function saveSmsNotificationSettingsAction(Request $request) {
        $user_id = $this->getUser()->getId();
        $data = json_decode($request->getContent(), true);
        $data = (object) $data['settings'];
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        try {
            User::changeSmsNotificationsSettings($em, $user_id, $data);
        } catch (\Exception $ex) {
            $from = "Class: User, function: changeSmsNotificationsSettings";
            $this->get('error_logger')->registerException($ex, $from);
            return new JsonResponse(-1);
        }
        return new JsonResponse(1);
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/delete-account", name="user-delete-account", options={"expose"=true})
     * @return RedirectResponse
     */
    public function deleteAccountAction() {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        /** @var User $user */
        $user = $this->getUser();
        $user->setDeleted(true);
        $em->persist($user);
        $em->flush();
        return $this->redirectToRoute('naidusvoe_logout');
    }

    /**
     * @Route("/user", name="get-user", options={"expose"=true})
     * @return JsonResponse
     */
    public function getUserAction() {
        /** @var User $user */
        $user = $this->getUser();
        return new JsonResponse(($user) ? $user->getInArray() : null);
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/get-user-advs", name="get-user-advs", options={"expose"=true})
     * @return JsonResponse
     */
    public function getUserAdvsAction() {
        /** @var User $user */
        $user = $this->getUser();
        $advs = Functions::arrayToJson($user->getAdvertisments());
        return new JsonResponse($advs);
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/delete-adv/{adv_id}", name="delete-user-adv", options={"expose"=true})
     * @param int $adv_id
     * @return JsonResponse
     */
    public function deleteUserAdvAction($adv_id) {
        /** @var User $user */
        $user = $this->getUser();
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $adv = $em->find('NaidusvoeBundle:Advertisment', $adv_id);
        if ($user->getId() == $adv->getUserID()) {
            $em->remove($adv);
            $em->flush();
            return new JsonResponse(true);
        } else {
            return new JsonResponse(false);
        }
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/get-favs", name="get-user-favs", options={"expose"=true})
     * @return JsonResponse
     */
    public function getFavsAction() {
        /** @var User $user */
        $user = $this->getUser();
        return new JsonResponse(
            Functions::arrayToJson($this->getDoctrine()->getRepository('NaidusvoeBundle:Favorites')
                ->findBy(array('userID' => $user->getId())))
        );
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/delete-fav/{fav_id}", name="delete-user-fav", options={"expose"=true})
     * @param int $fav_id
     * @return JsonResponse
     */
    public function deleteFavAction($fav_id) {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        /** @var User $user */
        $user = $this->getUser();
        $fav = $em->getRepository('NaidusvoeBundle:Favorites')->find($fav_id);

        if ($fav !== null) {
            $em->remove($fav);
            $em->flush();
            return new JsonResponse(true);
        } else {
            return new JsonResponse(false);
        }
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/get/cabinet-profile", name="get-cabinet-profile", options={"expose"=true})
     * @return JsonResponse
     */
    public function getCabinetProfileAction() {
        /** @var User $user */
        $user = $this->getUser();
        /** @var EntityManager $em */
        $em   = $this->getDoctrine()->getManager();
        $advs = $em->getRepository('NaidusvoeBundle:Advertisment')->findBy(['userID' => $user->getId()], null, 6);

        return new JsonResponse([
            'user' => $user->getInArray(),
            'advs' => Functions::arrayToJson($advs),
        ], 200);
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/user/change-avatar", name="change-avatar", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function changeAvatarAction(Request $request) {
        $image = $request->getContent();
        /** @var User $user */
        $user = $this->getUser();
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $basePath = sprintf('avatars/%s/', $user->getUsername());
        $imagePath = $basePath . uniqid($user->getUsername()) . '.jpg';
        $image = explode(',', $image);
        $image = base64_decode($image[1]);
        $fs = new Filesystem();
        $fs->dumpFile($imagePath, $image);
        $imagePath = '/' . $imagePath;

        $user->setAvatar($imagePath);
        $qb = $em->createQueryBuilder();
        $qb
            ->update('NaidusvoeBundle:User', 'u')
            ->set('u.avatar', "'" . $imagePath . "'")
            ->where('u.id = :param')
            ->setParameter('param', $user->getId())
            ->getQuery()
            ->getResult();
        ;

        return new JsonResponse(($user !== null) ? $user->getInArray() : null);
    }
}