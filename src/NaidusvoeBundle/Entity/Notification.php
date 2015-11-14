<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\Mapping as ORM;


/**
 * Notification
 *
 * @ORM\Table(name="notifications")
 * @ORM\Entity
 */
class Notification
{
    const CONVERSATION_NOTIFICATION = "CONVERSATION_NOTIFICATION";
    const SIMPLE_NOTIFICATION = "SIMPLE_NOTIFICATION";

    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var integer
     *
     * @ORM\Column(name="initiator_id", type="integer", nullable=true)
     */
    private $initiatorId;

    /**
     * @var integer
     *
     * @ORM\Column(name="user_id", type="integer")
     */
    private $userId;

    /**
     * @var integer
     *
     * @ORM\Column(name="conversation_id", type="integer", nullable=true)
     */
    private $conversationId;

    /**
     * @var integer
     *
     * @ORM\Column(name="message_id", type="integer", nullable=true)
     */
    private $messageId;

    /**
     * @var string
     *
     * @ORM\Column(name="content", type="string")
     */
    private $content;

    /**
     * @var string
     *
     * @ORM\Column(name="type", type="string")
     */
    private $type;

    /**
     * @param User $user
     * @param User $initiator
     */
    public function __construct($type, User $user = null, User $initiator = null) {
        $this->type = $type;
        if ($user !== null) {
            $this->userId = $user->getId();
        }
        if ($initiator !== null) {
            $this->initiatorId = $initiator->getId();
        }
    }

    public function getInArray()
    {
        return [
            'id' => $this->getId(),
            'initiatorId' => $this->getInitiatorId(),
            'userId' => $this->getUserId(),
            'conversationId' => $this->getConversationId(),
            'messageId' => $this->getMessageId(),
            'content' => $this->getContent(),
            'type' => $this->getType()
        ];
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
     * Set initiatorId
     *
     * @param integer $initiatorId
     * @return Notification
     */
    public function setInitiatorId($initiatorId)
    {
        $this->initiatorId = $initiatorId;

        return $this;
    }

    /**
     * Get initiatorId
     *
     * @return integer 
     */
    public function getInitiatorId()
    {
        return $this->initiatorId;
    }

    /**
     * Set userId
     *
     * @param integer $userId
     * @return Notification
     */
    public function setUserId($userId)
    {
        $this->userId = $userId;

        return $this;
    }

    /**
     * Get userId
     *
     * @return integer 
     */
    public function getUserId()
    {
        return $this->userId;
    }

    /**
     * Set conversationId
     *
     * @param integer $conversationId
     * @return Notification
     */
    public function setConversationId($conversationId)
    {
        $this->conversationId = $conversationId;

        return $this;
    }

    /**
     * Get conversationId
     *
     * @return integer 
     */
    public function getConversationId()
    {
        return $this->conversationId;
    }

    /**
     * Set messageId
     *
     * @param integer $messageId
     * @return Notification
     */
    public function setMessageId($messageId)
    {
        $this->messageId = $messageId;

        return $this;
    }

    /**
     * Get messageId
     *
     * @return integer 
     */
    public function getMessageId()
    {
        return $this->messageId;
    }

    /**
     * Set content
     *
     * @param string $content
     * @return Notification
     */
    public function setContent($content)
    {
        $this->content = $content;

        return $this;
    }

    /**
     * Get content
     *
     * @return string 
     */
    public function getContent()
    {
        return $this->content;
    }

    /**
     * Set type
     *
     * @param string $type
     * @return Notification
     */
    public function setType($type)
    {
        $this->type = $type;

        return $this;
    }

    /**
     * Get type
     *
     * @return string 
     */
    public function getType()
    {
        return $this->type;
    }
}
