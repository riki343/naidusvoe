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
     * @var string
     * @ORM\Column(name="message", type="string", length=3000)
     */
    private $message;

    /**
     * @return array
     */
    public function getInArray() {
        return array(
            'id' => $this->getId(),
            'user' => $this->getUser()->getInArray(),
            'conversationID' => $this->getConversationID(),
            'message' => $this->getMessage(),
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
}
