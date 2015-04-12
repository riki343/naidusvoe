<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use NaidusvoeBundle\Entity\User;
use NaidusvoeBundle\Entity\Advertisment;

/**
 * Conversation
 *
 * @ORM\Table(name="conversations")
 * @ORM\Entity
 */
class Conversation
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
     * @ORM\Column(name="user1_id", type="integer")
     */
    private $user1ID;

    /**
     * @var User
     * @ORM\ManyToOne(targetEntity="User")
     * @ORM\JoinColumn(name="user1_id", referencedColumnName="id")
     */
    private $user1;

    /**
     * @var int
     * @ORM\Column(name="user2_id", type="integer")
     */
    private $user2ID;

    /**
     * @var User
     * @ORM\ManyToOne(targetEntity="User")
     * @ORM\JoinColumn(name="user2_id", referencedColumnName="id")
     */
    private $user2;

    /**
     * @var int
     * @ORM\Column(name="advertisment_id", type="integer")
     */
    private $advertismentID;

    /**
     * @var Advertisment
     * @ORM\ManyToOne(targetEntity="Advertisment")
     * @ORM\JoinColumn(name="advertisment_id", referencedColumnName="id")
     */
    private $advertisment;

    /**
     * @var ArrayCollection
     * @ORM\OneToMany(targetEntity="Message", mappedBy="conversation")
     */
    private $messages;

    /**
     * @return array
     */
    public function getInArray() {
        return array(
            'id' => $this->getId(),
            'advertismentID' => $this->getAdvertismentID(),
            'user1' => $this->getUser1()->getInArray(),
            'user2' => $this->getUser2()->getInArray(),
            'messages' => Functions::arrayToJson($this->getMessages()),
        );
    }

    /**
     * Constructor
     */
    public function __construct() {
        $this->messages = new ArrayCollection();
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
     * Set user1ID
     *
     * @param integer $user1ID
     * @return Conversation
     */
    public function setUser1ID($user1ID)
    {
        $this->user1ID = $user1ID;

        return $this;
    }

    /**
     * Get user1ID
     *
     * @return integer 
     */
    public function getUser1ID()
    {
        return $this->user1ID;
    }

    /**
     * Set user2ID
     *
     * @param integer $user2ID
     * @return Conversation
     */
    public function setUser2ID($user2ID)
    {
        $this->user2ID = $user2ID;

        return $this;
    }

    /**
     * Get user2ID
     *
     * @return integer 
     */
    public function getUser2ID()
    {
        return $this->user2ID;
    }

    /**
     * Set advertismentID
     *
     * @param integer $advertismentID
     * @return Conversation
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
     * Set user1
     *
     * @param \NaidusvoeBundle\Entity\User $user1
     * @return Conversation
     */
    public function setUser1(\NaidusvoeBundle\Entity\User $user1 = null)
    {
        $this->user1 = $user1;

        return $this;
    }

    /**
     * Get user1
     *
     * @return \NaidusvoeBundle\Entity\User 
     */
    public function getUser1()
    {
        return $this->user1;
    }

    /**
     * Set user2
     *
     * @param \NaidusvoeBundle\Entity\User $user2
     * @return Conversation
     */
    public function setUser2(\NaidusvoeBundle\Entity\User $user2 = null)
    {
        $this->user2 = $user2;

        return $this;
    }

    /**
     * Get user2
     *
     * @return \NaidusvoeBundle\Entity\User 
     */
    public function getUser2()
    {
        return $this->user2;
    }

    /**
     * Set advertisment
     *
     * @param \NaidusvoeBundle\Entity\Advertisment $advertisment
     * @return Conversation
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

    /**
     * Add messages
     *
     * @param \NaidusvoeBundle\Entity\Message $messages
     * @return Conversation
     */
    public function addMessage(\NaidusvoeBundle\Entity\Message $messages)
    {
        $this->messages[] = $messages;

        return $this;
    }

    /**
     * Remove messages
     *
     * @param \NaidusvoeBundle\Entity\Message $messages
     */
    public function removeMessage(\NaidusvoeBundle\Entity\Message $messages)
    {
        $this->messages->removeElement($messages);
    }

    /**
     * Get messages
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getMessages()
    {
        return $this->messages;
    }
}
