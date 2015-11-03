<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Advertisment;
use NaidusvoeBundle\Entity\Attachment;
use NaidusvoeBundle\Entity\Favorites;
use NaidusvoeBundle\Entity\Functions;
use NaidusvoeBundle\Entity\Rating;
use NaidusvoeBundle\Entity\User;
use NaidusvoeBundle\Entity\UserVote;
use NaidusvoeBundle\Model\Paginator;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken;
use Symfony\Component\Security\Http\Event\InteractiveLoginEvent;

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
        $priceTypes = Functions::arrayToJson($em->getRepository('NaidusvoeBundle:PriceType')->findAll());
        $regions = Functions::arrayToJson($em->getRepository('NaidusvoeBundle:Region')->findAll());
        $info = [
            'priceTypes' => $priceTypes,
            'regions' => $regions,
        ];

        if ($user !== null) {
            $info['contactPerson']      = $user->getName();
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
     * @param Request $request
     * @return JsonResponse
     */
    public function addNewAdvAction(Request $request) {
        $data = json_decode($request->getContent(), true);
        $data = (object) $data;
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $user = $em->getRepository('NaidusvoeBundle:User')->findOneBy(['email' => $data->email]);

        if ($data->authorization === true && isset($data->password)) {
            if ($this->get('naidusvoe.user')->forceSignIn($request, $user, $data->password) === false)  {
                return new JsonResponse(['status' => -1]);
            }
        }

        $authorizationChecker = $this->get('security.authorization_checker');
        if ($authorizationChecker->isGranted('ROLE_USER')) {
            $user = $this->get('security.token_storage')->getToken()->getUser();
            $adv = $this->AddAdv($data, $user);
            $adv = ($adv) ? $adv->getInArray() : null;
            return new JsonResponse(['status'=> 1, 'object' => $adv]);
        } else {
            if ($user !== null) {
                return new JsonResponse(['status' => 2, 'email' => $data->email]);
            } else {
                $password = User::generatePassword();
                $user = $this->get('naidusvoe.user')->signUp($data->email, $password, $data->contactPerson);
                $adv = $this->AddAdv($data, $user);
                $adv = ($adv) ? $adv->getInArray() : null;
                return new JsonResponse(['status' => 3, 'object' => $adv, 'user' => $user->getInArray()]);
            }
        }
    }

    /**
     * @param object $data
     * @param User $user
     * @return Advertisment
     */
    private function AddAdv($data, $user) {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $adv = Advertisment::addNewAdv($em, $data, $user->getId());
        $em->persist($adv);
        $em->flush($adv);

        $attachments = Attachment::uploadImages($em, $data->photos, $adv);
        foreach ($attachments as $item) {
            $em->persist($item);
        }

        $em->flush();
        return $adv;
    }

    /**
     * @Route("/adv/get/{adv_id}", name="get-adv", options={"expose"=true})
     * @param int $adv_id
     * @return JsonResponse
     */
    public function getAdvAction($adv_id) {
        /** @var Advertisment $adv */
        $adv = $this->getDoctrine()->getManager()->find('NaidusvoeBundle:Advertisment', $adv_id);
        /** @var User $user */
        $user = $adv->getUser();
        /** @var User $myself */
        $myself = $this->getUser();
        return new JsonResponse(array(
            'adv' => $adv->getInArray(),
            'advUser' => $user->getInArray(),
            'user' => ($myself !== null) ? $myself->getInArray() : null
        ));
    }

    /**
     * @Route("/get-advs/{type}/{filter}", name="get-advs", options={"expose"=true})
     * @param Request $request
     * @param string $type
     * @param int|null $filter
     * @return JsonResponse
     */
    public function getAdvsAction(Request $request, $type = null, $filter = null) {
        $typeID = null;
        switch ($type) {
            case 'trade': $typeID = 1; break;
            case 'gift':  $typeID = 3; break;
            case 'found': $typeID = 2; break;
        }

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $advs = Advertisment::getAdvs($em, $filter, $typeID);
        $paginator = new Paginator();
        $pager = $paginator->getJsonResponse($advs, $request, 10);

        $categories = $em->getRepository('NaidusvoeBundle:AdvertismentCategory')
            ->findBy(array('typeID' => $typeID));

        $bests = $this->get('naidusvoe.advertisement')->getTopAdvs($typeID);

        return new JsonResponse(array(
            'advs' => $pager,
            'categories' => Functions::arrayToJson($categories),
            'bests' => Functions::arrayToJson($bests)
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
        /** @var User $user */
        $user = $this->getUser();

        $fav = $em->getRepository('NaidusvoeBundle:Favorites')->findOneBy(['advertismentID' => $adv_id]);
        $adv = $em->find('NaidusvoeBundle:Advertisment', $adv_id);
        if ($fav === null && $adv !== null) {
            $fav = new Favorites($adv, $user);
            $em->persist($fav);
            $em->flush();
            return new JsonResponse(true);
        } else {
            return new JsonResponse(false);
        }
    }

    /**
     * @Security("has_role('ROLE_USER')")
     * @Route("/adv/cahnge-user-rating/{adv_id}/{rating}", name="change-rating", options={"expose"=true})
     * @param integer $adv_id
     * @param float $rating
     * @return JsonResponse
     */
    public function changeUserRating($adv_id, $rating) {
        /** @var User $user */
        $user = $this->getUser();
        $em = $this->getDoctrine()->getManager();
        $adv = $em->find('NaidusvoeBundle:Advertisment', $adv_id);

        if ($adv !== null) {
            $vote = $em->getRepository('NaidusvoeBundle:UserVote')->findOneBy([
                'userId'  => $adv->getUserID(),
                'voterId' => $user->getId(),
            ]);
            if ($user->getId() !== $adv->getUserID()) {
                if ($vote === null) {
                    $vote = new UserVote();
                    $vote->setVotePower($rating);
                    $vote->setUser($adv->getUser());
                    $vote->setVoter($user);
                    $em->persist($vote);
                } else if ($vote->getVotePower() !== $rating) {
                    $vote->setVotePower($rating);
                    $em->persist($vote);
                }

                $em->flush();

                $advUser = $em->getRepository('NaidusvoeBundle:User')->find($vote->getUserId());
                $user->setRating($this->calcRating($adv->getUser()));
                $user->setVotesCount($user->getVotes()->count());
                $em->persist($user);
                $em->flush();
                return new JsonResponse([ 'status' => 'ok', 'user' => $advUser->getInArray() ]);
            }
        }

        return new JsonResponse([ 'status' => 'error', 'message' => 'UNKNOWN_ERROR' ]);
    }

    /**
     * @param User $user
     * @return float
     */
    private function calcRating($user) {
        $div    = $user->getVotes()->count();
        $rating = $user->getVotes()->count() / $div;

        return $rating;
    }
}