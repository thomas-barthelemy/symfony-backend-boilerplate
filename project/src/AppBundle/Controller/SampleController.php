<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Template;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;

class SampleController extends Controller
{
    /**
     * @Route("/", name="homepage")
     * @Template("AppBundle:sample:homepage.html.twig")
     */
    public function indexAction()
    {
        return [];
    }

    /**
     * @Route("/sample/tables")
     * @Template
     */
    public function tablesAction()
    {
        return [
            'browserData' => $this->getFakeBrowserTableData()
        ];
    }

    /**
     * @Route("/sample/forms")
     * @Template
     */
    public function formsAction()
    {
        return [];
    }

    /**
     * @Route("/sample/panels")
     * @Template
     */
    public function panelsAction()
    {
        return [];
    }

    /**
     * @Route("/sample/buttons")
     * @Template
     */
    public function buttonsAction()
    {
        return [];
    }

    /**
     * @Route("/sample/notifications")
     * @Template
     */
    public function notificationsAction()
    {
        return [];
    }

    /**
     * @Route("/sample/typography")
     * @Template
     */
    public function typographyAction()
    {
        return [];
    }

    /**
     * @Route("/sample/icons")
     * @Template
     */
    public function iconsAction()
    {
        return [];
    }

    /**
     * @Route("/sample/grid")
     * @Template
     */
    public function gridAction()
    {
        return [];
    }


    private function getFakeBrowserTableData()
    {
        $data = [];

        for ($i = 1; $i <= 100; $i++) {
            $data[] = [
                'engine' => 'engine_'.$i,
                'browser' => 'browser_'.$i,
                'platform' => 'platform_'.$i,
                'engineVersion' => 'v'.$i,
                'grade' => $i
            ];
        }

        return $data;
    }
}
