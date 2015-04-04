<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Component\Validator\Constraints\Image;

/**
 * Attachment
 *
 * @ORM\Table(name="attachments")
 * @ORM\Entity
 */
class Attachment
{
    /**
     * @var integer
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var resource
     * @ORM\Column(name="image", type="blob")
     */
    private $image;

    /**
     * @var int
     * @ORM\Column(name="advertisment_id", type="integer")
     */
    private $advertismentID;

    /**
     * @var Advertisment
     * @ORM\ManyToOne(targetEntity="Advertisment", inversedBy="attachments")
     * @ORM\JoinColumn(name="advertisment_id", referencedColumnName="id")
     */
    private $advertisment;

    public function getInArray() {
        return array(
            'id' => $this->getId(),
            'image' => stream_get_contents($this->getImage()),
            'advID' => $this->getAdvertismentID(),
        );
    }

    /**
     * @param EntityManager $em
     * @param array $imagesArray
     * @param int $advID
     * @return array
     */
    public static function uploadImages(EntityManager $em, $imagesArray, $advID) {
        $uploadedImages = array();
        foreach ($imagesArray as $image) {
            $attachment = new Attachment();
            $adv = $em->getRepository('NaidusvoeBundle:Advertisment')->find($advID);
            $attachment->setAdvertisment($adv);
            $attachment->setImage($image['img']);
            $em->persist($attachment);
            $uploadedImages[] = $attachment;
        }
        $em->flush();
        return $uploadedImages;
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
     * Set advertismentID
     *
     * @param integer $advertismentID
     * @return Attachment
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
     * Set advertisment
     *
     * @param \NaidusvoeBundle\Entity\Advertisment $advertisment
     * @return Attachment
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
     * Set image
     *
     * @param string $image
     * @return Attachment
     */
    public function setImage($image)
    {
        $this->image = $image;

        return $this;
    }

    /**
     * Get image
     *
     * @return string 
     */
    public function getImage()
    {
        return $this->image;
    }
}
