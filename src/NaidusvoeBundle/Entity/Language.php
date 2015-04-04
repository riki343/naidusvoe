<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * Language
 *
 * @ORM\Table(name="languages")
 * @ORM\Entity
 */
class Language
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
     * @return Language
     */
    public static function getUaLanguage(EntityManager $em) {
        return $em->getRepository('NaidusvoeBundle:Language')->find(1);
    }

    /**
     * @param EntityManager $em
     * @return Language
     */
    public static function getRuLanguage(EntityManager $em) {
        return $em->getRepository('NaidusvoeBundle:Language')->find(2);
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
     * @return Language
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
