<?php

class AddressController extends AddressControllerCore
{
    public function setTemplate($template, $params = array(), $locale = null)
    {
        parent::setTemplate('modules/brazilianfields/views/front/address.tpl');
    }
}