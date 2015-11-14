<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Payment
 *
 * @ORM\Table(name="payments")
 * @ORM\Entity
 */
class Payment
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
     * @ORM\Column(name="user_id", type="integer")
     */
    private $userId;

    /**
     * @var User
     * @ORM\ManyToOne(targetEntity="User", inversedBy="payments")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     */
    private $user;

    /**
     * @var integer
     * @ORM\Column(name="advertisement_id", type="integer")
     */
    private $advertisementId;

    /**
     * @var Advertisment
     * @ORM\ManyToOne(targetEntity="Advertisment", inversedBy="payments")
     * @ORM\JoinColumn(name="advertisement_id", referencedColumnName="id")
     */
    private $advertisement;

    /**
     * @var integer
     * @ORM\Column(name="order_id", type="integer")
     */
    private $orderId;

    /**
     * @var Order
     * @ORM\OneToOne(targetEntity="Order", mappedBy="payment")
     * @ORM\JoinColumn(name="order_id", referencedColumnName="id")
     */
    private $order;

    /**
     * @var string
     * @ORM\Column(name="hash", type="string", length=1000)
     */
    private $hash;

    /**
     * @var array
     * @ORM\Column(name="details", type="array")
     */
    private $details;

    /**
     * @param Order $order
     * @param array $details
     */
    public function __construct($order, $details) {
        $this->order         = $order;
        $this->user          = $order->getUser();
        $this->advertisement = $order->getAdvertisement();
        $this->details       = $details;
        $this->hash          = $order->getHash();
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
     * @return Payment
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
     * Set advertisementId
     *
     * @param integer $advertisementId
     * @return Payment
     */
    public function setAdvertisementId($advertisementId)
    {
        $this->advertisementId = $advertisementId;

        return $this;
    }

    /**
     * Get advertisementId
     *
     * @return integer 
     */
    public function getAdvertisementId()
    {
        return $this->advertisementId;
    }

    /**
     * Set orderId
     *
     * @param integer $orderId
     * @return Payment
     */
    public function setOrderId($orderId)
    {
        $this->orderId = $orderId;

        return $this;
    }

    /**
     * Get orderId
     *
     * @return integer 
     */
    public function getOrderId()
    {
        return $this->orderId;
    }

    /**
     * Set hash
     *
     * @param string $hash
     * @return Payment
     */
    public function setHash($hash)
    {
        $this->hash = $hash;

        return $this;
    }

    /**
     * Get hash
     *
     * @return string 
     */
    public function getHash()
    {
        return $this->hash;
    }

    /**
     * Set details
     *
     * @param array $details
     * @return Payment
     */
    public function setDetails($details)
    {
        $this->details = $details;

        return $this;
    }

    /**
     * Get details
     *
     * @return array 
     */
    public function getDetails()
    {
        return $this->details;
    }

    /**
     * Set user
     *
     * @param \NaidusvoeBundle\Entity\User $user
     * @return Payment
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
     * Set advertisement
     *
     * @param \NaidusvoeBundle\Entity\Advertisment $advertisement
     * @return Payment
     */
    public function setAdvertisement(\NaidusvoeBundle\Entity\Advertisment $advertisement = null)
    {
        $this->advertisement = $advertisement;

        return $this;
    }

    /**
     * Get advertisement
     *
     * @return \NaidusvoeBundle\Entity\Advertisment 
     */
    public function getAdvertisement()
    {
        return $this->advertisement;
    }

    /**
     * Set order
     *
     * @param \NaidusvoeBundle\Entity\Order $order
     * @return Payment
     */
    public function setOrder(\NaidusvoeBundle\Entity\Order $order = null)
    {
        $this->order = $order;

        return $this;
    }

    /**
     * Get order
     *
     * @return \NaidusvoeBundle\Entity\Order 
     */
    public function getOrder()
    {
        return $this->order;
    }
}
