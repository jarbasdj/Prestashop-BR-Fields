<?php

$sql = [];

// ENDEREÇO ---------------------------------------
$sql[] = 'ALTER TABLE '._DB_PREFIX_.'address
            DROP COLUMN address_number,
            DROP COLUMN address_neighborhood';

foreach ($sql as $query) {
    if (Db::getInstance()->execute($query) == false) {
        return false;
    }
}
