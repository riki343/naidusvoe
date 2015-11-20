<?php

namespace NaidusvoeBundle\Services;

use Doctrine\ORM\EntityManager;
use Monolog\Logger;
use NaidusvoeBundle\Entity\Role;
use NaidusvoeBundle\Entity\User;
use NaidusvoeBundle\Entity\UserSettings;
use Symfony\Bundle\TwigBundle\TwigEngine;
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

    /** @var \Swift_Mailer $mailer */
    private $mailer;

    /** @var string $systemMail */
    private $systemMail;

    /** @var TwigEngine $twig */
    private $twig;

    /** @var Logger $logger */
    private $logger;

    /**
     * @param EncoderFactoryInterface $encoderFactory
     * @param TokenStorage $tokenStorage
     * @param EventDispatcherInterface $eventDispatcher
     * @param EntityManager $entityManager
     * @param \Swift_Mailer $mailer
     * @param string $sysMail
     * @param TwigEngine $twig
     * @param Logger $logger
     */
    public function __construct(
        $encoderFactory, $tokenStorage, $eventDispatcher,
        $entityManager, $mailer, $sysMail, $twig, $logger
    ) {
        $this->encoderFactory   = $encoderFactory;
        $this->tokenStorage     = $tokenStorage;
        $this->eventDispatcher  = $eventDispatcher;
        $this->entityManager    = $entityManager;
        $this->mailer           = $mailer;
        $this->systemMail       = $sysMail;
        $this->twig             = $twig;
        $this->logger           = $logger;
    }

    /**
     * @param Request $request
     * @param User $user
     * @param string $password
     * @param boolean $oAuth
     * @return boolean
     */
    public function forceSignIn(Request $request, User $user, $password, $oAuth = false) {
        if ($oAuth === false) {
            $password = $this->encoderFactory->getEncoder($user)->encodePassword($password, $user->getSalt());
        } else {
            $password = $user->getPassword();
        }

        if ($password === $user->getPassword()) {
            $request->request->set('_remember_me', true);
            $token = new UsernamePasswordToken($user, $user->getPassword(), "secured_area", $user->getRoles());
            $this->tokenStorage->setToken($token);
            $event = new InteractiveLoginEvent($request, $token);
            $this->eventDispatcher->dispatch("security.interactive_login", $event);

            return true;
        } else {
            return false;
        }
    }

    public function signUp($email, $password = null, $name, $resource = null, $resource_id = null) {
        /** @var EntityManager $em */
        $em = $this->entityManager;
        $encoderFactory = $this->encoderFactory;
        $encoder = $encoderFactory->getEncoder(new User());

        $user = $em->getRepository('NaidusvoeBundle:User')->findOneBy([
            'email' => $email
        ]);
        $exist = ($user === null) ? false : true;

        if ($exist === false) {
            /** @var User $user */
            $user = new User();
            $user->setEmail($email);
            $user->setUsername($email);
            $user->setRegistered(new \DateTime());
            $user->setLastActive(new \DateTime());
            $user->addRole(Role::getUserRole($em));
            $user->setActive(false);
            $user->setConfirmationToken(User::generateToken());
        }

        $user->setName($name);

        if ($exist === false) {
            if ($resource !== null && $resource_id !== null || $password === null) {
                $password = User::generatePassword();
                $user->setResource($resource, $resource_id);
                $this->sendRegistrationMail($email, $password);
            }
            $user->setPassword($encoder->encodePassword($password, $user->getSalt()));
            $em->persist($user);
            $this->sendActivationMail($email, $user->getConfirmationToken());

            $settings = new UserSettings();
            $settings->setUser($user);
            $em->persist($settings);
        } else {
            $em->persist($user);
        }

        $em->flush();
        return $user;
    }

    public function oAuthLogin(Request $request, $data) {
        $response = $data['data'];
        $credentials = $data['credentials'];
        $user = $this->entityManager->getRepository('NaidusvoeBundle:User')->findOneBy([
            $response['resource'] => $response['resourceId']
        ]);

        if ($user === null) {
            if ($credentials !== null) {
                $user = $this->signUp(
                    $credentials['email'], User::generatePassword(),
                    $credentials['name'], $response['resource'],
                    $response['resourceId']
                );

                return 'registered';
            } else {
                return 'credentials';
            }
        }

        if ($user->getActive() === true) {
            return $this->forceSignIn($request, $user, null, true);
        } else {
            return 'not_active';
        }
    }

    public function confirmEmail($token) {
        $em = $this->entityManager;
        $user = $em->getRepository('NaidusvoeBundle:User')->findOneBy([
            'confirmationToken' => $token
        ]);

        if ($user !== null) {
            $user->setActive(true);
            $user->setConfirmationToken(null);
            $em->persist($user);
            $em->flush();

            return true;
        } else {
            return false;
        }
    }

    public function generatePasswordResetToken(User $user) {
        $user->setConfirmationToken($token = User::generateToken());
        $this->sendResetPasswordMail($user->getEmail(), $token);
        $this->entityManager->persist($user);
        $this->entityManager->flush();
    }

    public function changePassword($token, $data) {
        $em = $this->entityManager;
        $user = $em->getRepository('NaidusvoeBundle:User')->findOneBy([
            'confirmationToken' => $token
        ]);

        if ($user !== null) {
            $encoder = $this->encoderFactory->getEncoder(new User());
            $user->setPassword($encoder->encodePassword($data, $user->getSalt()));
            $user->setConfirmationToken(null);
            $em->persist($user);
            $em->flush();

            return true;
        } else {
            return false;
        }
    }

    /**
     * @param string $email
     * @param string $password
     */
    public function sendRegistrationMail($email, $password) {
        $message = $this->mailer->createMessage()
            ->setSubject("Реєстрація успішна")
            ->setFrom($this->systemMail)
            ->addReplyTo($this->systemMail)
            ->setTo($email)
            ->setBody(
                $this->twig->render(
                    '@Naidusvoe/registration-email.html.twig', [
                        'email' => $email,
                        'password' => $password
                    ]
                ),
                'text/html'
            )
        ;

        $this->sendMail($message);
    }

    /**
     * @param string $email
     * @param string $confirmationToken
     * @throws \Twig_Error
     */
    public function sendActivationMail($email, $confirmationToken) {
        $message = $this->mailer->createMessage()
            ->setSubject("Підтвердження email")
            ->setFrom($this->systemMail)
            ->addReplyTo($this->systemMail)
            ->setTo($email)
            ->setBody(
                $this->twig->render(
                    '@Naidusvoe/confirmation-email.html.twig', [
                        'token' => $confirmationToken
                    ]
                ),
                'text/html'
            )
        ;

        $this->sendMail($message);
    }

    /**
     * @param string $email
     */
    public function sendConfirmationSuccessMail($email) {
        $message = $this->mailer->createMessage()
            ->setSubject("Підтвердження email успішне")
            ->setFrom($this->systemMail)
            ->addReplyTo($this->systemMail)
            ->setTo($email)
            ->setBody(
                $this->twig->render(
                    '@Naidusvoe/confirmation-success-email.html.twig'
                ),
                'text/html'
            )
        ;

        $this->sendMail($message);
    }

    /**
     * @param string $email
     * @param string $token
     */
    public function sendResetPasswordMail($email, $token) {
        $message = $this->mailer->createMessage()
            ->setSubject("Відновлення паролю")
            ->setFrom($this->systemMail)
            ->addReplyTo($this->systemMail)
            ->setTo($email)
            ->setBody(
                $this->twig->render(
                    '@Naidusvoe/restore-password-email.html.twig', [
                        'token' => $token
                    ]
                ),
                'text/html'
            )
        ;

        $this->sendMail($message);
    }

    private function sendMail($message) {
        ob_start();
        $this->mailer->send($message);
        ob_get_clean();
    }
}