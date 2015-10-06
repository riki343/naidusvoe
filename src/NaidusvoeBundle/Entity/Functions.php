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
     * @param User|null $user
     * @return array
     */
    public static function arrayToJson($array, $user = null) {
        $jsonArray = array();
        if ($user === null) {
            foreach ($array as $item) {
                $jsonArray[] = $item->getInArray();
            }
        } else {
            foreach ($array as $item) {
                $jsonArray[] = $item->getInArray($user);
            }
        }
        return $jsonArray;
    }

    /**
     * @param $array
     * @return array
     */
    public static function arrayToJsonRU($array) {
        $jsonArray = array();
        foreach ($array as $item) {
            $jsonArray[] = $item->getInArrayRU();
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
     * @param $array
     * @return array
     */
    public static function arrayToJsonWithoutParentRU($array) {
        $jsonArray = array();
        foreach ($array as $item) {
            $jsonArray[] = $item->getInArrayWithoutParentRU();
        }
        return $jsonArray;
    }

    /**
     * @param $array
     * @param User|null $user
     * @return array
     */
    public static function arrayToJsonSingle($array, $user = null) {
        $jsonArray = array();
        if ($user === null) {
            foreach ($array as $item) {
                $jsonArray[] = $item->getSingleInArray();
            }
        } else {
            foreach ($array as $item) {
                $jsonArray[] = $item->getSingleInArray($user);
            }
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