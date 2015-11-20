<?php

namespace NaidusvoeBundle\Services;

use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Advertisment;
use NaidusvoeBundle\Entity\AdvertismentType;
use NaidusvoeBundle\Entity\Attachment;

class AdvertisementService
{
    const TOP_ADV_COUNT  = 5;
    const MAIN_ADV_COUNT = 5;

    /** @var EntityManager $em */
    private $em;

    public function __construct(EntityManager $em) {
        $this->em = $em;
    }

    // TODO: check for expiration
    public function getBestAdvs($typeId) {
        $qb = $this->em->createQueryBuilder();
        /** @var array $advs */
        $advs = $qb
            ->select('a')
            ->from('NaidusvoeBundle:Advertisment', 'a')
            ->where('a.onBlockUntill IS NOT NULL AND a.typeID = :param')
            ->setParameter('param', $typeId)
            ->getQuery()
            ->getResult()
        ;

        $type = $this->em->find('NaidusvoeBundle:AdvertismentType', $typeId);
        $advsCount = count($advs);
        $best = $this->getRandom($advs, AdvertisementService::TOP_ADV_COUNT);
        if ($advsCount < 5) {
            $best = array_merge(
                $best,
                $this->generateDummyAdvs(AdvertisementService::TOP_ADV_COUNT - $advsCount, $type)
            );
        }

        return $best;
    }

    // TODO: check for expiration
    public function getMainAdvs() {
        $advs = [
            'trade' => [],
            'find'  => [],
            'gift'  => [],
        ];

        $qb = $this->em->createQueryBuilder();
        $trade = $qb
            ->select('a')
            ->from('NaidusvoeBundle:Advertisment', 'a')
            ->where($qb->expr()->andX(
                $qb->expr()->isNotNull('a.onMainUntill'),
                $qb->expr()->eq('a.typeID', Advertisment::TRADE)
            ))
            ->getQuery()
            ->getResult()
        ;

        $type = $this->em->find('NaidusvoeBundle:AdvertismentType', Advertisment::TRADE);
        $advsCount = count($trade);
        $advs['trade'] = $this->getRandom($trade, AdvertisementService::MAIN_ADV_COUNT);
        if ($advsCount < 5) {
            $advs['trade'] = array_merge(
                $advs['trade'],
                $this->generateDummyAdvs(AdvertisementService::MAIN_ADV_COUNT - $advsCount, $type)
            );
        }

        $qb = $this->em->createQueryBuilder();
        $find = $qb
            ->select('a')
            ->from('NaidusvoeBundle:Advertisment', 'a')
            ->where($qb->expr()->andX(
                $qb->expr()->isNotNull('a.onMainUntill'),
                $qb->expr()->eq('a.typeID', Advertisment::FIND)
            ))
            ->getQuery()
            ->getResult()
        ;

        $type  = $this->em->find('NaidusvoeBundle:AdvertismentType', Advertisment::FIND);
        $advsCount = count($find);
        $advs['find'] = $this->getRandom($find, AdvertisementService::MAIN_ADV_COUNT);
        if ($advsCount < 5) {
            $advs['find'] = array_merge(
                $advs['find'],
                $this->generateDummyAdvs(AdvertisementService::MAIN_ADV_COUNT - $advsCount, $type)
            );
        }

        $qb = $this->em->createQueryBuilder();
        $gift = $qb
            ->select('a')
            ->from('NaidusvoeBundle:Advertisment', 'a')
            ->where($qb->expr()->andX(
                $qb->expr()->isNotNull('a.onMainUntill'),
                $qb->expr()->eq('a.typeID', Advertisment::GIFT)
            ))
            ->getQuery()
            ->getResult()
        ;

        $type  = $this->em->find('NaidusvoeBundle:AdvertismentType', Advertisment::GIFT);
        $advsCount = count($gift);
        $advs['gift'] = $this->getRandom($gift, AdvertisementService::MAIN_ADV_COUNT);
        if ($advsCount < 5) {
            $advs['gift'] = array_merge(
                $advs['gift'],
                $this->generateDummyAdvs(AdvertisementService::MAIN_ADV_COUNT - $advsCount, $type)
            );
        }

        return $advs;
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

    private function generateDummyAdvs($count, $type) {
        $advs = [];
        for ($i = 0; $i < $count; $i++) {
            $newAdv = new Advertisment();
            $newAdv->setTitle('Ваша реклама');
            $attachment = new Attachment();
            $attachment->setImage('/resources/images/adv-default.png');
            $newAdv->addAttachment($attachment);
            $newAdv->setDescription('Тут може бути ваша реклама!');
            $newAdv->setDummy(true);
            $newAdv->setType($type);

            $advs[] = $newAdv;
        }

        return $advs;
    }

    /**
     * @param array $advs
     * @return array
     */
    private function checkForExpiredOnTop ($advs) {
        $new = [];
        for ($i = 0; $i < count($advs); $i++) {
            /** @var Advertisment $local */
            $local = $advs[$i];
            if ($local->getOnTopUntill() !== null) {
                $new[] = $local;
            }
            $this->em->persist($local);
        }
        $this->em->flush();

        return $new;
    }

    /**
     * @param array $advs
     * @return array
     */
    private function checkForExpiredOnMain ($advs) {
        $new = [];
        for ($i = 0; $i < count($advs); $i++) {
            /** @var Advertisment $local */
            $local = $advs[$i];
            if ($local->getOnMainUntill() !== null) {
                $new[] = $local;
            }
            $this->em->persist($local);
        }
        $this->em->flush();

        return $new;
    }
}