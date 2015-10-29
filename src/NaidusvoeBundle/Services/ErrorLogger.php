<?php

namespace NaidusvoeBundle\Services;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use NaidusvoeBundle\Entity\ErrorLog;
use NaidusvoeBundle\Entity\Functions;
use NaidusvoeBundle\Entity\User;
use Symfony\Bundle\FrameworkBundle\Routing\Router;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorage;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\Debug\Exception\FatalErrorException;


class ErrorLogger
{
    /** @var User $user */
    private $user;
    /** @var EntityManager $em */
    private $em;

    /**
     * @param TokenStorage $tokenStorage
     * @param EntityManager $em
     */
    public function __construct(TokenStorage $tokenStorage, EntityManager $em)
    {
        $this->user = $tokenStorage->getToken()->getUser();
        $this->em = $em;
    }

    /**
     * @param \Exception $ex
     * @param string $from
     */
    public function registerException(\Exception $ex, $from) {
        $this->em = Functions::getEntityManager($this->em);
        $error = new ErrorLog();
        $error->setMessage($ex->getMessage());
        $error->setWhereError('File: ' . $ex->getFile() . ', Line: ' . $ex->getLine());
        $error->setFromError($from);

        $this->em->persist($error);
        $this->em->flush();
    }
}