<?php
/**
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author Léo DESIGAUX <leodesigaux@gmail.com>
*  @copyright  Léo DESIGAUX
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
**/

class MobilefloatingcartAjaxModuleFrontController extends ModuleFrontController
{
    public function initContent()
    {
        $this->ajax = true;
        parent::initContent();
    }

    public function displayAjax()
    {
        $this->context->smarty->assign(array(
            'MFC_COLOR' => Configuration::get('MFC_COLOR')
        ));
        die(Tools::jsonEncode(array(
            'mfc-content' => $this->context->smarty->fetch(
                _PS_MODULE_DIR_.'mobilefloatingcart/views/templates/hook/mobilefloatingcart-content.tpl'
            )
        )));
    }
}
