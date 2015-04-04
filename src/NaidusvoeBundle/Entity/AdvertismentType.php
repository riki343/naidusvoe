<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * AdvertismentType
 *
 * @ORM\Table(name="advertisment_types")
 * @ORM\Entity
 */
class AdvertismentType
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

    /**
     * @param EntityManager $em
     * @return AdvertismentType
     */
    public static function getBuyType(EntityManager $em) {
        return $em->getRepository('NaidusvoeBundle:AdvertismentType')->find(1);
    }

    /**
     * @param EntityManager $em
     * @return AdvertismentType
     */
    public static function getFoundType(EntityManager $em) {
        return $em->getRepository('NaidusvoeBundle:AdvertismentType')->find(2);
    }

    /**
     * @param EntityManager $em
     * @return AdvertismentType
     */
    public static function getGiveType(EntityManager $em) {
        return $em->getRepository('NaidusvoeBundle:AdvertismentType')->find(3);
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
     * @return AdvertismentType
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
