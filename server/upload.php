<?php
date_default_timezone_set('America/Denver');

function add_pic_to_dat($img, $path = 'dat.json', $blocking = true) {
	$fp = fopen($path, 'r+'); 
	$locked = flock($fp, LOCK_EX, $blocking); 
	
	if ($locked) { 
		$dat = file_get_contents($path); 
		$a = json_decode($dat, true);
		$a[] = $img;
		$out = json_encode($a);

		ftruncate($fp, 0);
		fwrite($fp, $out);
		fflush($fp);

		flock($fp, LOCK_UN); 
		fclose($fp); 
		return json_encode($img);
	}
	return false;
}

if (!isset($_FILES['pic'])) {
	$out = json_encode(array('error' => 'missing pic param'));
} else if (!isset($_POST['title'])) {
	$out = json_encode(array('error' => 'missing title param'));
} else if (!isset($_POST['desc'])) {
	$out = json_encode(array('error' => 'missing desc param'));
} else {
	//compute target filename
	list($usec, $sec) = explode(" ", microtime());
	$usec = substr($usec, 2, 3);
	$ext = pathinfo($_FILES['pic']['name'], PATHINFO_EXTENSION);
	$target = 'pics/pic_' . $sec . '_' . $usec . '.' . $ext;
	$stamp = date('Y-m-d H:i:s', $sec) . '.' . $usec;

	//move upload to target filename
	if (move_uploaded_file($_FILES['pic']['tmp_name'], $target)) {
		$out = add_pic_to_dat(array('pic' => $target, 'title' => $_POST['title'], 'desc' => $_POST['desc'], 'stamp' => $stamp));
		if ($out === false) {
			$out = json_encode(array('error' => 'bad datafile write'));
		}
	} else {
		$out = json_encode(array('error' => 'pic upload error'));
	}
}

header('Content-Type: application/json');
print $out;
