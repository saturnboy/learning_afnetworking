<?php
require 'base.php';

if (isset($_GET['id'])) {
	$id = intval(preg_replace('/\D+/', '', $_GET['id']));
	if ($id > 0) {
		$dat = locked_read();
		if ($dat === false) {
			$out = json_encode(array('error' => 'bad datafile read'));
		} else {
			$a = json_decode($dat, true);
			if ($id > count($a)) {
				$out = json_encode(array('error' => 'bad pic id (max=' . count($a) . ')'));
			} else {
				$idx = $id - 1;
				$img = $a[$idx];
				$out = json_encode($img);
			}
		}
	} else {
		$out = json_encode(array('error' => 'bad pic id'));
	}
} else {
	$out = json_encode(array('error' => 'missing id param'));
}

header('Content-Type: application/json');
print $out;
