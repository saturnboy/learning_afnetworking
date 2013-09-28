<?php
require 'base.php';

if (!isset($_POST['pic'])) {
	$out = json_encode(array('error' => 'missing pic param'));
} else if (!isset($_POST['title'])) {
	$out = json_encode(array('error' => 'missing title param'));
} else if (!isset($_POST['desc'])) {
	$out = json_encode(array('error' => 'missing desc param'));
} else {
	$out = json_encode(array('ok' => 'ok'));
}

header('Content-Type: application/json');
print $out;
