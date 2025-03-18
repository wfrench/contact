<?php

define('PHPUNIT_SMARTY_ROOT', dirname(dirname(dirname(__FILE__))));

require_once PHPUNIT_SMARTY_ROOT.'/lib/smarty/Smarty.class.php';

function CreateSmartyObject() {
	$smarty = new Smarty;
	$smarty->left_delimiter = '{{';
	$smarty->right_delimiter = '}}';

	$smarty->template_dir = dirname(__FILE__).'/templates';
	$smarty->compile_dir = dirname(__FILE__).'/templates_c';

	$smarty->plugins_dir[] = PHPUNIT_SMARTY_ROOT.'/inc/plugins/smarty';
	$smarty->plugins_dir[] = PHPUNIT_SMARTY_ROOT.'/inc/plugins/smarty/Admin';
	$smarty->plugins_dir[] = PHPUNIT_SMARTY_ROOT.'/inc/plugins/smarty/Frontend';

	return $smarty;
}

function CleanupSmartyObject(Smarty $smarty) {
}
