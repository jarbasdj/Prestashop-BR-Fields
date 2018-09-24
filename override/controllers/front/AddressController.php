<?php

class AddressController extends AddressControllerCore
{
    private $address_form;

    public function init()
    {
        parent::init();
        $this->address_form = $this->makeAddressForm();
    }

    public function initContent()
    {
        parent::initContent();

        $addressForm = $this->address_form;

        if (Tools::getIsset('id_address') && ($id_address = (int)Tools::getValue('id_address'))) {
            $addressForm->loadAddressById($id_address);
        }

        if (Tools::getIsset('id_country')) {
            $addressForm->fillWith(array('id_country' => Tools::getValue('id_country')));
        }

        $templateVariables = $addressForm->getTemplateVariables();

        $this->context->smarty->assign($templateVariables);
    }
}