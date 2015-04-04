<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * AdvertismentCategory
 *
 * @ORM\Table(name="advertisment_categories")
 * @ORM\Entity
 */
class AdvertismentCategory
{
    /**
     * @var integer
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var int
     * @ORM\Column(name="type_id", type="integer")
     */
    private $typeID;

    /**
     * @var AdvertismentType
     * @ORM\ManyToOne(targetEntity="AdvertismentType")
     * @ORM\JoinColumn(name="type_id", referencedColumnName="id")
     */
    private $type;

    /**
     * @var ArrayCollection
     * @ORM\OneToMany(targetEntity="AdvertismentSubCategory", mappedBy="category")
     */
    private $subCategories;

    /**
     * @var string
     * @ORM\Column(name="title", type="string", length=255)
     */
    private $name;

    public function getInArray() {
        return array(
            'id' => $this->getId(),
            'typeID' => $this->getTypeID(),
            'type' => $this->getType()->getInArray(),
            'name' => $this->getName(),
            'subCategories' => Functions::arrayToJson($this->getSubCategories()),
        );
    }
    /**
     * Constructor
     */
    public function __construct()
    {
        $this->subCategories = new \Doctrine\Common\Collections\ArrayCollection();
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
     * Set typeID
     *
     * @param integer $typeID
     * @return AdvertismentCategory
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
     * Set name
     *
     * @param string $name
     * @return AdvertismentCategory
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
     * Set type
     *
     * @param \NaidusvoeBundle\Entity\AdvertismentType $type
     * @return AdvertismentCategory
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
     * Add subCategories
     *
     * @param \NaidusvoeBundle\Entity\AdvertismentSubCategory $subCategories
     * @return AdvertismentCategory
     */
    public function addSubCategory(\NaidusvoeBundle\Entity\AdvertismentSubCategory $subCategories)
    {
        $this->subCategories[] = $subCategories;

        return $this;
    }

    /**
     * Remove subCategories
     *
     * @param \NaidusvoeBundle\Entity\AdvertismentSubCategory $subCategories
     */
    public function removeSubCategory(\NaidusvoeBundle\Entity\AdvertismentSubCategory $subCategories)
    {
        $this->subCategories->removeElement($subCategories);
    }

    /**
     * Get subCategories
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getSubCategories()
    {
        return $this->subCategories;
    }
}
