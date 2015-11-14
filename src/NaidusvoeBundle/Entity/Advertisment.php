<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * Advertisment
 *
 * @ORM\Table(name="advertisments")
 * @ORM\Entity
 */
class Advertisment
{
    /**
     * @var integer
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     * @ORM\Column(name="title", type="string", length=255)
     */
    private $title;

    /**
     * @var string
     * @ORM\Column(name="description", type="string", length=10000)
     */
    private $description;

    /**
     * @var \DateTime
     * @ORM\Column(name="date", type="datetime")
     */
    private $date;

    /**
     * @var int
     * @ORM\Column(name="user_id", type="integer", nullable=true, options={"default"=null})
     */
    private $userID;

    /**
     * @var User
     * @ORM\ManyToOne(targetEntity="User", inversedBy="advertisments")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     */
    private $user;

    /**
     * @var int
     * @ORM\Column(name="type_id", type="integer", nullable=true, options={"default"=null})
     */
    private $typeID;

    /**
     * @var AdvertismentType
     * @ORM\ManyToOne(targetEntity="AdvertismentType")
     * @ORM\JoinColumn(name="type_id", referencedColumnName="id")
     */
    private $type;
    
    /**
     * @var integer
     * @ORM\Column(name="category_id", type="integer")
     */
    private $categoryID;

    /**
     * @var AdvertismentCategory
     * @ORM\ManyToOne(targetEntity="AdvertismentCategory")
     * @ORM\JoinColumn(name="category_id", referencedColumnName="id")
     */
    private $category;

    /**
     * @var integer
     * @ORM\Column(name="sub_category_id", type="integer", nullable=true, options={"default" = null})
     */
    private $subCategoryID;

    /**
     * @var AdvertismentSubCategory
     * @ORM\ManyToOne(targetEntity="AdvertismentSubCategory")
     * @ORM\JoinColumn(name="sub_category_id", referencedColumnName="id")
     */
    private $subCategory;

    /**
     * @var ArrayCollection
     * @ORM\OneToMany(targetEntity="Attachment", mappedBy="advertisment", cascade={"remove"})
     */
    private $attachments;

    /**
     * @var integer
     * @ORM\Column(name="price", type="float")
     */
    private $price;

    /**
     * @var integer
     * @ORM\Column(name="price_type_id", type="integer")
     */
    private $priceTypeID;

    /**
     * @var AdvertismentType
     * @ORM\ManyToOne(targetEntity="PriceType")
     * @ORM\JoinColumn(name="price_type_id", referencedColumnName="id")
     */
    private $priceType;

    /**
     * @var string
     * @ORM\Column(name="contact_person", type="string")
     */
    private $contactPerson;

    /**
     * @var string
     * @ORM\Column(name="email", type="string")
     */
    private $email;

    /**
     * @var string
     * @ORM\Column(name="telephone_number", type="string")
     */
    private $telephoneNumber;

    /**
     * @var string
     * @ORM\Column(name="skype", type="string", nullable=true, options={"default" = null})
     */
    private $skype;

    /**
     * @var \DateTime
     * @ORM\Column(name="on_main_untill", type="datetime", nullable=true, options={"default"=null})
     */
    private $onMainUntill;

    /**
     * @var \DateTime
     * @ORM\Column(name="on_top_untill", type="datetime", nullable=true, options={"default"=null})
     */
    private $onTopUntill;

    /**
     * @var \DateTime
     * @ORM\Column(name="filled_untill", type="datetime", nullable=true, options={"default"=null})
     */
    private $filledUntill;

    /**
     * @var \DateTime
     * @ORM\Column(name="urgent_untill", type="datetime", nullable=true, options={"default"=null})
     */
    private $urgentUntill;

    /**
     * @var \DateTime
     * @ORM\Column(name="on_block_untill", type="datetime", nullable=true, options={"default"=null})
     */
    private $onBlockUntill;

    /**
     * @var string
     * @ORM\Column(name="city", type="string", nullable=true)
     */
    private $city;

    /**
     * @var integer
     * @ORM\Column(name="region_id", type="integer", options={"default"=1})
     */
    private $regionId;

