<?php

namespace NaidusvoeBundle\Services;

use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Advertisment;
use NaidusvoeBundle\Entity\Attachment;

class AdvertisementService
{
    const TOP_ADV_COUNT = 5;
    /** @var EntityManager $em */
    private $em;

    public function __construct(EntityManager $em) {
        $this->em = $em;
    }

    public function getTopAdvs($typeId) {

        $qb = $this->em->createQueryBuilder();
        /** @var array $advs */
        $advs = $qb
            ->select('a')
            ->from('NaidusvoeBundle:Advertisment', 'a')
            ->where($qb->expr()->andX(
                $qb->expr()->isNotNull('a.onTopUntill'),
                $qb->expr()->eq('a.typeID', $typeId)
            ))
            ->getQuery()
            ->getResult()
        ;

        $type = $this->em->find('NaidusvoeBundle:AdvertismentType', $typeId);

        $advsCount = count($advs);
        $best = $this->getRandom($advs, AdvertisementService::TOP_ADV_COUNT);
        if ($advsCount < 5) {
            for ($i = 0; $i < 5 - $advsCount; $i++) {
                $newAdv = new Advertisment();
                $newAdv->setTitle('Ваша реклама');
                $attachment = new Attachment();
                $attachment->setImage('/resources/images/adv-default.png');
                $newAdv->addAttachment($attachment);
                $newAdv->setDescription('Тут може бути ваша реклама!');
                $newAdv->setDummy(true);
                $newAdv->setType($type);

                $best[] = $newAdv;
            }
        }

        return $best;
    }

    /**
     * @param array $array
     * @param integer $count
     * @return array
     */
    private function getRandom($array, $count) {
        $newBest = [];
        srand((new \DateTime())->getTimestamp());
        $count = (($arrayCount = count($array)) >= $count) ? $count : $arrayCount;
        shuffle($array);
        for ($i = 0; $i < $count; $i++) {
            $newBest[] = $array[$i];
        }

        return $newBest;
    }
}