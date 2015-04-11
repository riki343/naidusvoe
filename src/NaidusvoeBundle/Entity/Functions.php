<?php

namespace NaidusvoeBundle\Entity;
use Doctrine\ORM\EntityManager;

/**
 * Class Functions
 * @package NaidusvoeBundle\Entity
 */
class Functions {
    /**
     * @param $array
     * @return array
     */
    public static function arrayToJson($array) {
        $jsonArray = array();
        foreach ($array as $item) {
            $jsonArray[] = $item->getInArray();
        }
        return $jsonArray;
    }

    /**
     * @param $array
     * @return array
     */
    public static function arrayToJsonWithoutParent($array) {
        $jsonArray = array();
        foreach ($array as $item) {
            $jsonArray[] = $item->getInArrayWithoutParent();
        }
        return $jsonArray;
    }

    /**
     * @param EntityManager $em
     * @return EntityManager
     * @throws \Doctrine\ORM\ORMException
     */
    public static function getEntityManager(EntityManager $em) {
        if (!$em->isOpen()) {
            $em = $em->create(
                $em->getConnection(), $em->getConfiguration());
        }
        return $em;
    }
}