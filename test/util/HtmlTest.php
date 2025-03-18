<?php

require_once('../../app/class/util/html.class.php');

class HtmlTest extends PHPUnit_Framework_TestCase {
	public function testHtmlScrape() {
		$html = Util_Html::scrapeBodyFromUrl('http://weathers.estore.catalograck.com/v5/members/lookups/applications.asp?strPNID=3171343');
		$this->assertTrue(strpos($html, 'dci_') !== false);
	}

	public function testStripJavascript() {
		$html = Util_Html::scrapeBodyFromUrl('http://weathers.estore.catalograck.com/v5/members/lookups/applications.asp?strPNID=3171343');
		$this->assertTrue(strpos($html, 'script') !== false);

		$stripped = Util_Html::stripJavascript($html);
		$this->assertTrue(strpos($stripped, 'script') === false);
	}
}
