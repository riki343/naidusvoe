<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use HWI\Bundle\OAuthBundle\Security\Core\User\OAuthUser;
use Symfony\Component\Security\Core\Encoder\EncoderFactory;
use Symfony\Component\Security\Core\User\UserInterface;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * User
 * @ORM\Table(name="users")
 * @ORM\Entity(repositoryClass="NaidusvoeBundle\Entity\UserRepository")
 */
class User extends OAuthUser implements UserInterface, \Serializable
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
     * @ORM\Column(name="facebook", type="string", length=255, nullable=true, options={"default"=null})
     */
    private $facebook;

    /**
     * @var string
     * @ORM\Column(name="vkontakte", type="string", length=255, nullable=true, options={"default"=null})
     */
    private $vkontakte;

    /**
     * @var string
     * @ORM\Column(name="resource_id", type="string", nullable=true)
     */
    private $resourceId;

    /**
     * @var string
     * @ORM\Column(name="username", type="string", length=255, unique=true)
     */
    protected $username;

    /**
     * @var string
     *
     * @ORM\Column(name="password", type="string", length=255)
     */
    private $password;

    /**
     * @var string
     *
     * @ORM\Column(name="email", type="string", length=255, unique=true, nullable=true)
     */
    private $email;

    /**
     * @var string
     *
     * @ORM\Column(name="name", type="string", length=255, nullable=true)
     */
    private $name;

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
     * @var string
     * @ORM\Column(name="salt", type="string", length=1000)
     */
    private $salt;

    /**
     * @var UserSettings
     * @ORM\OneToOne(targetEntity="UserSettings", mappedBy="user", cascade={"persist", "remove"})
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
     * @var ArrayCollection
     * @ORM\OneToMany(targetEntity="Advertisment", mappedBy="user", cascade={"remove"})
     * @ORM\OrderBy({"date" = "DESC"})
     */
    private $advertisments;

    /**
     * @var float
     * @ORM\Column(name="rating", type="float", options={"default" = null})
     */
    private $rating;

    /**
     * @var float
     * @ORM\Column(name="votes_count", type="integer", options={"default"=0})
     */
    private $votesCount;

    /**
     * @var array
     * @ORM\OneToMany(targetEntity="UserVote", mappedBy="user", cascade={"remove"})
     */
    private $votes;

    /**
     * @var array
     * @ORM\OneToMany(targetEntity="Order", mappedBy="user", cascade={"remove"})
     */
    private $orders;

    /**
     * @var array
     * @ORM\OneToMany(targetEntity="Payment", mappedBy="user", cascade={"remove"})
     */
    private $payments;

    /**
     * Constructor
     */
    public function __construct()
    {
        parent::__construct(null);
        $this->roles = new ArrayCollection();
        $this->name = null;
        $this->language = null;
        $this->languageid = null;
        $this->deleted = false;
        $this->advertisments = new ArrayCollection();
        $this->rating = 0;
        $this->votesCount = 0;
        $this->votes = [];
        $this->orders = [];
        $this->payments = [];
        $this->avatar = '/css/img/icon-user-default.png';
        $this->salt = base_convert(sha1(uniqid(mt_rand(), true)), 16, 36);
    }

    /**
     * @return array
     */
    public function getInArray() {
        return array(
            'id' => $this->getId(),
            'avatar' => $this->getAvatar(),
            'username' => $this->getUsername(),
            'email' => $this->getEmail(),
            'registered' => $this->getRegistered()->format('m.d.Y'),
            'name' => $this->getName(),
            'votesCount' => count($this->getVotes()),
            'rating' => $this->calculateRating($this->getVotes()),
        );
    }

    private function calculateRating($votes) {
        $rating = 0;
        /** @var UserVote $vote */
        foreach ($votes as $vote) {
            $rating += $vote->getVotePower();
        }

        if ($rating > 0) {
            $rating = round($rating / count($votes), 2);
        }

        return $rating;
    }

    public function setResource($resource, $id) {
        $this->{$resource} = $id;
    }

    public function getResource($resource) {
        return $this->{$resource};
    }

    /**
     * @param EntityManager $em
     * @param int $user_id
     * @param object $params
     */
    public static function saveContactInfo(EntityManager $em, $user_id, $params) {
        $user = $em->find('NaidusvoeBundle:User', $user_id);
        $region = $em->find('NaidusvoeBundle:Region', $params->region);
        $user->setName($params->name);
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
        return $this->salt;
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
            $this->registered,
            $this->lastactive,
            $this->active,
            $this->salt,
            $this->regionID,
            $this->languageid,
            $this->city,
            $this->regionID,
            $this->votesCount,
            $this->skype
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
            $this->registered,
            $this->lastactive,
            $this->active,
            $this->salt,
            $this->regionID,
            $this->languageid,
            $this->city,
            $this->regionID,
            $this->votesCount,
            $this->skype) = unserialize($serialized);
    }

    /**
     * @inheritDoc
     */
    public function eraseCredentials() { }

    public static function generatePassword() {
        $now = new \DateTime();
        srand($now->getTimestamp());
        $pass = '';
        $alhabet = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz';
        $numbers = '01234567899876543210';

        for ($i = 0; $i < 5; $i++) {
            $pass .= $alhabet[rand(0, 42)];
        }

        for ($i = 0; $i < 2; $i++) {
            $pass .= $numbers[rand(0, 20)];
        }

        return $pass;
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
     * Set facebook
     *
     * @param string $facebook
     * @return User
     */
    public function setFacebook($facebook)
    {
        $this->facebook = $facebook;

        return $this;
    }

    /**
     * Get facebook
     *
     * @return string 
     */
    public function getFacebook()
    {
        return $this->facebook;
    }

    /**
     * Set vkontakte
     *
     * @param string $vkontakte
     * @return User
     */
    public function setVkontakte($vkontakte)
    {
        $this->vkontakte = $vkontakte;

        return $this;
    }

    /**
     * Get vkontakte
     *
     * @return string 
     */
    public function getVkontakte()
    {
        return $this->vkontakte;
    }

    /**
     * Set resourceId
     *
     * @param string $resourceId
     * @return User
     */
    public function setResourceId($resourceId)
    {
        $this->resourceId = $resourceId;

        return $this;
    }

    /**
     * Get resourceId
     *
     * @return string 
     */
    public function getResourceId()
    {
        return $this->resourceId;
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
     * Set salt
     *
     * @param string $salt
     * @return User
     */
    public function setSalt($salt)
    {
        $this->salt = $salt;

        return $this;
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

    /**
     * Set rating
     *
     * @param float $rating
     * @return User
     */
    public function setRating($rating)
    {
        $this->rating = $rating;

        return $this;
    }

    /**
     * Get rating
     *
     * @return float 
     */
    public function getRating()
    {
        return $this->rating;
    }

    /**
     * Set votesCount
     *
     * @param integer $votesCount
     * @return User
     */
    public function setVotesCount($votesCount)
    {
        $this->votesCount = $votesCount;

        return $this;
    }

    /**
     * Get votesCount
     *
     * @return integer 
     */
    public function getVotesCount()
    {
        return $this->votesCount;
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
     * Add advertisments
     *
     * @param \NaidusvoeBundle\Entity\Advertisment $advertisments
     * @return User
     */
    public function addAdvertisment(\NaidusvoeBundle\Entity\Advertisment $advertisments)
    {
        $this->advertisments[] = $advertisments;

        return $this;
    }

    /**
     * Remove advertisments
     *
     * @param \NaidusvoeBundle\Entity\Advertisment $advertisments
     */
    public function removeAdvertisment(\NaidusvoeBundle\Entity\Advertisment $advertisments)
    {
        $this->advertisments->removeElement($advertisments);
    }

    /**
     * Get advertisments
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getAdvertisments()
    {
        return $this->advertisments;
    }

    /**
     * Add votes
     *
     * @param \NaidusvoeBundle\Entity\UserVote $votes
     * @return User
     */
    public function addVote(\NaidusvoeBundle\Entity\UserVote $votes)
    {
        $this->votes[] = $votes;

        return $this;
    }

    /**
     * Remove votes
     *
     * @param \NaidusvoeBundle\Entity\UserVote $votes
     */
    public function removeVote(\NaidusvoeBundle\Entity\UserVote $votes)
    {
        $this->votes->removeElement($votes);
    }

    /**
     * Get votes
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getVotes()
    {
        return $this->votes;
    }

    /**
     * Add orders
     *
     * @param \NaidusvoeBundle\Entity\Order $orders
     * @return User
     */
    public function addOrder(\NaidusvoeBundle\Entity\Order $orders)
    {
        $this->orders[] = $orders;

        return $this;
    }

    /**
     * Remove orders
     *
     * @param \NaidusvoeBundle\Entity\Order $orders
     */
    public function removeOrder(\NaidusvoeBundle\Entity\Order $orders)
    {
        $this->orders->removeElement($orders);
    }

    /**
     * Get orders
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getOrders()
    {
        return $this->orders;
    }

    /**
     * Add payments
     *
     * @param \NaidusvoeBundle\Entity\Payment $payments
     * @return User
     */
    public function addPayment(\NaidusvoeBundle\Entity\Payment $payments)
    {
        $this->payments[] = $payments;

        return $this;
    }

    /**
     * Remove payments
     *
     * @param \NaidusvoeBundle\Entity\Payment $payments
     */
    public function removePayment(\NaidusvoeBundle\Entity\Payment $payments)
    {
        $this->payments->removeElement($payments);
    }

    /**
     * Get payments
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getPayments()
    {
        return $this->payments;
    }
}
