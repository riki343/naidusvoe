<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Functions;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Encoder\EncoderFactory;

class UserController extends Controller
{
    /**
     * @Security("has_role('ROLE_USER')")
     * @return JsonResponse
     */
    public function getInfoAction() {
        /** @var User $user */
        $user = $this->getUser();
        $contactInfo = array(
            'region' => $user->getRegionID(),
            'city' => $user->getCity(),
            'name' => $user->getName(),
            'surname' => $user->getSurname(),
            'telephoneNumber' => $user->getTelephoneNumber(),
            'skype' => $user->getSkype(),
        );

        $addInfo = array(
            'notificationsOnEmail' => $user->getSettings()->getNotificationsEmail(),
            'notificationsOnSms' => $user->getSettings()->getNotificationsSms(),
            'emailForSpam' => $user->getSettings()->getSpamEmail(),
            'numberForSms' => $user->getSettings()->getNumberForSms(),
        );

        $regions = Functions::arrayToJson($this->getDoctrine()
            ->getRepository('NaidusvoeBundle:Region')->findAll());

        return new JsonResponse(array(
            'contactInfo' => $contactInfo,
            'addInfo' => $addInfo,
            'regions' => $regions
        ));
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @param Request $request
     * @param int $user_id
     * @return JsonResponse
     */
    public function saveContactInfoAction(Request $request, $user_id) {
        $data = json_decode($request->getContent(), true);
        $data = (object) $data['info'];
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        try {
            User::saveContactInfo($em, $user_id, $data);
        } catch (\Exception $ex) {
            $from = "Class: User, function: saveContactInfo";
            $this->get('error_logger')->registerException($ex, $from);
            return new JsonResponse(false);
        }
        return new JsonResponse(true);
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @param Request $request
     * @param int $user_id
     * @return JsonResponse
     */
    public function changePasswordAction(Request $request, $user_id) {
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
     * @param Request $request
     * @param int $user_id
     * @return JsonResponse
     */
    public function changeEmailAction(Request $request, $user_id) {
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
     * @param Request $request
     * @param int $user_id
     * @return JsonResponse
     */
    public function saveEmailNotificationSettingsAction(Request $request, $user_id) {
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
     * @param Request $request
     * @param int $user_id
     * @return JsonResponse
     */
    public function saveSmsNotificationSettingsAction(Request $request, $user_id) {
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
}