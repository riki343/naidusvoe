<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Model\Paginator;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class SearchController extends Controller
{
    /**
     * @Route("/adv/search", name="search", options={"expose"=true})
     * @param Request $request
     * @return JsonResponse
     */
    public function searchAction(Request $request) {
        $data = json_decode($request->getContent(), true);
        $slug = $data['slug'];

        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $qb = $em->createQueryBuilder();
        $slug = trim($slug);
        $slug = str_replace(' ', '%', $slug);
        $slug = str_replace('.', '%', $slug);
        $slug = str_replace(',', '%', $slug);
        $slug = str_replace(':', '%', $slug);
        $city = $data['city'];
        $region = $data['region'];
        //return new JsonResponse(['pager'=>$em->getRepository('NaidusvoeBundle:Advertisment')->findOneBy(['id'=>160])]);
        $qb
            ->select('a')
            ->from('NaidusvoeBundle:Advertisment', 'a')
            ->where('a.title LIKE :key')
            ->setParameter('key', "%".$slug."%")
            //->where($qb->expr()->like('a.title', "%" . $slug . "%"))
            ->orderBy('a.advertismentBlock', 'DESC')
            ->addOrderBy('a.advertismentOnMainPage', 'DESC')
            ->addOrderBy('a.categoryTop', 'DESC')
            ->addOrderBy('a.colorHighlight', 'DESC')
        ;
        if($region != "none")
        {
            $qb->andWhere('a.regionId=:region')->setParameter('region', $region);
        }
        if($city != "none")
        {
            $qb->andWhere('a.city=:city')->setParameter('city', $city);
        }

        $advs = $qb->getQuery();

        $paginator = new Paginator();
        $pager = $paginator->getJsonResponse($advs, $request, 10);
        return new JsonResponse($pager);


    }
}