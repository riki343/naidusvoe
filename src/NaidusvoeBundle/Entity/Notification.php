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
     * @ORM\Column(name="initiator_id", type="integer")
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
     * @ORM\Column(name="conversation_id", type="integer")
     */
    private $conversationId;

    /**
     * @var integer
     *
     * @ORM\Column(name="message_id", type="integer")
     */
    private $messageId;

    /**
     * @param User $user
     * @param User $initiator
     */
    public function __construct(User $user = null, User $initiator = null) {
        if ($user !== null) {
            $this->userId = $user->getId();
        }
        if ($initiator !== null) {
            $this->initiatorId = $initiator->getId();
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
}
