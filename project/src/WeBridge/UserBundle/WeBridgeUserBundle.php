<?php

namespace WeBridge\UserBundle;

use Symfony\Component\HttpKernel\Bundle\Bundle;

class WeBridgeUserBundle extends Bundle
{
    public function getParent()
    {
        return 'FOSUserBundle';
    }
}
