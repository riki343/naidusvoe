<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Model\Paginator;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

class SearchController extends Controller
{
    /**
     * @Route("/adv/search", name="search", options={"expose"=true})
     * @param Request $request
     * @param string $slug
     * @return JsonResponse
     */
    public function searchAction(Request $request, $slug) {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $qb = $em->createQueryBuilder();
        $slug = trim($slug);
        $slug = str_replace(' ', '%', $slug);
        $slug = str_replace('.', '%', $slug);
        $slug = str_replace(',', '%', $slug);
        $slug = str_replace(':', '%', $slug);

        $advs = $qb
            ->select('a')
            ->from('NaidusvoeBundle:Advertisment', 'a')
            ->where($qb->expr()->like('a.title', "%" . $slug . "%"))
            ->orderBy('a.advertismentBlock', 'DESC')
            ->addOrderBy('a.advertismentOnMainPage', 'DESC')
            ->addOrderBy('a.categoryTop', 'DESC')
            ->addOrderBy('a.colorHighlight', 'DESC')
        ;

        $paginator = new Paginator();
        $pager = $paginator->getJsonResponse($advs, $request, 10);

        return new JsonResponse($pager);
    }
}