<?php

function locked_read($path = 'dat.json', $blocking = true) { 
	$fp = fopen($path, 'r'); 
	$locked = flock($fp, LOCK_SH, $blocking); 
	
	if ($locked) { 
		$dat = file_get_contents($path); 
		flock($fp, LOCK_UN); 
		fclose($fp); 
		return $dat; 
	}
	return false;
} 