<?php

namespace NaidusvoeBundle\Services;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\QueryBuilder;

class Notifier
{
    /** @var EntityManager $em */
    private $em;
    /** @var QueryBuilder */
    private $qb;

    /**
     * @param EntityManager $entityManager
     */
    public function __construct(EntityManager $entityManager) {
        $this->em = $entityManager;
        $this->qb = $entityManager->createQueryBuilder();
    }

    private function clearNewMessage() {

    }
}