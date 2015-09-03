<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use NaidusvoeBundle\Entity\User;
use NaidusvoeBundle\Entity\Advertisment;

/**
 * Favorites
 *
 * @ORM\Table(name="favorites")
 * @ORM\Entity
 */
class Favorites
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
     * @ORM\Column(name="user_id", type="integer")
     */
    private $userID;

    /**
     * @var User
     * @ORM\ManyToOne(targetEntity="User")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     */
    private $user;

    /**
     * @var int
     * @ORM\Column(name="advertisment_id", type="integer")
     */
    private $advertismentID;

    /**
     * @var int
     * @ORM\ManyToOne(targetEntity="Advertisment")
     * @ORM\JoinColumn(name="advertisment_id", referencedColumnName="id")
     */
    private $advertisment;

    /**
     * @return array
     */
    public function getInArray() {
        return array(
            'id' => $this->getId(),
            'userID' => $this->getUserID(),
            'advertisment' => $this->getAdvertisment()->getInArray(),
        );
    }

    /**
     * @param EntityManager $em
     * @param int $fav_id
     */
    public static function deleteFav(EntityManager $em, $fav_id) {
        $fav = $em->find('NaidusvoeBundle:Favorites', $fav_id);
        if ($fav) {
            $em->remove($fav);
            $em->flush();
        }
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
     * Set userID
     *
     * @param integer $userID
     * @return Favorites
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
     * Set advertismentID
     *
     * @param integer $advertismentID
     * @return Favorites
     */
    public function setAdvertismentID($advertismentID)
    {
        $this->advertismentID = $advertismentID;

        return $this;
    }

    /**
     * Get advertismentID
     *
     * @return integer 
     */
    public function getAdvertismentID()
    {
        return $this->advertismentID;
    }

    /**
     * Set user
     *
     * @param \NaidusvoeBundle\Entity\User $user
     * @return Favorites
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
     * Set advertisment
     *
     * @param \NaidusvoeBundle\Entity\Advertisment $advertisment
     * @return Favorites
     */
    public function setAdvertisment(\NaidusvoeBundle\Entity\Advertisment $advertisment = null)
    {
        $this->advertisment = $advertisment;

        return $this;
    }

    /**
     * Get advertisment
     *
     * @return \NaidusvoeBundle\Entity\Advertisment 
     */
    public function getAdvertisment()
    {
        return $this->advertisment;
    }
}
