<?php

namespace NaidusvoeBundle\Services;

use Doctrine\ORM\EntityManager;
use NaidusvoeBundle\Entity\Advertisment;
use NaidusvoeBundle\Entity\Attachment;

class AdvertisementService
{
    /** @var EntityManager $em */
    private $em;

    public function __construct(EntityManager $em) {
        $this->em = $em;
    }

    public function getTopAdvs($typeId) {
        $qb = $this->em->createQueryBuilder();
        $best = $qb
            ->select('a')
            ->from('NaidusvoeBundle:Advertisment', 'a')
            ->where($qb->expr()->andX(
                $qb->expr()->eq('a.categoryTop', 1),
                $qb->expr()->eq('a.typeID', $typeId)
            ))
            ->getQuery()
            ->getResult()
        ;

        $type = $this->em->find('NaidusvoeBundle:AdvertismentType', $typeId);

        if ($count = count($best) > 5) {
            $best = $this->getRandom($best, 5);
        } else if ($count = count($best) < 5) {
            for ($i = 0; $i < 5 - $count; $i++) {
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

    private function getRandom($array, $count) {
        $newBest = [];
        $used    = [];
        srand((new \DateTime())->getTimestamp());
        for ($i = 0; $i < $count; $i++) {
            $index = -1;
            while(true) {
                $index = rand(0, $count - 1);
                if (!in_array($index, $used)) {
                    $used[] = $index;
                    break;
                }
            }
            $newBest[] = $array[$i];
        }

        return $newBest;
    }
}