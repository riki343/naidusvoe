<?php

namespace NaidusvoeBundle\Controller;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Model\Paginator;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;

class TestController extends Controller
{
    /**
     * @Route("/test-ctrl", name="test-ctrl", options={"expose"=true})
     * @param Request $request
     * @return Response
     */
    public function testAction(Request $request)
    {
        /** @var EntityManager $em */
        $em = $this->getDoctrine()->getManager();
        $qb = $em->createQueryBuilder();

        $query = $qb
            ->select('e')
            ->from('NaidusvoeBundle:ErrorLog', 'e')
            ->getQuery()
        ;

        $paginator = new Paginator();
        $pager = $paginator->getJsonResponse($query, $request);

        return new JsonResponse($pager);
    }
}
