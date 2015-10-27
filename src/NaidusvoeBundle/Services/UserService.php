<?php

namespace NaidusvoeBundle\Services;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Role;
use NaidusvoeBundle\Entity\User;
use NaidusvoeBundle\Entity\UserSettings;
use Symfony\Component\EventDispatcher\EventDispatcherInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorage;
use Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken;
use Symfony\Component\Security\Core\Encoder\EncoderFactoryInterface;
use Symfony\Component\Security\Http\Event\InteractiveLoginEvent;

class UserService {
    /** @var EncoderFactoryInterface $encoderFactory */
    private $encoderFactory;
    /** @var TokenStorage $tokenStorage */
    private $tokenStorage;
    /** @var EventDispatcherInterface $eventDispatcher */
    private $eventDispatcher;
    /** @var EntityManager $entityManager */
    private $entityManager;

    /**
     * @param EncoderFactoryInterface $encoderFactory
     * @param TokenStorage $tokenStorage
     * @param EventDispatcherInterface $eventDispatcher
     * @param EntityManager $entityManager
     */
    public function __construct($encoderFactory, $tokenStorage, $eventDispatcher, $entityManager) {
        $this->encoderFactory   = $encoderFactory;
        $this->tokenStorage     = $tokenStorage;
        $this->eventDispatcher  = $eventDispatcher;
        $this->entityManager    = $entityManager;
    }

    /**
     * @param Request $request
     * @param User $user
     * @param string $password
     * @return boolean
     */
    public function forceSignIn(Request $request, User $user, $password) {
        $password = $this->encoderFactory->getEncoder($user)->encodePassword($password, $user->getSalt());
        if ($password === $user->getPassword()) {
            $token = new UsernamePasswordToken($user, $user->getPassword(), "secured_area", $user->getRoles());
            $this->tokenStorage->setToken($token);
            $event = new InteractiveLoginEvent($request, $token);
            $this->eventDispatcher->dispatch("security.interactive_login", $event);

            return true;
        } else {
            return false;
        }
    }

    public function signUp($email, $password = null, $name = null) {
        /** @var EntityManager $em */
        $em = $this->entityManager;
        $encoderFactory = $this->encoderFactory;

        /** @var User $user */
        $user = new User();
        $encoder = $encoderFactory->getEncoder($user);
        $user->setEmail($email);
        $user->setUsername($email);
        if ($password === null) {
            $password = User::generatePassword();
        }
        $user->setPassword($encoder->encodePassword($password, $user->getSalt()));
        $user->setRegistered(new \DateTime());
        $user->setLastActive(new \DateTime());
        $user->addRole(Role::getUserRole($em));
        $user->setActive(false);
        if ($name !== null) {
            $user->setName($name);
        }
        $em->persist($user);

        $settings = new UserSettings();
        $settings->setUser($user);
        $em->persist($settings);

        $em->flush();

        return $user;
    }
}