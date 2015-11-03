<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
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
     * @var User
     * @ORM\ManyToOne(targetEntity="User", inversedBy="orders")
     * @ORM\JoinColumn(name="user_id", referencedColumnName="id")
     */
    private $user;

    /**
     * @var string
     *
     * @ORM\Column(name="hash", type="string", length=1000)
     */
    private $hash;

    /**
     * @var integer
     * @ORM\Column(name="advertisement_id", type="integer")
     */
    private $advertisementId;

    /**
     * @var Advertisment
     * @ORM\ManyToOne(targetEntity="Advertisment", inversedBy="orders")
     * @ORM\JoinColumn(name="advertisement_id", referencedColumnName="id")
     */
    private $advertisement;

    /**
     * @var float
     *
     * @ORM\Column(name="amount", type="float")
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
     * @var boolean
     * @ORM\Column(name="adv_on_main", type="boolean")
     */
    private $advOnMain;

    /**
     * @var integer
     * @ORM\Column(name="adv_on_main_period", type="integer", nullable=true)
     */
    private $advOnMainPeriod;

    /**
     * @var boolean
     * @ORM\Column(name="adv_on_top", type="boolean")
     */
    private $advOnTop;

    /**
     * @var integer
     * @ORM\Column(name="adv_on_top_period", type="integer", nullable=true)
     */
    private $advOnTopPeriod;

    /**
     * @var boolean
     * @ORM\Column(name="adv_filled", type="boolean")
     */
    private $advFilled;

    /**
     * @var integer
     * @ORM\Column(name="adv_filled_period", type="integer", nullable=true)
     */
    private $advFilledPeriod;

    /**
     * @var boolean
     * @ORM\Column(name="adv_urgent", type="boolean")
     */
    private $advUrgent;

    /**
     * @var integer
     * @ORM\Column(name="adv_urgent_period", type="integer", nullable=true)
     */
    private $advUrgentPeriod;

    /**
     * @var boolean
     * @ORM\Column(name="adv_update", type="boolean")
     */
    private $advUpdate;

    /**
     * @var boolean
     * @ORM\Column(name="adv_block", type="boolean")
     */
    private $advBlock;

    /**
     * @var integer
     * @ORM\Column(name="adv_block_period", type="integer", nullable=true)
     */
    private $advBlockPeriod;

    public function __construct($user = null, $adv = null) {
        $this->user = $user;
        $this->advertisement = $adv;
    }

    /**
     * @param object $form
     * @param Order $order
     * @return array
     */
    public static function CheckForm($form, $order) {
        $result = [
            'correct' => true,
            'order' => null
        ];

        $total = 0;
        
        if ($form->advOnMain['checked'] === true) {
            switch ($form->advOnMain['period']) {
                case '3':
                    $order->setAdvOnMainPeriod(3);
                    $total += 15;
                    break;
                case '7':
                    $order->setAdvOnMainPeriod(7);
                    $total += 30;
                    break;
                case '14':
                    $order->setAdvOnMainPeriod(14);
                    $total += 50;
                    break;
            }

            $order->setAdvOnMain(true);
        } else {
            $order->setAdvOnMain(false);
        }

        if ($form->advOnTop['checked'] === true) {
            switch ($form->advOnTop['period']) {
                case '3':
                    $order->setAdvOnTopPeriod(3);
                    $total += 15;
                    break;
                case '7':
                    $order->setAdvOnTopPeriod(7);
                    $total += 30;
                    break;
                case '14':
                    $order->setAdvOnTopPeriod(14);
                    $total += 50;
                    break;
            }

            $order->setAdvOnTop(true);
        } else {
            $order->setAdvOnTop(false);
        }

        if ($form->advFilled['checked'] === true) {
            switch ($form->advFilled['period']) {
                case '3':
                    $order->setAdvFilledPeriod(3);
                    $total += 15;
                    break;
                case '7':
                    $order->setAdvFilledPeriod(7);
                    $total += 30;
                    break;
                case '14':
                    $order->setAdvFilledPeriod(14);
                    $total += 50;
                    break;
            }

            $order->setAdvFilled(true);
        } else {
            $order->setAdvFilled(false);
        }

        if ($form->advUrgent['checked'] === true) {
            switch ($form->advUrgent['period']) {
                case '3':
                    $order->setAdvUrgentPeriod(3);
                    $total += 15;
                    break;
                case '7':
                    $order->setAdvUrgentPeriod(7);
                    $total += 30;
                    break;
                case '14':
                    $order->setAdvUrgentPeriod(14);
                    $total += 50;
                    break;
            }

            $order->setAdvUrgent(true);
        } else {
            $order->setAdvUrgent(false);
        }

        if ($form->advUpdate['checked'] === true) {
            $order->setAdvUpdate(true);
            $total += 15;
        } else {
            $order->setAdvUpdate(false);
        }

        if ($form->advBlock['checked'] === true) {
            switch ($form->advBlock['period']) {
                case '3':
                    $order->setAdvBlockPeriod(3);
                    $total += 15;
                    break;
                case '7':
                    $order->setAdvBlockPeriod(7);
                    $total += 30;
                    break;
                case '14':
                    $order->setAdvBlockPeriod(14);
                    $total += 50;
                    break;
            }

            $order->setAdvBlock(true);
        } else {
            $order->setAdvBlock(false);
        }

        $order->setAmount($total);
        $order->setPayWay($form->payWay);

        $result['correct'] = ($form->total === $total);
        $result['order']   = $order;

        return $result;
    }

    /**
     * @param EntityManager $em
     * @param integer $userId
     * @param integer $advId
     * @return string
     */
    public static function generateHash($em, $userId, $advId) {
        $hash = '';
        $exist = true;
        while ($exist === true) {
            srand((new \DateTime())->getTimestamp());
            $hash = sha1('order_id_' . rand(1000, 999999999) . 'user_id_' . $userId . 'adv_id' . $advId);
            $hash = substr($hash, 5, 31);
            $eOrder = $em->getRepository('NaidusvoeBundle:Order')->findOneBy(['hash' => $hash]);
            if ($eOrder === null) {
                $exist = false;
            }
        }

        return $hash;
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
     * @return Order
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
     * @return Order
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
     * Set advertisementId
     *
     * @param integer $advertisementId
     * @return Order
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
     * Set amount
     *
     * @param integer $amount
     * @return Order
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
     * @return Order
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
     * @return Order
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
     * Set advOnMain
     *
     * @param boolean $advOnMain
     * @return Order
     */
    public function setAdvOnMain($advOnMain)
    {
        $this->advOnMain = $advOnMain;

        return $this;
    }

    /**
     * Get advOnMain
     *
     * @return boolean 
     */
    public function getAdvOnMain()
    {
        return $this->advOnMain;
    }

    /**
     * Set advOnMainPeriod
     *
     * @param integer $advOnMainPeriod
     * @return Order
     */
    public function setAdvOnMainPeriod($advOnMainPeriod)
    {
        $this->advOnMainPeriod = $advOnMainPeriod;

        return $this;
    }

    /**
     * Get advOnMainPeriod
     *
     * @return integer 
     */
    public function getAdvOnMainPeriod()
    {
        return $this->advOnMainPeriod;
    }

    /**
     * Set advOnTop
     *
     * @param boolean $advOnTop
     * @return Order
     */
    public function setAdvOnTop($advOnTop)
    {
        $this->advOnTop = $advOnTop;

        return $this;
    }

    /**
     * Get advOnTop
     *
     * @return boolean 
     */
    public function getAdvOnTop()
    {
        return $this->advOnTop;
    }

    /**
     * Set advOnTopPeriod
     *
     * @param integer $advOnTopPeriod
     * @return Order
     */
    public function setAdvOnTopPeriod($advOnTopPeriod)
    {
        $this->advOnTopPeriod = $advOnTopPeriod;

        return $this;
    }

    /**
     * Get advOnTopPeriod
     *
     * @return integer 
     */
    public function getAdvOnTopPeriod()
    {
        return $this->advOnTopPeriod;
    }

    /**
     * Set advFilled
     *
     * @param boolean $advFilled
     * @return Order
     */
    public function setAdvFilled($advFilled)
    {
        $this->advFilled = $advFilled;

        return $this;
    }

    /**
     * Get advFilled
     *
     * @return boolean 
     */
    public function getAdvFilled()
    {
        return $this->advFilled;
    }

    /**
     * Set advFilledPeriod
     *
     * @param integer $advFilledPeriod
     * @return Order
     */
    public function setAdvFilledPeriod($advFilledPeriod)
    {
        $this->advFilledPeriod = $advFilledPeriod;

        return $this;
    }

    /**
     * Get advFilledPeriod
     *
     * @return integer 
     */
    public function getAdvFilledPeriod()
    {
        return $this->advFilledPeriod;
    }

    /**
     * Set advUrgent
     *
     * @param boolean $advUrgent
     * @return Order
     */
    public function setAdvUrgent($advUrgent)
    {
        $this->advUrgent = $advUrgent;

        return $this;
    }

    /**
     * Get advUrgent
     *
     * @return boolean 
     */
    public function getAdvUrgent()
    {
        return $this->advUrgent;
    }

    /**
     * Set advUrgentPeriod
     *
     * @param integer $advUrgentPeriod
     * @return Order
     */
    public function setAdvUrgentPeriod($advUrgentPeriod)
    {
        $this->advUrgentPeriod = $advUrgentPeriod;

        return $this;
    }

    /**
     * Get advUrgentPeriod
     *
     * @return integer 
     */
    public function getAdvUrgentPeriod()
    {
        return $this->advUrgentPeriod;
    }

    /**
     * Set advUpdate
     *
     * @param boolean $advUpdate
     * @return Order
     */
    public function setAdvUpdate($advUpdate)
    {
        $this->advUpdate = $advUpdate;

        return $this;
    }

    /**
     * Get advUpdate
     *
     * @return boolean 
     */
    public function getAdvUpdate()
    {
        return $this->advUpdate;
    }

    /**
     * Set advBlock
     *
     * @param boolean $advBlock
     * @return Order
     */
    public function setAdvBlock($advBlock)
    {
        $this->advBlock = $advBlock;

        return $this;
    }

    /**
     * Get advBlock
     *
     * @return boolean 
     */
    public function getAdvBlock()
    {
        return $this->advBlock;
    }

    /**
     * Set advBlockPeriod
     *
     * @param integer $advBlockPeriod
     * @return Order
     */
    public function setAdvBlockPeriod($advBlockPeriod)
    {
        $this->advBlockPeriod = $advBlockPeriod;

        return $this;
    }

    /**
     * Get advBlockPeriod
     *
     * @return integer 
     */
    public function getAdvBlockPeriod()
    {
        return $this->advBlockPeriod;
    }

    /**
     * Set user
     *
     * @param \NaidusvoeBundle\Entity\User $user
     * @return Order
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
     * @return Order
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
