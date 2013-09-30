<?php
require 'base.php';

$dat = locked_read();

if ($dat === false) {
	$dat = json_encode(array('error' => 'bad datafile read'));
}

header('Content-Type: application/json');
print $dat;
