<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * UserVote
 *
 * @ORM\Table(name="user_votes")
 * @ORM\Entity
 */
class UserVote
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
     * @ORM\Column(name="user_id", type="integer")
     */
    private $userId;

    /**
     * @var User
     * @ORM\ManyToOne(targetEntity="User", inversedBy="votes")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     */
    private $user;

    /**
     * @var integer
     *
     * @ORM\Column(name="voter_id", type="integer")
     */
    private $voterId;

    /**
     * @var User
     * @ORM\ManyToOne(targetEntity="User", inversedBy="givenVotes")
     * @ORM\JoinColumn(name="voter_id", referencedColumnName="id")
     */
    private $voter;

    /**
     * @var integer
     *
     * @ORM\Column(name="vote_power", type="float")
     */
    private $votePower;

    public function getInArray() {
        return [
            'id' => $this->id,
            'userID' => $this->getUserId(),
            'votePower' => $this->getVotePower(),
            'voterID' => $this->getVoterId(),
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
     * Set userId
     *
     * @param integer $userId
     * @return UserVote
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
     * Set votePower
     *
     * @param integer $votePower
     * @return UserVote
     */
    public function setVotePower($votePower)
    {
        $this->votePower = $votePower;

        return $this;
    }

    /**
     * Get votePower
     *
     * @return integer 
     */
    public function getVotePower()
    {
        return $this->votePower;
    }

    /**
     * Set user
     *
     * @param \NaidusvoeBundle\Entity\User $user
     * @return UserVote
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
     * Set voterId
     *
     * @param integer $voterId
     * @return UserVote
     */
    public function setVoterId($voterId)
    {
        $this->voterId = $voterId;

        return $this;
    }

    /**
     * Get voterId
     *
     * @return integer 
     */
    public function getVoterId()
    {
        return $this->voterId;
    }

    /**
     * Set voter
     *
     * @param \NaidusvoeBundle\Entity\User $voter
     * @return UserVote
     */
    public function setVoter(\NaidusvoeBundle\Entity\User $voter = null)
    {
        $this->voter = $voter;

        return $this;
    }

    /**
     * Get voter
     *
     * @return \NaidusvoeBundle\Entity\User 
     */
    public function getVoter()
    {
        return $this->voter;
    }
}
