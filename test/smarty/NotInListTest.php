<?php
require_once 'PHPUnit/Framework.php';

require_once 'common.php';

class NotInListTest extends PHPUnit_Framework_TestCase {
	public function testNotInList() {
		$smarty = CreateSmartyObject();

		// failure
		$smarty->assign('item', 123);
		$smarty->assign('list', 123);
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('', $result);

		// success
		$smarty->assign('list', '1');
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('1', $result);

		// success
		$smarty->assign('list', 345);
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('1', $result);

		CleanupSmartyObject($smarty);
	}

	public function testNotInListMany() {
		$smarty = CreateSmartyObject();

		// failure
		$smarty->assign('item', 123);
		$smarty->assign('list', '123,456,789');
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('', $result);

		// failure
		$smarty->assign('list', '456,123,789');
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('', $result);

		// failure
		$smarty->assign('list', '567,789,123');
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('', $result);

		// failure
		$smarty->assign('list', '567 , 123 , 456');
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('', $result);

		// success
		$smarty->assign('list', '567,893,344');
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('1', $result);

		// success
		$smarty->assign('list', '345, 464,34, 456');
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('1', $result);

		// success
		$smarty->assign('list', '1234,5123,81238,8 123 8');
		$result = $smarty->fetch('NotInList.tpl');
		$this->assertEquals('1', $result);

		CleanupSmartyObject($smarty);
	}
}
