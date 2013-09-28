<?php
require 'base.php';

$dat = locked_read();

header('Content-Type: application/json');
//echo json_encode($sample);
print $dat;
