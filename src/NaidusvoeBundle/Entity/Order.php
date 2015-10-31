<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * PaymentRequest
 *
 * @ORM\Table(name="orders")
 * @ORM\Entity
 */
class Order
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
     * @var string
     *
     * @ORM\Column(name="hash", type="string", length=1000)
     */
    private $hash;

    /**
     * @var integer
     *
     * @ORM\Column(name="amount", type="integer")
     */
    private $amount;

    /**
     * @var string
     *
     * @ORM\Column(name="pay_way", type="string", length=255)
     */
    private $payWay;

    /**
     * @var string
     *
     * @ORM\Column(name="status", type="string", length=255)
     */
    private $status;

    /**
     * @var integer
     * @ORM\Column(name="payment_id", type="integer", nullable=true)
     */
    private $paymentId;

    /**
     * @var Payment
     * @ORM\OneToOne(targetEntity="Payment", inversedBy="order")
     * @ORM\JoinColumn(name="payment_id", referencedColumnName="id")
     */
    private $payment;

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
     * @return PaymentRequest
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
     * Set hash
     *
     * @param string $hash
     * @return PaymentRequest
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
     * Set amount
     *
     * @param integer $amount
     * @return PaymentRequest
     */
    public function setAmount($amount)
    {
        $this->amount = $amount;

        return $this;
    }

    /**
     * Get amount
     *
     * @return integer 
     */
    public function getAmount()
    {
        return $this->amount;
    }

    /**
     * Set payWay
     *
     * @param string $payWay
     * @return PaymentRequest
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
     * Set status
     *
     * @param string $status
     * @return PaymentRequest
     */
    public function setStatus($status)
    {
        $this->status = $status;

        return $this;
    }

    /**
     * Get status
     *
     * @return string 
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * Set paymentId
     *
     * @param integer $paymentId
     * @return Order
     */
    public function setPaymentId($paymentId)
    {
        $this->paymentId = $paymentId;

        return $this;
    }

    /**
     * Get paymentId
     *
     * @return integer 
     */
    public function getPaymentId()
    {
        return $this->paymentId;
    }

    /**
     * Set payment
     *
     * @param \NaidusvoeBundle\Entity\Payment $payment
     * @return Order
     */
    public function setPayment(\NaidusvoeBundle\Entity\Payment $payment = null)
    {
        $this->payment = $payment;

        return $this;
    }

    /**
     * Get payment
     *
     * @return \NaidusvoeBundle\Entity\Payment 
     */
    public function getPayment()
    {
        return $this->payment;
    }
}
