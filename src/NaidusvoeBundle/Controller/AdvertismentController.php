<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Advertisment;
use NaidusvoeBundle\Entity\Attachment;
use NaidusvoeBundle\Entity\Functions;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class AdvertismentController extends Controller
{
    /**
     * @return JsonResponse
     */
    public function getAdvDetailsAction() {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        /** @var User $user */
        $user = $this->getUser();
        /** @var array $categories */
        $categories = Functions::arrayToJson($em->getRepository('NaidusvoeBundle:AdvertismentCategory')->findAll());
        $priceTypes = Functions::arrayToJson($em->getRepository('NaidusvoeBundle:PriceType')->findAll());
        $info = array(
            'categories' => $categories,
            'priceTypes' => $priceTypes,
            'contactPerson' => $user->getName() . ' ' . $user->getSurname(),
            'email' => $user->getEmail(),
            'telephoneNumber' => $user->getTelephoneNumber(),
            'skype' => $user->getSkype(),
        );

        return new JsonResponse($info);
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @param Request $request
     * @return JsonResponse
     */
    public function addNewAdvAction(Request $request) {
        $data = json_decode($request->getContent(), true);
        $data = (object) $data['adv'];
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $adv = Advertisment::addNewAdv($em, $data);
        $images = Attachment::uploadImages($em, $data->photos, $adv->getId());
        return new JsonResponse($adv->getInArray());
    }

    /**
     * @param int $adv_id
     * @return JsonResponse
     */
    public function getAdvAction($adv_id) {
        /** @var Advertisment $adv */
        $adv = $this->getDoctrine()->getManager()->find('NaidusvoeBundle:Advertisment', $adv_id);
        return new JsonResponse($adv->getInArray());
    }
}