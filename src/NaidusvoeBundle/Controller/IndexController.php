<?php

namespace NaidusvoeBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class IndexController extends Controller
{
    public function indexAction()
    {
        return $this->render('@Naidusvoe/layout.html.twig');
    }
}
