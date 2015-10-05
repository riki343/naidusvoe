<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Advertisment;
use NaidusvoeBundle\Entity\Attachment;
use NaidusvoeBundle\Entity\Favorites;
use NaidusvoeBundle\Entity\Functions;
use NaidusvoeBundle\Entity\User;
use NaidusvoeBundle\Model\Paginator;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

class AdvertismentController extends Controller
{
    /**
     * @Route("/get/adv_info", name="naidusvoe_get_adv_info", options={"expose" = true})
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
        $advTypes = Functions::arrayToJson($em->getRepository('NaidusvoeBundle:AdvertismentType')->findAll());
        $info = [
            'advTypes' => $advTypes,
            'categories' => $categories,
            'priceTypes' => $priceTypes,
        ];

        if ($user !== null) {
            $info['contactPerson']      = $user->getName() . ' ' . $user->getSurname();
            $info['email']              = $user->getEmail();
            $info['telephoneNumber']    = $user->getTelephoneNumber();
            $info['skype']              = $user->getSkype();
            $info['city']               = $user->getCity();
            $info['region']             = ($user->getRegion() !== null)
                ? $user->getRegion()->getInArray() : "";
        } else {
            $info['contactPerson']      = "";
            $info['email']              = "";
            $info['telephoneNumber']    = "";
            $info['skype']              = "";
            $info['region']             = "";
            $info['city']               = "";
        }

        return new JsonResponse($info);
    }

    /**
     * @Route("/add/adv", name="naidusvoe_add_adv", options={"expose" = true})
     * @Security("has_role('ROLE_USER')")
     * @param Request $request
     * @return JsonResponse
     */
    public function addNewAdvAction(Request $request) {
        $data = json_decode($request->getContent(), true);
        $data = (object) $data;
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        /** @var User $user */
        $user = $this->getUser();
        $adv = Advertisment::addNewAdv($em, $data, $user->getId());
        $em->persist($adv);
        $em->flush($adv);

        $attachments = Attachment::uploadImages($em, $data->photos, $adv);
        foreach ($attachments as $item) {
            $em->persist($item);
        }

        $em->flush();
        return new JsonResponse(($adv) ? $adv->getInArray() : null);
    }

    /**
     * @Route("/adv/get/{adv_id}", name="get-adv", options={"expose"=true})
     * @param int $adv_id
     * @return JsonResponse
     */
    public function getAdvAction($adv_id) {
        /** @var Advertisment $adv */
        $adv = $this->getDoctrine()->getManager()->find('NaidusvoeBundle:Advertisment', $adv_id);
        $user = $adv->getUser();
        return new JsonResponse(array(
            'adv' => $adv->getInArray(),
            'user' => $user->getInArray(),
        ));
    }

    /**
     * @Route("/get-trade-advs/{filter}", name="get-trade-advs", options={"expose"=true})
     * @param Request $request
     * @param int $filter
     * @return JsonResponse
     */
    public function getAdvsTradeAction(Request $request, $filter = null) {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $advs = Advertisment::getAdvs($em, $filter, 1);
        $paginator = new Paginator();
        $pager = $paginator->getJsonResponse($advs, $request, 10);

        $categories = $em->getRepository('NaidusvoeBundle:AdvertismentCategory')
            ->findBy(array('typeID' => 1));

        return new JsonResponse(array(
            'advs' => $pager,
            'categories' => Functions::arrayToJson($categories)
        ));
    }

    /**
     * @Route("/get-found-advs/{filter}", name="get-found-advs", options={"expose"=true})
     * @param Request $request
     * @param int $filter
     * @return JsonResponse
     */
    public function getAdvsFoundAction(Request $request, $filter = null) {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $advs = Advertisment::getAdvs($em, $filter, 2);
        $paginator = new Paginator();
        $pager = $paginator->getJsonResponse($advs, $request);

        $categories = $em->getRepository('NaidusvoeBundle:AdvertismentCategory')
            ->findBy(array('typeID' => 2));

        return new JsonResponse(array(
            'advs' => $advs,
            'categories' => Functions::arrayToJson($categories)
        ));
    }

    /**
     * @Route("/get-gift-advs/{filter}", name="get-gift-advs", options={"expose"=true})
     * @param Request $request
     * @param int $filter
     * @return JsonResponse
     */
    public function getAdvsGiftAction(Request $request, $filter = null) {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();

        $advs = Advertisment::getAdvs($em, $filter, 3);
        $paginator = new Paginator();
        $pager = $paginator->getJsonResponse($advs, $request);

        $categories = $em->getRepository('NaidusvoeBundle:AdvertismentCategory')
            ->findBy(array('typeID' => 3));

        return new JsonResponse(array(
            'advs' => $advs,
            'categories' => Functions::arrayToJson($categories)
        ));
    }

    /**
     * @Route("/adv/add-to-fav/{adv_id}", name="add-to-fav", options={"expose"=true})
     * @param int $adv_id
     * @return JsonResponse
     */
    public function addToFavAction($adv_id) {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        try {
            Advertisment::addToFav($em, $this->getUser()->getId(), $adv_id);
        } catch (\Exception $ex) {
            $from = "Class: Advertisment, function: addToFav";
            $this->get('error_logger')->registerException($ex, $from);
            return new JsonResponse(-1);
        }
        return new JsonResponse(1);
    }
}