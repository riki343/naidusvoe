<?php

namespace NaidusvoeBundle\Model;

use Knp\Component\Pager\Paginator as BasePaginator;
use Symfony\Component\EventDispatcher\EventDispatcherInterface;
use Symfony\Component\HttpFoundation\JsonResponse;

/**
 * Class Paginator
 * @package NaidusvoeBundle\Model
 */
class Paginator extends BasePaginator
{
    /**
     * @param EventDispatcherInterface|null $eventDispatcher
     */
    public function __construct(EventDispatcherInterface $eventDispatcher = null)
    {
        parent::__construct($eventDispatcher);
    }

    /**
     * @return JsonResponse
     */
    public function getJsonResponse($query, $request)
    {
        $paginator = $this->paginate($query, $request->query->getInt('page', 1), 10);

        $items = [];
        foreach ($paginator as $item) {
            $items[] = $item->getInArray();
        }

        return array(
            'data' => $paginator->getPaginationData(),
            'items' => $items,
        );
    }
}