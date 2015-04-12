<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\ORM\NoResultException;
use Symfony\Component\Security\Core\Encoder\EncoderFactory;
use Symfony\Component\Security\Core\User\UserInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Query\Expr\Join;
use Symfony\Component\Validator\Constraints\File;
use Symfony\Component\Filesystem\Filesystem;

/**
 * User
 *
 * @ORM\Table(name="users")
 * @ORM\Entity(repositoryClass="NaidusvoeBundle\Entity\UserRepository")
 */
class User implements UserInterface, \Serializable
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
     * @var string
     *
     * @ORM\Column(name="username", type="string", length=255, unique=true)
     */
    private $username;

    /**
     * @var string
     *
     * @ORM\Column(name="password", type="string", length=255)
     */
    private $password;

    /**
     * @var string
     *
     * @ORM\Column(name="email", type="string", length=255, unique=true)
     */
    private $email;

    /**
     * @var string
     *
     * @ORM\Column(name="name", type="string", length=255, nullable=true)
     */
    private $name;

    /**
     * @var string
     *
     * @ORM\Column(name="surname", type="string", length=255, nullable=true)
     */
    private $surname;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="registered", type="datetime")
     */
    private $registered;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="lastactive", type="datetime")
     */
    private $lastactive;

    /**
     * @var boolean
     * @ORM\Column(name="active", type="boolean")
     */
    private $active;

    /**
     * @ORM\ManyToMany(targetEntity="Role")
     * @ORM\JoinTable(name="user_role",
     *     joinColumns={@ORM\JoinColumn(name="user_id", referencedColumnName="id")},
     *     inverseJoinColumns={@ORM\JoinColumn(name="role_id", referencedColumnName="id")}
     * )
     * @var ArrayCollection $roles
     */
    protected $roles;

    /**
     * @var UserSettings
     * @ORM\OneToOne(targetEntity="UserSettings", mappedBy="user")
     */
    private $settings;

    /**
     * @var string
     * @ORM\Column(name="avatar", type="string", length=255, nullable=true, options={"default" = null})
     */
    private $avatar;

    /**
     * @var int
     * @ORM\Column(name="language_id", type="integer", nullable=true, options={"default" = null})
     */
    private $languageid;

    /**
     * @var Language
     * @ORM\ManyToOne(targetEntity="Language")
     * @ORM\JoinColumn(name="language_id", referencedColumnName="id")
     */
    private $language;

    /**
     * @var string
     * @ORM\Column(name="telephone_number", type="string", nullable=true, options={"default" = null})
     */
    private $telephoneNumber;

    /**
     * @var string
     * @ORM\Column(name="skype", type="string", nullable=true, options={"default" = null})
     */
    private $skype;

    /**
     * @var string
     * @ORM\Column(name="region_id", type="integer", nullable=true, options={"default" = null})
     */
    private $regionID;

    /**
     * @var Region
     * @ORM\ManyToOne(targetEntity="Region")
     * @ORM\JoinColumn(name="region_id", referencedColumnName="id")
     */
    private $region;

    /**
     * @var string
     * @ORM\Column(name="city", type="string", length=255, nullable=true, options={"default" = null})
     */
    private $city;

    /**
     * @var boolean
     * @ORM\Column(name="deleted", type="boolean", options={"default" = false})
     */
    private $deleted;

    /**
     * @param EntityManager $em
     * @param int $user_id
     * @param object $params
     */
    public static function saveContactInfo(EntityManager $em, $user_id, $params) {
        $user = $em->find('NaidusvoeBundle:User', $user_id);
        $region = $em->find('NaidusvoeBundle:Region', $params->region);
        $user->setName($params->name);
        $user->setSurname($params->surname);
        $user->setCity($params->city);
        $user->setRegion($region);
        $user->setTelephoneNumber($params->telephoneNumber);
        $user->setSkype($params->skype);

        $em->persist($user);
        $em->flush();
    }

    /**
     * @param EntityManager $em
     * @param int $user_id
     * @param string $encodedPass
     */
    public static function changePassword(EntityManager $em, $user_id, $encodedPass) {
        $user = $em->find('NaidusvoeBundle:User', $user_id);
        $user->setPassword($encodedPass);
        $em->persist($user);
        $em->flush();
    }

    /**
     * @param EntityManager $em
     * @param int $user_id
     * @param string $email
     */
    public static function changeEmail(EntityManager $em, $user_id, $email) {
        $user = $em->find('NaidusvoeBundle:User', $user_id);
        $user->setEmail($email);
        $user->setActive(false);
        $em->persist($user);
        $em->flush();
    }

    /**
     * @param EntityManager $em
     * @param int $user_id
     * @param object $params
     */
    public static function changeEmailNotificationsSettings(EntityManager $em, $user_id, $params) {
        /** @var User $user */
        $user = $em->getRepository('NaidusvoeBundle:User')->find($user_id);
        /** @var UserSettings $userSettings */
        $userSettings = $user->getSettings();
        $userSettings->setNotificationsEmail($params->notifications);
        $userSettings->setSpamEmail($params->spam);
        $em->persist($userSettings);
        $em->flush();
    }

    /**
     * @param EntityManager $em
     * @param int $user_id
     * @param object $params
     */
    public static function changeSmsNotificationsSettings(EntityManager $em, $user_id, $params) {
        /** @var User $user */
        $user = $em->getRepository('NaidusvoeBundle:User')->find($user_id);
        /** @var UserSettings $userSettings */
        $userSettings = $user->getSettings();
        $userSettings->setNotificationsSms($params->notifications);
        if ($params->telephoneNumber) {
            $userSettings->setNumberForSms($params->telephoneNumber);
        }
        $em->persist($userSettings);
        $em->flush();
    }

    /**
     * Get password
     * @return string
     */
    public function getPassword() {
        return $this->password;
    }

    /**
     * Get username
     * @return string
     */
    public function getUsername()
    {
        return $this->username;
    }

    /**
     * @inheritDoc
     */
    public function getRoles()
    {
        return $this->roles->toArray();
    }

    /**
     * @inheritDoc
     */
    public function getSalt()
    {
        return '7v8b6ghjb6834bdkjndsjb233409fjvsiu8892d';
    }

    /**
     * @see \Serializable::serialize()
     */
    public function serialize()
    {
        return serialize(array(
            $this->id,
            $this->username,
            $this->password,
            $this->email,
            $this->name,
            $this->surname,
            $this->registered,
            $this->lastactive,
            $this->active
        ));
    }

    /**
     * @see \Serializable::unserialize()
     */
    public function unserialize($serialized)
    {
        list(
            $this->id,
            $this->username,
            $this->password,
            $this->email,
            $this->name,
            $this->surname,
            $this->registered,
            $this->lastactive,
            $this->active) = unserialize($serialized);
    }

    /**
     * @inheritDoc
     */
    public function eraseCredentials() { }

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->roles = new ArrayCollection();
        $this->name = null;
        $this->surname = null;
        $this->language = null;
        $this->languageid = null;
        $this->deleted = false;
    }

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
     * Set username
     *
     * @param string $username
     * @return User
     */
    public function setUsername($username)
    {
        $this->username = $username;

        return $this;
    }

    /**
     * Set password
     *
     * @param string $password
     * @return User
     */
    public function setPassword($password)
    {
        $this->password = $password;

        return $this;
    }

    /**
     * Set email
     *
     * @param string $email
     * @return User
     */
    public function setEmail($email)
    {
        $this->email = $email;

        return $this;
    }

    /**
     * Get email
     *
     * @return string 
     */
    public function getEmail()
    {
        return $this->email;
    }

    /**
     * Set name
     *
     * @param string $name
     * @return User
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string 
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set surname
     *
     * @param string $surname
     * @return User
     */
    public function setSurname($surname)
    {
        $this->surname = $surname;

        return $this;
    }

    /**
     * Get surname
     *
     * @return string 
     */
    public function getSurname()
    {
        return $this->surname;
    }

    /**
     * Set registered
     *
     * @param \DateTime $registered
     * @return User
     */
    public function setRegistered($registered)
    {
        $this->registered = $registered;

        return $this;
    }

    /**
     * Get registered
     *
     * @return \DateTime 
     */
    public function getRegistered()
    {
        return $this->registered;
    }

    /**
     * Set lastactive
     *
     * @param \DateTime $lastactive
     * @return User
     */
    public function setLastactive($lastactive)
    {
        $this->lastactive = $lastactive;

        return $this;
    }

    /**
     * Get lastactive
     *
     * @return \DateTime 
     */
    public function getLastactive()
    {
        return $this->lastactive;
    }

    /**
     * Set active
     *
     * @param boolean $active
     * @return User
     */
    public function setActive($active)
    {
        $this->active = $active;

        return $this;
    }

    /**
     * Get active
     *
     * @return boolean 
     */
    public function getActive()
    {
        return $this->active;
    }

    /**
     * Set avatar
     *
     * @param string $avatar
     * @return User
     */
    public function setAvatar($avatar)
    {
        $this->avatar = $avatar;

        return $this;
    }

    /**
     * Get avatar
     *
     * @return string 
     */
    public function getAvatar()
    {
        return $this->avatar;
    }

    /**
     * Add roles
     *
     * @param \NaidusvoeBundle\Entity\Role $roles
     * @return User
     */
    public function addRole(\NaidusvoeBundle\Entity\Role $roles)
    {
        $this->roles[] = $roles;

        return $this;
    }

    /**
     * Remove roles
     *
     * @param \NaidusvoeBundle\Entity\Role $roles
     */
    public function removeRole(\NaidusvoeBundle\Entity\Role $roles)
    {
        $this->roles->removeElement($roles);
    }

    /**
     * @param EntityManager $em
     * @param EncoderFactory $encoderFactory
     * @param array $parameters
     * @return User
     */
    public static function addUser($em, $encoderFactory, $parameters)
    {
        /** @var User $user */
        $user = new User();
        $encoder = $encoderFactory->getEncoder($user);
        $user->setEmail($parameters['email']);
        $user->setUsername($parameters['username']);
        $user->setPassword($encoder->encodePassword($parameters['password'], $user->getSalt()));
        $user->setRegistered(new \DateTime());
        $user->setLastActive(new \DateTime());
        $user->addRole(Role::getUserRole($em));
        $user->setActive(false);
        $em->persist($user);

        $settings = new UserSettings();
        $settings->setUser($user);

        $em->flush();
        return $user;
    }

    /**
     * Set languageid
     *
     * @param integer $languageid
     * @return User
     */
    public function setLanguageid($languageid)
    {
        $this->languageid = $languageid;

        return $this;
    }

    /**
     * Get languageid
     *
     * @return integer 
     */
    public function getLanguageid()
    {
        return $this->languageid;
    }

    /**
     * Set language
     *
     * @param \NaidusvoeBundle\Entity\Language $language
     * @return User
     */
    public function setLanguage(\NaidusvoeBundle\Entity\Language $language = null)
    {
        $this->language = $language;

        return $this;
    }

    /**
     * Get language
     *
     * @return \NaidusvoeBundle\Entity\Language 
     */
    public function getLanguage()
    {
        return $this->language;
    }

    /**
     * Set telephoneNumber
     *
     * @param string $telephoneNumber
     * @return User
     */
    public function setTelephoneNumber($telephoneNumber)
    {
        $this->telephoneNumber = $telephoneNumber;

        return $this;
    }

    /**
     * Get telephoneNumber
     *
     * @return string 
     */
    public function getTelephoneNumber()
    {
        return $this->telephoneNumber;
    }

    /**
     * Set skype
     *
     * @param string $skype
     * @return User
     */
    public function setSkype($skype)
    {
        $this->skype = $skype;

        return $this;
    }

    /**
     * Get skype
     *
     * @return string 
     */
    public function getSkype()
    {
        return $this->skype;
    }
    
    /**
     * Set city
     *
     * @param string $city
     * @return User
     */
    public function setCity($city)
    {
        $this->city = $city;

        return $this;
    }

    /**
     * Get city
     *
     * @return string 
     */
    public function getCity()
    {
        return $this->city;
    }

    /**
     * Set settings
     *
     * @param \NaidusvoeBundle\Entity\UserSettings $settings
     * @return User
     */
    public function setSettings(\NaidusvoeBundle\Entity\UserSettings $settings = null)
    {
        $this->settings = $settings;

        return $this;
    }

    /**
     * Get settings
     *
     * @return \NaidusvoeBundle\Entity\UserSettings 
     */
    public function getSettings()
    {
        return $this->settings;
    }

    /**
     * Set regionID
     *
     * @param integer $regionID
     * @return User
     */
    public function setRegionID($regionID)
    {
        $this->regionID = $regionID;

        return $this;
    }

    /**
     * Get regionID
     *
     * @return integer 
     */
    public function getRegionID()
    {
        return $this->regionID;
    }

    /**
     * Set region
     *
     * @param \NaidusvoeBundle\Entity\Region $region
     * @return User
     */
    public function setRegion(\NaidusvoeBundle\Entity\Region $region = null)
    {
        $this->region = $region;

        return $this;
    }

    /**
     * Get region
     *
     * @return \NaidusvoeBundle\Entity\Region 
     */
    public function getRegion()
    {
        return $this->region;
    }

    /**
     * Set deleted
     *
     * @param boolean $deleted
     * @return User
     */
    public function setDeleted($deleted)
    {
        $this->deleted = $deleted;

        return $this;
    }

    /**
     * Get deleted
     *
     * @return boolean 
     */
    public function getDeleted()
    {
        return $this->deleted;
    }
}
