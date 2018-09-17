<?php

// Verifica se ea versão do Prestashop está definida.
if (!defined('_PS_VERSION_')) {
    exit;
}

class Brazilianfields extends Module
{
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
        if(Shop::isFeatureActive()){
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        require_once dirname(__FILE__) . '/sql/install.php';

        return parent::install();
    }

    /**
     * Desinstala o módulo
     *
     * @return void
     */
    public function uninstall()
    {
        require_once dirname(__FILE__) . '/sql/uninstall.php';

        return parent::uninstall();
    }
}