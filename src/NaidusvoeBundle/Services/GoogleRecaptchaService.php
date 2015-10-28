<?php

namespace NaidusvoeBundle\Services;

class GoogleRecaptchaService
{
    public function verify($secret, $response) {
        $response = json_decode(file_get_contents("https://www.google.com/recaptcha/api/siteverify?secret=$secret&response=$response"), true);

        return $response;
    }
}