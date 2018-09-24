<?php

// Verifica se ea versão do Prestashop está definida.
if (!defined('_PS_VERSION_')) {
    exit;
}

class Brazilianfields extends Module
{
    private $defaultAddressFormat = "firstname\nlastname\ncompany\nvat_number\naddress1\naddress2\npostcode city\nCountry:name\nphone";
    private $newAddressFormat = "firstname\nlastname\ncompany\nphone\npostcode\naddress1\naddress2\naddress_number\naddress_neighborhood\ncity\nState:iso_code\nCountry:name";

    /**
     * Construct
     *
     */
    public function __construct()
    {
        $this->name = 'brazilianfields';
        $this->tab = 'administration';
        $this->version = '0.0.1';
        $this->author = 'VH Labs [Jarbas]';
        $this->need_instance = 1;

        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Campos brasileiros');
        $this->description = $this->l('Habilita campos comuns ao brasil no cadastro dos clientes.');

        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);
    }

    /**
     * Instala o módulo
     *
     * @return void
     */
    public function install()
    {
        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        require_once dirname(__FILE__) . '/sql/install.php';

        if (!parent::install() or
            !$this->registerHook('displayOverrideTemplate') or
            !$this->registerHook('header') or
            !$this->modifyAddressFormat()) {
            return false;
        }

        return true;
    }

    public function hookHeader()
    {
        $this->context->controller->addJS($this->_path . 'views/js/jquery.mask.min.js');
        $this->context->controller->addJS($this->_path . 'views/js/brazilianfields.js');
    }

    /**
     * Desinstala o módulo
     *
     * @return void
     */
    public function uninstall()
    {
        require_once dirname(__FILE__) . '/sql/uninstall.php';

        if (!parent::uninstall() or
            !$this->modifyAddressFormat(true)
        ){
            return false;
        }

        return true;
    }

    public function hookDisplayOverrideTemplate($params)
    {
        if (isset($params['controller']->php_self) and $params['controller']->php_self === 'address') {
            $this->context->smarty->assign([
                'uri' => __PS_BASE_URI__ . "/modules/{$this->name}/"
            ]);

            return $this->getTemplatePath('hookeOverrideAddressTemplate.tpl');
        }
    }

    public function modifyAddressFormat($reset = false)
    {
        $country = Db::getInstance()->getRow('SELECT id_country FROM `'._DB_PREFIX_.'country` WHERE `iso_code` = "br" OR `iso_code` = "BR"');

        if (isset($country['id_country']) and $country['id_country'] >= 1) {
            $id_country = $country['id_country'];

            $format = ['format' => $reset ? $this->defaultAddressFormat : $this->newAddressFormat];
        
            Db::getInstance()->update('address_format', $format, '`id_country` = ' . $id_country);
        }

        return true;
    }
}
