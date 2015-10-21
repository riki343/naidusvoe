<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\ORM\NoResultException;
use Symfony\Component\Security\Core\Encoder\EncoderFactory;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Query\Expr\Join;
use Symfony\Component\Validator\Constraints\File;
use Symfony\Component\Filesystem\Filesystem;
use NaidusvoeBundle\Entity\User;

/**
 * UserSettings
 *
 * @ORM\Table(name="user_settings")
 * @ORM\Entity
 */
class UserSettings
{
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var int
     * @ORM\Column(name="user_id", type="integer")
     */
    private $userID;

    /**
     * @var User
     * @ORM\OneToOne(targetEntity="User", inversedBy="settings")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     */
    private $user;

    /**
     * @var boolean
     * @ORM\Column(name="notifications_email", type="boolean", options={"default" = false})
     */
    private $notificationsEmail;

    /**
     * @var boolean
     * @ORM\Column(name="spam_email", type="boolean", options={"default" = false})
     */
    private $spamEmail;

    /**
     * @var boolean
     * @ORM\Column(name="notifications_sms", type="boolean", options={"default" = false})
     */
    private $notificationsSms;

    /**
     * @var string
     * @ORM\Column(name="number_for_sms", type="string", length=255, nullable=true, options={"default" = null})
     */
    private $numberForSms;

    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set userID
     *
     * @param integer $userID
     * @return UserSettings
     */
    public function setUserID($userID)
    {
        $this->userID = $userID;

        return $this;
    }

    /**
     * Get userID
     *
     * @return integer 
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * Set notificationsEmail
     *
     * @param boolean $notificationsEmail
     * @return UserSettings
     */
    public function setNotificationsEmail($notificationsEmail)
    {
        $this->notificationsEmail = $notificationsEmail;

        return $this;
    }

    /**
     * Get notificationsEmail
     *
     * @return boolean 
     */
    public function getNotificationsEmail()
    {
        return $this->notificationsEmail;
    }

    /**
     * Set spamEmail
     *
     * @param boolean $spamEmail
     * @return UserSettings
     */
    public function setSpamEmail($spamEmail)
    {
        $this->spamEmail = $spamEmail;

        return $this;
    }

    /**
     * Get spamEmail
     *
     * @return boolean 
     */
    public function getSpamEmail()
    {
        return $this->spamEmail;
    }

    /**
     * Set notificationsSms
     *
     * @param boolean $notificationsSms
     * @return UserSettings
     */
    public function setNotificationsSms($notificationsSms)
    {
        $this->notificationsSms = $notificationsSms;

        return $this;
    }

    /**
     * Get notificationsSms
     *
     * @return boolean 
     */
    public function getNotificationsSms()
    {
        return $this->notificationsSms;
    }

    /**
     * Set numberForSms
     *
     * @param string $numberForSms
     * @return UserSettings
     */
    public function setNumberForSms($numberForSms)
    {
        $this->numberForSms = $numberForSms;

        return $this;
    }

    /**
     * Get numberForSms
     *
     * @return string 
     */
    public function getNumberForSms()
    {
        return $this->numberForSms;
    }

    /**
     * Set user
     *
     * @param \NaidusvoeBundle\Entity\User $user
     * @return UserSettings
     */
    public function setUser(\NaidusvoeBundle\Entity\User $user = null)
    {
        $this->user = $user;

        return $this;
    }

    /**
     * Get user
     *
     * @return \NaidusvoeBundle\Entity\User 
     */
    public function getUser()
    {
        return $this->user;
    }
}