    /**
     * @var Region
     * @ORM\ManyToOne(targetEntity="NaidusvoeBundle\Entity\Region")
     * @ORM\JoinColumn(name="region_id", referencedColumnName="id")
     */
    private $region;

    /**
     * @var array
     * @ORM\OneToMany(targetEntity="Conversation", mappedBy="advertisment", cascade={"persist", "remove"}, fetch="EXTRA_LAZY")
     */
    private $conversations;

    /**
     * @var array
     * @ORM\OneToMany(targetEntity="Favorites", mappedBy="advertisment", cascade={"remove"}, fetch="EXTRA_LAZY")
     */
    private $favorites;

    /**
     * @var array
     * @ORM\OneToMany(targetEntity="Order", mappedBy="advertisement", cascade={"remove"}, fetch="EXTRA_LAZY")
     */
    private $orders;

    /**
     * @var array
     * @ORM\OneToMany(targetEntity="Payment", mappedBy="advertisement", cascade={"remove"}, fetch="EXTRA_LAZY")
     */
    private $payments;

    private $dummy;

    /**
     * Constructor
     */
    public function __construct() {
        $this->skype = null;
        $this->date = new \DateTime();
        $this->attachments = new ArrayCollection();
        $this->orders = [];
        $this->payments = [];
        $this->conversations = [];
        $this->dummy = false;
    }

    public function getInArray() {
        $onMain = $this->getOnMainUntill();
        $onTop  = $this->getOnTopUntill();
        $filled = $this->getFilledUntill();
        $urgent = $this->getUrgentUntill();
        $block  = $this->getOnBlockUntill();

        return array(
            'id'                => $this->getId(),
            'title'             => $this->getTitle(),
            'description'       => $this->getDescription(),
            'type'              => $this->getType()->getInArraySingle(),
            'category'          => (!$this->dummy) ?  $this->getCategory()->getInArraySingle() : null,
            'subCategory'       => ($this->getSubCategory()) ? $this->getSubCategory()->getInArray() : null,
            'attachments'       => Functions::arrayToJson($this->getAttachments()),
            'userID'            => $this->getUserID(),
            'price'             => $this->getPrice(),
            'priceType'         => (!$this->dummy) ?  $this->getPriceType()->getInArray() : null,
            'contactPerson'     => $this->getContactPerson(),
            'email'             => $this->getEmail(),
            'telephoneNumber'   => $this->getTelephoneNumber(),
            'skype'             => $this->getSkype(),
            'city'              => $this->city,
            'region'            => (!$this->dummy) ? $this->region->getInArray() : null,
            'date'              => $this->date->format('m.d.Y'),
            'time'              => $this->date->format('H:i:s'),
            'dummy'             => ($this->dummy),
            'onMain'            => ($onMain !== null) ? $onMain->format('d.m.Y') : null,
            'onTop'             => ($onTop !== null)  ? $onTop->format('d.m.Y')  : null,
            'filled'            => ($filled !== null) ? $filled->format('d.m.Y') : null,
            'urgent'            => ($urgent !== null) ? $urgent->format('d.m.Y') : null,
            'block'             => ($block !== null)  ? $block->format('d.m.Y')  : null,
        );
    }

    /**
     * @param EntityManager $em
     * @param object $data
     * @param int $user_id
     * @return Advertisment
     */
    public static function addNewAdv(EntityManager $em, $data, $user_id) {
        $user = $em->find('NaidusvoeBundle:User', $user_id);
        $category = $em->getRepository('NaidusvoeBundle:AdvertismentCategory')->find($data->categoryID);
        $priceType = $em->getRepository('NaidusvoeBundle:PriceType')->find($data->priceType);
        $advType = $em->getRepository('NaidusvoeBundle:AdvertismentType')->find($data->typeID);
        $region = $em->getRepository('NaidusvoeBundle:Region')->find($data->region);

        $adv = new Advertisment();
        $adv->setUser($user);
        $adv->setDate(new \DateTime());
        $adv->setPrice($data->price);
        $adv->setPriceType($priceType);
        $adv->setType($advType);
        $adv->setCategory($category);
        $adv->setRegion($region);
        if ($data->subCategoryID) {
            $subCategory = $em->getRepository('NaidusvoeBundle:AdvertismentSubCategory')
                ->find($data->subCategoryID);
            $adv->setSubCategory($subCategory);
        }
        $adv->setTitle($data->title);
        $adv->setDescription($data->description);
        $adv->setContactPerson($data->contactPerson);
        $adv->setEmail($data->email);
        $adv->setTelephoneNumber($data->telephoneNumber);
        $adv->setSkype($data->skype);
        $adv->setCity($data->city);

        return $adv;
    }

