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
     * @ORM\Column(name="description", type="string", length=2000)
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
     * @ORM\Column(name="advertisment_on_main_page", type="datetime", nullable=true, options={"default"=null})
     */
    private $advertismentOnMainPage;

    /**
     * @var \DateTime
     * @ORM\Column(name="advertisment_block", type="datetime", nullable=true, options={"default"=null})
     */
    private $advertismentBlock;

    /**
     * @var \DateTime
     * @ORM\Column(name="color_highlight", type="datetime", nullable=true, options={"default"=null})
     */
    private $colorHighlight;

    /**
     * @var \DateTime
     * @ORM\Column(name="category_top", type="datetime", nullable=true, options={"default"=null})
     */
    private $categoryTop;

    /**
     * @var \DateTime
     * @ORM\Column(name="urgent", type="datetime", nullable=true, options={"default"=null})
     */
    private $urgent;

    /**
     * @var string
     * @ORM\Column(name="city", type="string", nullable=true)
     */
    private $city;

    /**
     * @var string
     * @ORM\Column(name="region", type="string", length=255, nullable=true)
     */
    private $region;

    /**
     * Constructor
     */
    public function __construct() {
        $this->skype = null;
        $this->date = new \DateTime();
        $this->attachments = new ArrayCollection();
        $this->advertismentBlock = null;
        $this->advertismentOnMainPage = null;
        $this->colorHighlight = null;
        $this->urgent = null;
    }

    public function getInArray() {
        $now = new \DateTime();

        return array(
            'id' => $this->getId(),
            'title' => $this->getTitle(),
            'description' => $this->getDescription(),
            'type' => $this->getType()->getInArraySingle(),
            'category' => $this->getCategory()->getInArraySingle(),
            'subCategory' => ($this->getSubCategory())
                ? $this->getSubCategory()->getInArray()
                : null,
            'attachments' => Functions::arrayToJson($this->getAttachments()),
            'userID' => $this->getUserID(),
            'date' => $this->getDate()->format('Y-m-d'),
            'time' => $this->getDate()->format('H:i:s'),
            'price' => $this->getPrice(),
            'priceType' => $this->getPriceType()->getInArray(),
            'contactPerson' => $this->getContactPerson(),
            'email' => $this->getEmail(),
            'telephoneNumber' => $this->getTelephoneNumber(),
            'skype' => $this->getSkype(),
            'advBlock' => $this->getAdvertismentBlock(),
            'advOnMain' => $this->getAdvertismentOnMainPage(),
            'advColor' => $this->getColorHighlight(),
            'advTop' => $this->getCategoryTop(),
            'urgent' => $this->urgent,
            'city' => $this->city,
            'region' => $this->region,
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
        $adv = new Advertisment();
        $adv->setUser($user);
        $adv->setDate(new \DateTime());
        $adv->setPrice($data->price);
        $adv->setPriceType($priceType);
        $adv->setType($advType);
        $adv->setCategory($category);
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

        return $adv;
    }

    /**
     * @param EntityManager $em
     * @param int $user_id
     * @param int $adv_id
     * @return Favorites
     */
    public static function addToFav(EntityManager $em, $user_id, $adv_id) {
        /** @var Advertisment $adv */
        $adv = $em->find('NaidusvoeBundle:Advertisment', $adv_id);
        /** @var User $user */
        $user = $em->find('NaidusvoeBundle:User', $user_id);

        $fav = new Favorites();
        $fav->setUser($user);
        $fav->setAdvertisment($adv);

        $em->persist($fav);
        $em->flush();
        return $fav;
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
     * Set advertismentOnMainPage
     *
     * @param boolean $advertismentOnMainPage
     * @return Advertisment
     */
    public function setAdvertismentOnMainPage($advertismentOnMainPage)
    {
        $this->advertismentOnMainPage = $advertismentOnMainPage;

        return $this;
    }

    /**
     * Get advertismentOnMainPage
     *
     * @return boolean 
     */
    public function getAdvertismentOnMainPage()
    {
        return $this->advertismentOnMainPage;
    }

    /**
     * Set advertismentBlock
     *
     * @param boolean $advertismentBlock
     * @return Advertisment
     */
    public function setAdvertismentBlock($advertismentBlock)
    {
        $this->advertismentBlock = $advertismentBlock;

        return $this;
    }

    /**
     * Get advertismentBlock
     *
     * @return boolean 
     */
    public function getAdvertismentBlock()
    {
        return $this->advertismentBlock;
    }

    /**
     * Set colorHighlight
     *
     * @param boolean $colorHighlight
     * @return Advertisment
     */
    public function setColorHighlight($colorHighlight)
    {
        $this->colorHighlight = $colorHighlight;

        return $this;
    }

    /**
     * Get colorHighlight
     *
     * @return boolean 
     */
    public function getColorHighlight()
    {
        return $this->colorHighlight;
    }

    /**
     * Set categoryTop
     *
     * @param boolean $categoryTop
     * @return Advertisment
     */
    public function setCategoryTop($categoryTop)
    {
        $this->categoryTop = $categoryTop;

        return $this;
    }

    /**
     * Get categoryTop
     *
     * @return boolean 
     */
    public function getCategoryTop()
    {
        return $this->categoryTop;
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
     * Set urgent
     *
     * @param \DateTime $urgent
     * @return Advertisment
     */
    public function setUrgent($urgent)
    {
        $this->urgent = $urgent;

        return $this;
    }

    /**
     * Get urgent
     *
     * @return \DateTime 
     */
    public function getUrgent()
    {
        return $this->urgent;
    }

    /**
     * Set region
     *
     * @param string $region
     * @return Advertisment
     */
    public function setRegion($region)
    {
        $this->region = $region;

        return $this;
    }

    /**
     * Get region
     *
     * @return string 
     */
    public function getRegion()
    {
        return $this->region;
    }
}
