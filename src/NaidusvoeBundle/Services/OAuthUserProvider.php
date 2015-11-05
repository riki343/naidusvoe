<?php

namespace NaidusvoeBundle\Services;

use Doctrine\ORM\EntityManager;
use HWI\Bundle\OAuthBundle\Security\Core\User\OAuthUserProvider as BaseProvider;
use HWI\Bundle\OAuthBundle\OAuth\Response\UserResponseInterface;
use NaidusvoeBundle\Entity\User;
use Symfony\Component\HttpFoundation\Session\Session;

class OAuthUserProvider extends BaseProvider
{
    /** @var Session $session */
    private $session;

    /** @var EntityManager */
    private $em;

    /** @var UserService $userProvider */
    private $userProvider;

    /**
     * @param Session $session
     * @param EntityManager $em
     * @param UserService $userProvider
     */
    public function __construct($session, $em, $userProvider) {
        $this->session = $session;
        $this->em = $em;
        $this->userProvider = $userProvider;
    }

    public function loadUserByUsername($username)
    {
        return new User($username);
    }

    public function loadUserByOAuthUserResponse(UserResponseInterface $response)
    {
        $resource = $response->getResourceOwner()->getName();
        $resource_id = $response->getUsername();
        $user = $this->em->getRepository('NaidusvoeBundle:User')->findOneBy([
            $resource => $resource_id,
        ]);

        if ($user === null) {
            $user = $this->em->getRepository('NaidusvoeBundle:User')->findOneBy([
                'email' => $response->getEmail()
            ]);
            if ($user === null) {
                $user = $this->userProvider->oAuthSignUp($response);
            } else {
                $user->setResource($resource, $resource_id);
                $this->em->persist($user);
                $this->em->flush();
            }
        }

        return $user;
    }

    public function supportsClass($class)
    {
        return $class === 'NaidusvoeBundle\\Entity\\User';
    }
}