<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use NaidusvoeBundle\Entity\Conversation;
use NaidusvoeBundle\Entity\User;

/**
 * Message
 *
 * @ORM\Table(name="messages")
 * @ORM\Entity
 */
class Message
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
     * @ORM\Column(name="conversation_id", type="integer")
     */
    private $conversationID;

    /**
     * @var Conversation
     * @ORM\ManyToOne(targetEntity="Conversation", inversedBy="messages")
     * @ORM\JoinColumn(name="conversation_id", referencedColumnName="id")
     */
    private $conversation;

    /**
     * @var boolean
     * @ORM\Column(name="viewed", type="boolean", options={"default" = false})
     */
    private $viewed;

    /**
     * @var \DateTime
     * @ORM\Column(name="posted", type="datetime")
     */
    private $posted;

    /**
     * @var string
     * @ORM\Column(name="message", type="string", length=3000)
     */
    private $message;

    /**
     * Constructor
     */
    public function __construct() {
        $this->viewed = false;
        $this->posted = new \DateTime();
    }

    /**
     * @param EntityManager $em
     * @param int $conversation_id
     * @param int $user_id
     * @param string $message
     * @return Message
     */
    public static function addNewMessage(EntityManager $em, $conversation_id, $user_id, $message) {
        $conversation = $em->find('NaidusvoeBundle:Conversation', $conversation_id);
        $user = $em->find('NaidusvoeBundle:User', $user_id);
        $newMessage = new Message();
        $newMessage->setUser($user);
        $newMessage->setConversation($conversation);
        $newMessage->setMessage($message);
        $em->persist($newMessage);
        $em->flush();
        return $newMessage;
    }

    /**
     * @return array
     */
    public function getInArray() {
        return array(
            'id' => $this->getId(),
            'user' => $this->getUser()->getInArray(),
            'conversationID' => $this->getConversationID(),
            'message' => $this->getMessage(),
            'viewed' => $this->getViewed(),
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
     * Set userID
     *
     * @param integer $userID
     * @return Message
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
     * Set conversationID
     *
     * @param integer $conversationID
     * @return Message
     */
    public function setConversationID($conversationID)
    {
        $this->conversationID = $conversationID;

        return $this;
    }

    /**
     * Get conversationID
     *
     * @return integer 
     */
    public function getConversationID()
    {
        return $this->conversationID;
    }

    /**
     * Set message
     *
     * @param string $message
     * @return Message
     */
    public function setMessage($message)
    {
        $this->message = $message;

        return $this;
    }

    /**
     * Get message
     *
     * @return string 
     */
    public function getMessage()
    {
        return $this->message;
    }

    /**
     * Set user
     *
     * @param \NaidusvoeBundle\Entity\User $user
     * @return Message
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
     * Set conversation
     *
     * @param \NaidusvoeBundle\Entity\Conversation $conversation
     * @return Message
     */
    public function setConversation(\NaidusvoeBundle\Entity\Conversation $conversation = null)
    {
        $this->conversation = $conversation;

        return $this;
    }

    /**
     * Get conversation
     *
     * @return \NaidusvoeBundle\Entity\Conversation 
     */
    public function getConversation()
    {
        return $this->conversation;
    }

    /**
     * Set viewed
     *
     * @param boolean $viewed
     * @return Message
     */
    public function setViewed($viewed)
    {
        $this->viewed = $viewed;

        return $this;
    }

    /**
     * Get viewed
     *
     * @return boolean 
     */
    public function getViewed()
    {
        return $this->viewed;
    }

    /**
     * Set posted
     *
     * @param \DateTime $posted
     * @return Message
     */
    public function setPosted($posted)
    {
        $this->posted = $posted;

        return $this;
    }

    /**
     * Get posted
     *
     * @return \DateTime 
     */
    public function getPosted()
    {
        return $this->posted;
    }
}
