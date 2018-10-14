<?php
/*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author Léo DESIGAUX <leodesigaux@gmail.com>
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*/

if (!defined('_PS_VERSION_')) {
    exit;
}


class Mobilemenu extends Module
{

    public function __construct()
    {
        $this->name = 'mobilemenu';
        $this->author = 'Léo DESIGAUX';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
    		$this->need_instance = 0;

        parent::__construct();

        $this->displayName = $this->trans('Mobile Menu', [], 'Modules.Mobilemenu.Admin');
        $this->description = $this->trans(
            'Add a customizable menu for mobile..',
            [],
            'Modules.Mobilemenu.Admin'
        );
        $this->ps_versions_compliancy = array('min' => '1.7.2.0', 'max' => _PS_VERSION_);
    }

    /**
     * @return bool
     */
    public function install()
    {
        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        return parent::install() &&
            $this->registerHook('displayFooterAfter') &&
            $this->registerHook('displayHeader') &&
            Configuration::updateValue('MOBILEMENU_VAR', 'test');
    }
    /**
     * @return string
     */
     public function getContent()
     {
         $output = null;

         if (Tools::isSubmit('submit'.$this->name)) {
             $myModuleName = strval(Tools::getValue('MOBILEMENU_VAR'));

             if (
                 !$myModuleName ||
                 empty($myModuleName) ||
                 !Validate::isGenericName($myModuleName)
             ) {
                 $output .= $this->displayError($this->l('Invalid Configuration value'));
             } else {
                 Configuration::updateValue('MOBILEMENU_VAR', $myModuleName);
                 $output .= $this->displayConfirmation($this->l('Settings updated'));
             }
         }

         return $output.$this->displayForm();
     }

    /**
     * @return string
     */
    protected function displayForm()
    {
      // Get default language
      $defaultLang = (int)Configuration::get('PS_LANG_DEFAULT');

      // Init Fields form array
      $fieldsForm[0]['form'] = [
          'legend' => [
              'title' => $this->l('Settings'),
          ],
          'input' => [
              [
                  'type' => 'text',
                  'label' => $this->l('Configuration value'),
                  'name' => 'MOBILEMENU_VAR',
                  'size' => 20,
                  'required' => true
              ]
          ],
          'submit' => [
              'title' => $this->l('Save'),
              'class' => 'btn btn-default pull-right'
          ]
      ];

      $helper = new HelperForm();

      // Module, token and currentIndex
      $helper->module = $this;
      $helper->name_controller = $this->name;
      $helper->token = Tools::getAdminTokenLite('AdminModules');
      $helper->currentIndex = AdminController::$currentIndex.'&configure='.$this->name;

      // Language
      $helper->default_form_language = $defaultLang;
      $helper->allow_employee_form_lang = $defaultLang;

      // Title and toolbar
      $helper->title = "de";
      $helper->show_toolbar = true;        // false -> remove toolbar
      $helper->toolbar_scroll = true;      // yes - > Toolbar is always visible on the top of the screen.
      $helper->submit_action = 'submit'.$this->name;
      $helper->toolbar_btn = [
          'save' => [
              'desc' => $this->l('Save'),
              'href' => AdminController::$currentIndex.'&configure='.$this->name.'&save'.$this->name.
              '&token='.Tools::getAdminTokenLite('AdminModules'),
          ],
          'back' => [
              'href' => AdminController::$currentIndex.'&token='.Tools::getAdminTokenLite('AdminModules'),
              'desc' => $this->l('Back to list')
          ]
      ];

      // Load current value
      $helper->fields_value['MOBILEMENU_VAR'] = Configuration::get('MOBILEMENU_VAR');

      return $helper->generateForm($fieldsForm);
    }
    public function hookDisplayFooterAfter($params)
    {
        $this->context->smarty->assign([
            'my_module_name' => Configuration::get('MOBILEMENU_VAR'),
            'my_module_link' => $this->context->link->getModuleLink('mobilemenu', 'display')
          ]);

          return $this->display(__FILE__, 'mobilemenu.tpl');
    }

    public function hookDisplayHeader()
    {
      $this->context->controller->addJS($this->_path.'views/js/mobilemenu.js', 'all');
      $this->context->controller->addCSS($this->_path.'views/css/mobilemenu.css', 'all');
    }
}
