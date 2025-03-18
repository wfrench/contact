<?php
require_once 'PHPUnit/Framework.php';

require_once 'common.php';

class InListTest extends PHPUnit_Framework_TestCase {
	public function testInList() {
		$smarty = CreateSmartyObject();

		// success
		$smarty->assign('item', 123);
		$smarty->assign('list', 123);
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('1', $result);

		// failure
		$smarty->assign('list', '');
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('', $result);

		// failure
		$smarty->assign('list', 345);
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('', $result);

		CleanupSmartyObject($smarty);
	}

	public function testInListMany() {
		$smarty = CreateSmartyObject();

		// success
		$smarty->assign('item', 123);
		$smarty->assign('list', '123,456,789');
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('1', $result);

		// success
		$smarty->assign('list', '456,123,789');
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('1', $result);

		// success
		$smarty->assign('list', '567,789,123');
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('1', $result);

		// success
		$smarty->assign('list', '567 , 123 , 456');
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('1', $result);

		// failure
		$smarty->assign('list', '567,893,344');
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('', $result);

		// failure
		$smarty->assign('list', '345, 464,34, 456');
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('', $result);

		// failure
		$smarty->assign('list', '1234,5123,81238,8 123 8');
		$result = $smarty->fetch('InList.tpl');
		$this->assertEquals('', $result);

		CleanupSmartyObject($smarty);
	}
}
