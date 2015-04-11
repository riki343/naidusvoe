<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Functions;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class UserController extends Controller
{
    /**
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
}