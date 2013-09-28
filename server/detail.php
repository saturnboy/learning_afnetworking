<?php
require 'base.php';

if (isset($_GET['id'])) {
	$id = intval(preg_replace('/\D+/', '', $_GET['id']));
	if ($id > 0) {
		$dat = locked_read();
		$a = json_decode($dat, true);
		foreach ($a as $img) {
			if (array_key_exists('id', $img) && $img['id'] === $id) {
				$out = json_encode($img);
				break;
			}
		}
		if (!isset($out)) {
			$out = json_encode(array('error' => 'pic (id=' . $id . ') not found'));
		}
	} else {
		$out = json_encode(array('error' => 'bad pic id'));
	}
} else {
	$out = json_encode(array('error' => 'missing id param'));
}

header('Content-Type: application/json');
print $out;
