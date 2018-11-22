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

if (!defined('_PS_VERSION_')) {
    exit;
}


class Mobilefloatingcart extends Module
{
    public function __construct()
    {
        $this->name = 'mobilefloatingcart';
        $this->author = 'Léo DESIGAUX';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->need_instance = 0;

        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->trans('Mobile Floating Cart', array(), 'Modules.Mobilefloatingcart.Admin');
        $this->description = $this->trans(
            'Add a floating cart module for mobile.',
            array(),
            'Modules.Mobilefloatingcart.Admin'
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

        return parent::install()
            && $this->registerHook('displayFooterAfter')
            && $this->registerHook('displayHeader')
            && Configuration::updateValue('MFC_COLOR', '#454545')
            && Configuration::updateValue('MFC_ICONCOLOR', '#FEFEFE')
            && Configuration::updateValue('MFC_ICON', null)
            && Configuration::updateValue('MFC_HIDDENONCARTEMPTY', false)
            && Configuration::updateValue('MFC_SHOWONDESKTOP', true)
            && Configuration::updateValue('MFC_ZINDEX', 99999);
    }

    public function uninstall()
    {
        return Configuration::deleteByName('MFC_COLOR')
            && Configuration::deleteByName('MFC_ICONCOLOR')
            && Configuration::deleteByName('MFC_ICON')
            && Configuration::deleteByName('MFC_HIDDENONCARTEMPTY')
            && Configuration::deleteByName('MFC_SHOWONDESKTOP')
            && Configuration::deleteByName('MFC_ZINDEX')
            && parent::uninstall();
    }

    public function postProcess()
    {
        if (Tools::isSubmit('submit'.$this->name)) {
            $values = array();
            $update_images_values = false;

            if (isset($_FILES['MFC_ICON'])
                && isset($_FILES['MFC_ICON']['tmp_name'])
                && !empty($_FILES['MFC_ICON']['tmp_name'])) {
                if ($error = ImageManager::validateUpload($_FILES['MFC_ICON'], 4000000)) {
                    return $error;
                } else {
                    $ext = Tools::substr($_FILES['MFC_ICON']['name'], strrpos($_FILES['MFC_ICON']['name'], '.') + 1);
                    $file_name = md5($_FILES['MFC_ICON']['name']).'.'.$ext;
                    $file_dir = dirname(__FILE__) . DIRECTORY_SEPARATOR . 'img' . DIRECTORY_SEPARATOR;
                    if (!move_uploaded_file($_FILES['MFC_ICON']['tmp_name'], $file_dir . $file_name)) {
                        return $this->displayError(
                            $this->trans(
                                'An error occurred while attempting to upload the file.',
                                array(),
                                'Admin.Notifications.Error'
                            )
                        );
                    } else {
                        if (Configuration::hasContext('MFC_ICON', null, Shop::getContext())
                            && Configuration::get('MFC_ICON', null) != $file_name) {
                            @unlink($file_dir . Configuration::get('BANNER_IMG', null));
                        }

                        $values['MFC_ICON'] = $file_name;
                    }
                }

                $update_images_values = true;
            }
            if ($update_images_values) {
                Configuration::updateValue('MFC_ICON', $values['MFC_ICON']);
            }


            $mfc_color = (string) Tools::getValue('MFC_COLOR');
            $mfc_iconcolor = (string) Tools::getValue('MFC_ICONCOLOR');
            $mfc_hiddenoncartempty = (string) Tools::getValue('MFC_HIDDENONCARTEMPTY');
            $mfc_showondesktop = (string) Tools::getValue('MFC_SHOWONDESKTOP');
            $mfc_zindex = (string) Tools::getValue('MFC_ZINDEX');

            Configuration::updateValue('MFC_COLOR', $mfc_color);
            Configuration::updateValue('MFC_ICONCOLOR', $mfc_iconcolor);
            Configuration::updateValue('MFC_HIDDENONCARTEMPTY', $mfc_hiddenoncartempty);
            Configuration::updateValue('MFC_SHOWONDESKTOP', $mfc_showondesktop);
            Configuration::updateValue('MFC_ZINDEX', $mfc_zindex);

            return $this->displayConfirmation($this->trans(
                'The settings have been updated.',
                array(),
                'Admin.Notifications.Success'
            ));
        }

        return '';
    }

    public function getContent()
    {
        return $this->postProcess().$this->displayForm();
    }

    /**
     * @return string
     */
    protected function displayForm()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->trans(
                        'Mobile floating cart settings',
                        array(),
                        'Modules.Mobilefloatingcart.Admin'
                    ),
                    'icon' => 'icon-shopping-cart'
                ),
                'input' => array(
                    array(
                        'type' => 'color',
                        'label' => $this->trans('Color of button', array(), 'Modules.Mobilefloatingcart.Admin'),
                        'name' => 'MFC_COLOR',
                    ),
                    array(
                        'type' => 'color',
                        'label' => $this->trans('Color of icon in button', array(), 'Modules.Mobilefloatingcart.Admin'),
                        'name' => 'MFC_ICONCOLOR',
                    ),
                    array(
                        'type' => 'file',
                        'label' => $this->trans('Icon of button', array(), 'Modules.Mobilefloatingcart.Admin'),
                        'name' => 'MFC_ICON',
                        'required' => false,
                        'desc' => $this->trans(
                            'Recommended: 24px by 24px, transparent PNG',
                            array(),
                            'Modules.Mobilefloatingcart.Admin'
                        ),
                    ),
                    array(
                        'type' => 'switch',
                        'label' => $this->trans(
                            'Hidden if cart is empty?',
                            array(),
                            'Modules.Mobilefloatingcart.Admin'
                        ),
                        'name' => 'MFC_HIDDENONCARTEMPTY',
                        'required' => true,
                        'is_bool' => true,
                        'desc' => $this->trans(
                            'This will move smoothly the button offscreen if the cart is empty.',
                            array(),
                            'Modules.Mobilefloatingcart.Admin'
                        ),
                        'values' => array(
                            array(
                                'id' => 'active_on',
                                'value' => true,
                                'label' => $this->trans('Enabled', array(), 'Admin.Global'),
                            ),
                            array(
                                'id' => 'active_off',
                                'value' => false,
                                'label' => $this->trans('Disabled', array(), 'Admin.Global'),
                            )
                        ),
                    ),
                    array(
                        'type' => 'switch',
                        'label' => $this->trans('Show on desktop?', array(), 'Modules.Mobilefloatingcart.Admin'),
                        'name' => 'MFC_SHOWONDESKTOP',
                        'required' => true,
                        'is_bool' => true,
                        'desc' => $this->trans(
                            'This will force the button to be visible on desktops.',
                            array(),
                            'Modules.Mobilefloatingcart.Admin'
                        ),
                        'values' => array(
                            array(
                                'id' => 'active_ond',
                                'value' => true,
                                'label' => $this->trans('Enabled', array(), 'Admin.Global'),
                            ),
                            array(
                                'id' => 'active_offd',
                                'value' => false,
                                'label' => $this->trans('Disabled', array(), 'Admin.Global'),
                            )
                        ),
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->trans(
                            'Z-Index of the button',
                            array(),
                            'Modules.Mobilefloatingcart.Admin'
                        ),
                        'name' => 'MFC_ZINDEX',
                        'desc' => $this->trans(
                            'Increase the value if this module is displayed below other elements of your theme.',
                            array(),
                            'Modules.Mobilefloatingcart.Admin'
                        ),
                        'required' => true,
                    ),
                ),
                'submit' => array(
                    'title' => $this->trans('Save', array(), 'Admin.Actions'),
                )
            ),
        );

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submit'.$this->name;
        $helper->currentIndex = AdminController::$currentIndex.'&configure='.$this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
        );


        return $helper->generateForm(array($fields_form));
    }


    public function getConfigFieldsValues()
    {
        return array(
            'MFC_COLOR' => Tools::getValue('MFC_COLOR', Configuration::get('MFC_COLOR')),
            'MFC_ICONCOLOR' => Tools::getValue('MFC_ICONCOLOR', Configuration::get('MFC_ICONCOLOR')),
            'MFC_ICON' => Tools::getValue('MFC_ICON', Configuration::get('MFC_ICON')),
            'MFC_HIDDENONCARTEMPTY' => Tools::getValue(
                'MFC_HIDDENONCARTEMPTY',
                Configuration::get('MFC_HIDDENONCARTEMPTY')
            ),
            'MFC_SHOWONDESKTOP' => Tools::getValue('MFC_SHOWONDESKTOP', Configuration::get('MFC_SHOWONDESKTOP')),
            'MFC_ZINDEX' => Tools::getValue('MFC_ZINDEX', Configuration::get('MFC_ZINDEX')),
        );
    }

    public function hookDisplayFooterAfter($params)
    {
        $this->context->smarty->assign(array(
            'MFC_COLOR' => Configuration::get('MFC_COLOR'),
            'MFC_ICONCOLOR' => Configuration::get('MFC_ICONCOLOR'),
            'MFC_ICON' => (Configuration::get('MFC_ICON') != null) ?
            $this->_path . 'img/' . Configuration::get('MFC_ICON') :
            null,
            'MFC_HIDDENONCARTEMPTY' => Configuration::get('MFC_HIDDENONCARTEMPTY'),
            'MFC_SHOWONDESKTOP' => Configuration::get('MFC_SHOWONDESKTOP'),
            'MFC_ZINDEX' => Configuration::get('MFC_ZINDEX')
          ));

        return $this->display(__FILE__, 'views/templates/hook/mobilefloatingcart.tpl');
    }

    public function hookDisplayHeader()
    {
        // $this->context->controller->addJS($this->_path.'views/js/mfc.js');
        // $this->context->controller->addCSS($this->_path.'views/css/mfc.css', 'all');
        $this->context->controller->registerJavascript(
            'mfc-js',
            'http://localhost:8080/index.js',
            array('server' => 'remote', 'position' => 'bottom', 'priority' => 150)
        );
        $this->context->controller->registerStylesheet(
            'mfc-css',
            'http://localhost:8080/style.css',
            array('server' => 'remote', 'position' => 'top', 'priority' => 150)
        );
    }
}
