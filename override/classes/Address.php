<?php

class Address extends AddressCore {
    public $address_number;

    public $addaddress_neighborhood;

    public function __construct($id_address = null, $id_lang = null)
    {
        self::$definition['fields'][]['address_number'] = ['type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'size' => 100];
        self::$definition['fields'][]['address_neighborhood'] = ['type' => self::TYPE_STRING, 'validate' => 'isGenericName', 'size' => 100];

        parent::__construct($id_address);
    }

    public function getFields()
    {
        $field = parent::getFields();
        $field['address_number'] = pSQL($this->address_number);
        $field['addaddress_neighborhood'] = pSQL($this->addaddress_neighborhood);

        return $field;
    }
}