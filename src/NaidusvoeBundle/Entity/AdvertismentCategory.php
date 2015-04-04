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
     * @var string
     * @ORM\Column(name="title", type="string", length=255)
     */
    private $name;

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
}
