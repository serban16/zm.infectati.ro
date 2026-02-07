<?php

if(!defined('INCLUDE_CHECK')) die('You are not allowed to execute this file directly');

$currency = '$'; //Currency sumbol or code

/* Database config */

$db_host		= 'localhost';
$db_user		= 'serbu';
$db_pass		= 'parola-baza-de-date';
$db_database	= 'icp'; 

/* End config */


$mysqli = new mysqli($db_host, $db_user, $db_pass,$db_database);
$link = mysql_connect($db_host,$db_user,$db_pass) or die('Unable to establish a DB connection');


mysql_select_db($db_database,$link);
mysql_query("SET names UTF8");

?>