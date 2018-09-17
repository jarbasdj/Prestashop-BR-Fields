<?php

$sql = [];

// ENDEREÇO ---------------------------------------
$sql[] = 'ALTER TABLE '._DB_PREFIX_.'address
            DROP COLUMN IF EXISTS address_number,
            DROP COLUMN IF EXISTS address_neighborhood';

foreach($sql as $query) {
    if(Db::getInstance()->execute($query) == false) {
        return false;
    }
}