<?php

class ShopProduct {
	public $numPages;
	public $playLength;

	public $title;              
	public $producerMainName;
	public $producerFirstName;
	public $price;

	function __construct ( $title,$firstName,$mainName,$price,$numPages=0,$playLength=0)    {
		$this->title = $title;
		$this->producerFirstName = $firstName;
		$this->producerMainName = $mainName;
		$this->price = $price;
		$this->numPages = $numPages;
		$this->playLength = $playLength;
	}              


	function getProducer() {
		return "{$this->producerFirstName}"."{$this->producerMainName}";
	}

	function getSummaryLine(){
		$base = "$this->title({$this->producerMainName},";
		$base .= "{$this->producerFirstName} )";
		return $base;
	}
}

class CdProduct extends ShopProduct {
	function getPlayLength() {
		return $this->playLength;
	}

	function getSummartyLine() {
		$base = "$this->title({$this->producerMainName},";
		$base .= "{$this->producerFirstName} )";
		$base .= ":play time- {$this->playLength}";
		return $base;
	}

}

class BookProduct extends ShopProduct {
	function getNumberOfPages() {
		return $this->numPages;
	}

	function getSummaryLine(){
		$base = "$this->title({$this->producerMainName},";
		$base .= "{$this->producerFirstName} )";
		$base .= ":page count - {$this->numPages}";
		return $base;
	}
}


$product2 = new CdProduct ("exile on coldharbour lane","the","alabama3",10.99,null,60.33);

print "artist: {$product2->getProducer()}\n";




class shopproduct {
	public $numPages;
	public $playLength;
	public $title;
	public $producertmainname;
	public $producerFirstName;
	public $price;

	function __construct ($title,$firstName,$mainName,$price,$numPages=0;$playLength=0)
	{
		$this->title =$title;
		$this->producerFirstName =$firstName;
		$this->producerMainName = $mainName;
		$this->price  =$price;
		$this->numPages = $numPages;
		$this->playLength = $playLength;
	}
}

?>

