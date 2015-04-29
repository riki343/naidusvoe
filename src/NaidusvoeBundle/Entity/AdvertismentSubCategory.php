<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * AdvertismentSubCategory
 *
 * @ORM\Table(name="advertisment_subcategories")
 * @ORM\Entity
 */
class AdvertismentSubCategory
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
     * @ORM\Column(name="category_id", type="integer")
     */
    private $categoryID;

    /**
     * @var AdvertismentCategory
     * @ORM\ManyToOne(targetEntity="AdvertismentCategory", inversedBy="subCategories")
     * @ORM\JoinColumn(name="category_id", referencedColumnName="id")
     */
    private $category;

    /**
     * @var string
     * @ORM\Column(name="title", type="string", length=255)
     */
    private $name;

    /**
     * @var string
     * @ORM\Column(name="title_ru", type="string", length=255)
     */
    private $nameRU;

    public function getInArray() {
        return array(
            'id' => $this->getId(),
            'categoryID' => $this->getCategoryID(),
            'name' => $this->getName(),
        );
    }

    public function getInArrayRU() {
        return array(
            'id' => $this->getId(),
            'categoryID' => $this->getCategoryID(),
            'name' => $this->getNameRU(),
        );
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
     * Set name
     *
     * @param string $name
     * @return AdvertismentSubCategory
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
     * Set categoryID
     *
     * @param integer $categoryID
     * @return AdvertismentSubCategory
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
     * Set category
     *
     * @param \NaidusvoeBundle\Entity\AdvertismentCategory $category
     * @return AdvertismentSubCategory
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
     * Set nameRU
     *
     * @param string $nameRU
     * @return AdvertismentSubCategory
     */
    public function setNameRU($nameRU)
    {
        $this->nameRU = $nameRU;

        return $this;
    }

    /**
     * Get nameRU
     *
     * @return string 
     */
    public function getNameRU()
    {
        return $this->nameRU;
    }
}
