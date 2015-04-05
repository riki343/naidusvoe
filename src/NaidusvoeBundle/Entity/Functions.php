<?php

namespace NaidusvoeBundle\Entity;

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
}