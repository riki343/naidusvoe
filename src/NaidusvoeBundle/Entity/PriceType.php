<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * PriceType
 *
 * @ORM\Table(name="price_types")
 * @ORM\Entity
 */
class PriceType
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
    private $name;

    public function getInArray() {
        return array(
            'id' => $this->getId(),
            'name' => $this->getName(),
        );
    }

    /**
     * @param EntityManager $em
     * @return PriceType
     */
    public static function getUAHType(EntityManager $em) {
        return $em->getRepository('NaidusvoeBundle:PriceType')->find(1);
    }

    /**
     * @param EntityManager $em
     * @return PriceType
     */
    public static function getUSDType(EntityManager $em) {
        return $em->getRepository('NaidusvoeBundle:PriceType')->find(2);
    }

    /**
     * @param EntityManager $em
     * @return PriceType
     */
    public static function getEURType(EntityManager $em) {
        return $em->getRepository('NaidusvoeBundle:PriceType')->find(3);
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
     * @return PriceType
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
}
