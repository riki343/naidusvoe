<?php

namespace NaidusvoeBundle\Entity;

use Doctrine\ORM\EntityManager;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\Filesystem\Filesystem;

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
     * @var string
     * @ORM\Column(name="image", type="string", nullable=true)
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
            'image' => $this->getImage(),
            'advID' => $this->getAdvertismentID(),
        );
    }

    /**
     * @param EntityManager $em
     * @param array $imagesArray
     * @param Advertisment $adv
     * @return array
     */
    public static function uploadImages(EntityManager $em, $imagesArray, $adv) {
        $basePath = 'uploads/' . $adv->getId();
        $uploadedImages = array();
        $adv = $em->getRepository('NaidusvoeBundle:Advertisment')->find($adv->getId());
        $fs = new Filesystem();

        $counter = 1;
        if ($imagesArray) {
            foreach ($imagesArray as $image) {
                $image = (object)$image;
                if ($image->image !== null) {
                    $imagePath = $basePath . '/' . $counter . '.jpg';
                    $image = explode(',', $image->image);
                    $image = base64_decode($image[1]);
                    $fs->dumpFile($imagePath, $image);

                    $attachment = new Attachment();
                    $attachment->setAdvertisment($adv);
                    $attachment->setImage($imagePath);
                    $em->persist($attachment);

                    $uploadedImages[] = $attachment;
                    $counter++;
                }
            }
        }

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
