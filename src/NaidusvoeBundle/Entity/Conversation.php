<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use NaidusvoeBundle\Entity\User;
use NaidusvoeBundle\Entity\Advertisment;
use Symfony\Component\Validator\Constraints\DateTime;

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
     * @ORM\ManyToOne(targetEntity="Advertisment", inversedBy="conversations")
     * @ORM\JoinColumn(name="advertisment_id", referencedColumnName="id")
     */
    private $advertisment;

    /**
     * @var \DateTime
     * @ORM\Column(name="last_updated", type="datetime")
     */
    private $lastUpdated;

    /**
     * @var ArrayCollection
     * @ORM\OneToMany(targetEntity="Message", mappedBy="conversation", cascade={"remove"})
     */
    private $messages;

    /**
     * @param $array
     * @return int
     */
    private function checkForNew($array) {
        $count = 0;
        /** @var Message $item */
        foreach ($array as $item) {
            if (!$item->getViewed()) $count++;
        }
        return $count;
    }


    /**
     * @param EntityManager $em
     * @param ArrayCollection $array
     * @return ArrayCollection
     */
    public static function setViewed(EntityManager $em, $array) {
        /** @var Message $item */
        foreach ($array as $item) {
            if (!$item->getViewed()) {
                $item->setViewed(true);
                $em->persist($item);
            }
        }
        $em->flush();
        return $array;
    }

    /**
     * @param User $user
     * @return array
     */
    public function getInArray($user) {
        return array(
            'id' => $this->getId(),
            'advertismentID' => $this->getAdvertismentID(),
            'advertismentTitle' => $this->getAdvertisment()->getTitle(),
            'advertismentUserID' => $this->getAdvertisment()->getUserID(),
            'myself' => ($this->getUser1()->getId() === $user->getId())
                ? $this->getUser1()->getInArray() : $this->getUser2()->getInArray(),
            'user1' => $this->getUser1()->getInArray(),
            'user2' => $this->getUser2()->getInArray(),
            'messages' => Functions::arrayToJson($this->getMessages()),
            'date' => $this->getLastUpdated()->format('d-m-Y'),
            'time' => $this->getLastUpdated()->format('H:i:s'),
        );
    }

    /**
     * @param User $user
     * @return array
     */
    public function getSingleInArray($user) {
        return array(
            'id' => $this->getId(),
            'advertismentID' => $this->getAdvertismentID(),
            'advertismentTitle' => $this->getAdvertisment()->getTitle(),
            'advertismentUserID' => $this->getAdvertisment()->getUserID(),
            'myself' => ($this->getUser1()->getId() === $user->getId())
                ? $this->getUser1()->getInArray() : $this->getUser2()->getInArray(),
            'user1' => $this->getUser1()->getInArray(),
            'user2' => $this->getUser2()->getInArray(),
            'new' => $this->checkForNew($this->getMessages()),
            'date' => $this->getLastUpdated()->format('d-m-Y'),
            'time' => $this->getLastUpdated()->format('H:i:s'),
        );
    }

    /**
     * @param ArrayCollection $messages
     */
    public function setMessages(ArrayCollection $messages) {
        $this->messages = $messages;
    }

    /**
     * Constructor
     */
    public function __construct() {
        $this->messages = new ArrayCollection();
        $this->lastUpdated = new \DateTime();
    }

    /**
     * @param EntityManager $em
     * @param int $user1_id
     * @param int $user2_id
     * @param int $adv_id
     * @return Conversation
     */
    public static function addConversation(EntityManager $em, $user1_id, $user2_id, $adv_id) {
        $user1 = $em->find('NaidusvoeBundle:User', $user1_id);
        $user2 = $em->find('NaidusvoeBundle:User', $user2_id);
        $adv = $em->find('NaidusvoeBundle:Advertisment', $adv_id);
        $conversation = new Conversation();
        $conversation->setUser1($user1);
        $conversation->setUser2($user2);
        $conversation->setAdvertisment($adv);
        $conversation->setLastUpdated(new \DateTime());
        $em->persist($conversation);
        $em->flush();
        return $conversation;
    }

    /**
     * @param EntityManager $em
     * @param int $user1_id
     * @param int $user2_id
     * @param int $adv_id
     * @return array
     */
    public static function getConversation(EntityManager $em, $user1_id, $user2_id, $adv_id) {
        $qb = $em->createQueryBuilder();
        $query = $qb->select('c');
        $query->from('NaidusvoeBundle:Conversation', 'c');
        $query->where('((c.user1ID = :user1_id AND c.user2ID = :user2_id)
            OR (c.user2ID = :user1_id AND c.user2ID = :user1_id))
            AND c.advertismentID = :adv_id');
        $query->setParameter('user1_id', $user1_id);
        $query->setParameter('user2_id', $user2_id);
        $query->setParameter('adv_id', $adv_id);
        $query = $query->getQuery();
        return $query->getResult();
    }

    /**
     * @param EntityManager $em
     * @param int $user_id
     * @return array
     */
    public static function getConversationsByUser(EntityManager $em, $user_id) {
        $qb = $em->createQueryBuilder();
        $query = $qb->select('c');
        $query->from('NaidusvoeBundle:Conversation', 'c');
        $query->where('c.user1ID = :user_id OR c.user2ID = :user_id');
        $query->setParameter('user_id', $user_id);
        $query->orderBy('c.lastUpdated', 'DESC');
        $query = $query->getQuery();
        return $query->getResult();
    }

    /**
     * @param EntityManager $em
     * @param $conv_id
     */
    public static function updateConversation(EntityManager $em, $conv_id) {
        $conv = $em->find('NaidusvoeBundle:Conversation', $conv_id);
        $conv->setLastUpdated(new \DateTime());
        $em->persist($conv);
        $em->flush();
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

    /**
     * Set lastUpdated
     *
     * @param \DateTime $lastUpdated
     * @return Conversation
     */
    public function setLastUpdated($lastUpdated)
    {
        $this->lastUpdated = $lastUpdated;

        return $this;
    }

    /**
     * Get lastUpdated
     *
     * @return \DateTime 
     */
    public function getLastUpdated()
    {
        return $this->lastUpdated;
    }
}