    /**
     * @param EntityManager $em
     * @param int|null $filter
     * @param int $type_id
     * @return array
     */
    public static function getAdvs(EntityManager $em, $filter, $type_id) {
        $qb = $em->createQueryBuilder();
        $query = $qb->select('a');
        $query->from('NaidusvoeBundle:Advertisment', 'a');
        $query->where('a.typeID = :type_id');
        $query->setParameter('type_id', $type_id);
        if ($filter !== null && $filter != 'null') {
            $query->andWhere('a.categoryID = :param');
            $query->setParameter('param', $filter);
        }
        $query->orderBy('a.date', 'DESC');
        return $query->getQuery();
    }

    /**
     * @param Order $order
     * @return null|Advertisment
     */
    public function activateAdditionalFeatures(Order $order) {
        $now = new \DateTime();
        if ($order !== null) {
            if ($order->getAdvOnMain() === true) {
                $this->setOnMainUntill($now->modify('+' . $order->getAdvOnMainPeriod() . ' days'));
            }

            if ($order->getAdvOnTop() === true) {
                $this->setOnTopUntill($now->modify('+' . $order->getAdvOnTopPeriod() . ' days'));
            }

            if ($order->getAdvFilled() === true) {
                $this->setFilledUntill($now->modify('+' . $order->getAdvFilledPeriod() . ' days'));
            }

            if ($order->getAdvUrgent() === true) {
                $this->setUrgentUntill($now->modify('+' . $order->getAdvUrgentPeriod() . ' days'));
            }

            if ($order->getAdvUpdate() === true) {
                $this->setDate($now);
            }

            if ($order->getAdvBlock() === true) {
                $this->setOnBlockUntill($now->modify('+' . $order->getAdvBlockPeriod() . ' days'));
            }

            return $this;
        } else {
            return null;
        }
    }

    public function setDummy($isDummy) {
        $this->dummy = $isDummy;
    }

