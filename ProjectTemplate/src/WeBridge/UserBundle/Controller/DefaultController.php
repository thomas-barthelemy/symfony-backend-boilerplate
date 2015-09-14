<?php

namespace WeBridge\UserBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;

class DefaultController extends Controller
{
    /**
     * @Route("/login")
     * @Template("WeBridgeUserBundle::login.html.twig")
     */
    public function loginAction()
    {
        return [];
    }
}
