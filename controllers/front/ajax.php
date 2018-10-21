<?php
class MobilefloatingcartAjaxModuleFrontController extends ModuleFrontController
{

	public function initContent()
	{
		$this->ajax = true;
		parent::initContent();
	}

	public function displayAjax()
	{
		$this->context->smarty->assign([
			'MFC_COLOR' => Configuration::get('MFC_COLOR')
		]);
		die(Tools::jsonEncode(array('mfc-content' => $this->context->smarty->fetch(_PS_MODULE_DIR_.'mobilefloatingcart/mobilefloatingcart-content.tpl'))));
	}

}