    public function getDummy() {
        return $this->dummy;
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
     * Set title
     *
     * @param string $title
     * @return Advertisment
     */
    public function setTitle($title)
    {
        $this->title = $title;

        return $this;
    }

    /**
     * Get title
     *
     * @return string 
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * Set description
     *
     * @param string $description
     * @return Advertisment
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Get description
     *
     * @return string 
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set date
     *
     * @param \DateTime $date
     * @return Advertisment
     */
    public function setDate($date)
    {
        $this->date = $date;

        return $this;
    }

    /**
     * Get date
     *
     * @return \DateTime 
     */
    public function getDate()
    {
        return $this->date;
    }

    /**
     * Set userID
     *
     * @param integer $userID
     * @return Advertisment
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
     * Set typeID
     *
     * @param integer $typeID
     * @return Advertisment
     */
    public function setTypeID($typeID)
    {
        $this->typeID = $typeID;

        return $this;
    }

    /**
     * Get typeID
     *
     * @return integer 
     */
    public function getTypeID()
    {
        return $this->typeID;
    }

    /**
     * Set categoryID
     *
     * @param integer $categoryID
     * @return Advertisment
     */
    public function setCategoryID($categoryID)
    {
        $this->categoryID = $categoryID;

        return $this;
    }

    /**
     * Get categoryID
     *
     * @return integer 
     */
    public function getCategoryID()
    {
        return $this->categoryID;
    }

    /**
     * Set subCategoryID
     *
     * @param integer $subCategoryID
     * @return Advertisment
     */
    public function setSubCategoryID($subCategoryID)
    {
        $this->subCategoryID = $subCategoryID;

        return $this;
    }

    /**
     * Get subCategoryID
     *
     * @return integer 
     */
    public function getSubCategoryID()
    {
        return $this->subCategoryID;
    }

    /**
     * Set price
     *
     * @param float $price
     * @return Advertisment
     */
    public function setPrice($price)
    {
        $this->price = $price;

        return $this;
    }

    /**
     * Get price
     *
     * @return float 
     */
    public function getPrice()
    {
        return $this->price;
    }

    /**
     * Set priceTypeID
     *
     * @param integer $priceTypeID
     * @return Advertisment
     */
    public function setPriceTypeID($priceTypeID)
    {
        $this->priceTypeID = $priceTypeID;

        return $this;
    }

    /**
     * Get priceTypeID
     *
     * @return integer 
     */
    public function getPriceTypeID()
    {
        return $this->priceTypeID;
    }

    /**
     * Set contactPerson
     *
     * @param string $contactPerson
     * @return Advertisment
     */
    public function setContactPerson($contactPerson)
    {
        $this->contactPerson = $contactPerson;

        return $this;
    }

    /**
     * Get contactPerson
     *
     * @return string 
     */
    public function getContactPerson()
    {
        return $this->contactPerson;
    }

    /**
     * Set email
     *
     * @param string $email
     * @return Advertisment
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
     * Set telephoneNumber
     *
     * @param string $telephoneNumber
     * @return Advertisment
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
     * @return Advertisment
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
     * Set onMainUntill
     *
     * @param \DateTime $onMainUntill
     * @return Advertisment
     */
    public function setOnMainUntill($onMainUntill)
    {
        $this->onMainUntill = $onMainUntill;

        return $this;
    }

    /**
     * Get onMainUntill
     *
     * @return \DateTime 
     */
    public function getOnMainUntill()
    {
        return $this->onMainUntill;
    }

    /**
     * Set onTopUntill
     *
     * @param \DateTime $onTopUntill
     * @return Advertisment
     */
    public function setOnTopUntill($onTopUntill)
    {
        $this->onTopUntill = $onTopUntill;

        return $this;
    }

    /**
     * Get onTopUntill
     *
     * @return \DateTime 
     */
    public function getOnTopUntill()
    {
        return $this->onTopUntill;
    }

    /**
     * Set filledUntill
     *
     * @param \DateTime $filledUntill
     * @return Advertisment
     */
    public function setFilledUntill($filledUntill)
    {
        $this->filledUntill = $filledUntill;

        return $this;
    }

    /**
     * Get filledUntill
     *
     * @return \DateTime 
     */
    public function getFilledUntill()
    {
        return $this->filledUntill;
    }

    /**
     * Set urgentUntill
     *
     * @param \DateTime $urgentUntill
     * @return Advertisment
     */
    public function setUrgentUntill($urgentUntill)
    {
        $this->urgentUntill = $urgentUntill;

        return $this;
    }

    /**
     * Get urgentUntill
     *
     * @return \DateTime 
     */
    public function getUrgentUntill()
    {
        return $this->urgentUntill;
    }

    /**
     * Set onBlockUntill
     *
     * @param \DateTime $onBlockUntill
     * @return Advertisment
     */
    public function setOnBlockUntill($onBlockUntill)
    {
        $this->onBlockUntill = $onBlockUntill;

        return $this;
    }

    /**
     * Get onBlockUntill
     *
     * @return \DateTime 
     */
    public function getOnBlockUntill()
    {
        return $this->onBlockUntill;
    }

    /**
     * Set city
     *
     * @param string $city
     * @return Advertisment
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
     * Set regionId
     *
     * @param integer $regionId
     * @return Advertisment
     */
    public function setRegionId($regionId)
    {
        $this->regionId = $regionId;

        return $this;
    }

    /**
     * Get regionId
     *
     * @return integer 
     */
    public function getRegionId()
    {
        return $this->regionId;
    }

    /**
     * Set user
     *
     * @param \NaidusvoeBundle\Entity\User $user
     * @return Advertisment
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

    /**
     * Set type
     *
     * @param \NaidusvoeBundle\Entity\AdvertismentType $type
     * @return Advertisment
     */
    public function setType(\NaidusvoeBundle\Entity\AdvertismentType $type = null)
    {
        $this->type = $type;

        return $this;
    }

    /**
     * Get type
     *
     * @return \NaidusvoeBundle\Entity\AdvertismentType 
     */
    public function getType()
    {
        return $this->type;
    }

    /**
     * Set category
     *
     * @param \NaidusvoeBundle\Entity\AdvertismentCategory $category
     * @return Advertisment
     */
    public function setCategory(\NaidusvoeBundle\Entity\AdvertismentCategory $category = null)
    {
        $this->category = $category;

        return $this;
    }

    /**
     * Get category
     *
     * @return \NaidusvoeBundle\Entity\AdvertismentCategory 
     */
    public function getCategory()
    {
        return $this->category;
    }

    /**
     * Set subCategory
     *
     * @param \NaidusvoeBundle\Entity\AdvertismentSubCategory $subCategory
     * @return Advertisment
     */
    public function setSubCategory(\NaidusvoeBundle\Entity\AdvertismentSubCategory $subCategory = null)
    {
        $this->subCategory = $subCategory;

        return $this;
    }

    /**
     * Get subCategory
     *
     * @return \NaidusvoeBundle\Entity\AdvertismentSubCategory 
     */
    public function getSubCategory()
    {
        return $this->subCategory;
    }

    /**
     * Add attachments
     *
     * @param \NaidusvoeBundle\Entity\Attachment $attachments
     * @return Advertisment
     */
    public function addAttachment(\NaidusvoeBundle\Entity\Attachment $attachments)
    {
        $this->attachments[] = $attachments;

        return $this;
    }

    /**
     * Remove attachments
     *
     * @param \NaidusvoeBundle\Entity\Attachment $attachments
     */
    public function removeAttachment(\NaidusvoeBundle\Entity\Attachment $attachments)
    {
        $this->attachments->removeElement($attachments);
    }

    /**
     * Get attachments
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getAttachments()
    {
        return $this->attachments;
    }

    /**
     * Set priceType
     *
     * @param \NaidusvoeBundle\Entity\PriceType $priceType
     * @return Advertisment
     */
    public function setPriceType(\NaidusvoeBundle\Entity\PriceType $priceType = null)
    {
        $this->priceType = $priceType;

        return $this;
    }

    /**
     * Get priceType
     *
     * @return \NaidusvoeBundle\Entity\PriceType 
     */
    public function getPriceType()
    {
        return $this->priceType;
    }

    /**
     * Set region
     *
     * @param \NaidusvoeBundle\Entity\Region $region
     * @return Advertisment
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
     * Add conversations
     *
     * @param \NaidusvoeBundle\Entity\Conversation $conversations
     * @return Advertisment
     */
    public function addConversation(\NaidusvoeBundle\Entity\Conversation $conversations)
    {
        $this->conversations[] = $conversations;

        return $this;
    }

    /**
     * Remove conversations
     *
     * @param \NaidusvoeBundle\Entity\Conversation $conversations
     */
    public function removeConversation(\NaidusvoeBundle\Entity\Conversation $conversations)
    {
        $this->conversations->removeElement($conversations);
    }

    /**
     * Get conversations
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getConversations()
    {
        return $this->conversations;
    }

    /**
     * Add favorites
     *
     * @param \NaidusvoeBundle\Entity\Favorites $favorites
     * @return Advertisment
     */
    public function addFavorite(\NaidusvoeBundle\Entity\Favorites $favorites)
    {
        $this->favorites[] = $favorites;

        return $this;
    }

    /**
     * Remove favorites
     *
     * @param \NaidusvoeBundle\Entity\Favorites $favorites
     */
    public function removeFavorite(\NaidusvoeBundle\Entity\Favorites $favorites)
    {
        $this->favorites->removeElement($favorites);
    }

    /**
     * Get favorites
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getFavorites()
    {
        return $this->favorites;
    }

    /**
     * Add orders
     *
     * @param \NaidusvoeBundle\Entity\Order $orders
     * @return Advertisment
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
     * @return Advertisment
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
