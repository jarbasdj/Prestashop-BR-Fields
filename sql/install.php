<?php

$sql = [];

// ENDEREÇO ---------------------------------------
$sql[] = 'ALTER TABLE '._DB_PREFIX_.'address
            ADD COLUMN IF NOT EXISTS address_number VARCHAR(100),
            ADD COLUMN IF NOT EXISTS address_neighborhood VARCHAR(255)';

foreach($sql as $query) {
    if(Db::getInstance()->execute($query) == false) {
        return false;
    }
}