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
     *
     * @ORM\Column(name="user_id", type="integer")
     */
    private $userId;

    /**
     * @var float
     *
     * @ORM\Column(name="amount", type="float")
     */
    private $amount;

    /**
     * @var integer
     *
     * @ORM\Column(name="adv_id", type="integer")
     */
    private $advId;

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
     * @var string
     *
     * @ORM\Column(name="pay_way", type="string", length=255)
     */
    private $payWay;

    /**
     * @var string
     *
     * @ORM\Column(name="currency", type="string", length=255)
     */
    private $currency;

    /**
     * @var boolean
     *
     * @ORM\Column(name="confirmed", type="boolean")
     */
    private $confirmed;


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
     * Set amount
     *
     * @param float $amount
     * @return Payment
     */
    public function setAmount($amount)
    {
        $this->amount = $amount;

        return $this;
    }

    /**
     * Get amount
     *
     * @return float 
     */
    public function getAmount()
    {
        return $this->amount;
    }

    /**
     * Set advId
     *
     * @param integer $advId
     * @return Payment
     */
    public function setAdvId($advId)
    {
        $this->advId = $advId;

        return $this;
    }

    /**
     * Get advId
     *
     * @return integer 
     */
    public function getAdvId()
    {
        return $this->advId;
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
     * Set payWay
     *
     * @param string $payWay
     * @return Payment
     */
    public function setPayWay($payWay)
    {
        $this->payWay = $payWay;

        return $this;
    }

    /**
     * Get payWay
     *
     * @return string 
     */
    public function getPayWay()
    {
        return $this->payWay;
    }

    /**
     * Set currency
     *
     * @param string $currency
     * @return Payment
     */
    public function setCurrency($currency)
    {
        $this->currency = $currency;

        return $this;
    }

    /**
     * Get currency
     *
     * @return string 
     */
    public function getCurrency()
    {
        return $this->currency;
    }

    /**
     * Set confirmed
     *
     * @param boolean $confirmed
     * @return Payment
     */
    public function setConfirmed($confirmed)
    {
        $this->confirmed = $confirmed;

        return $this;
    }

    /**
     * Get confirmed
     *
     * @return boolean 
     */
    public function getConfirmed()
    {
        return $this->confirmed;
    }
}
