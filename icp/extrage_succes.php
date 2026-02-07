<head>
    <link rel="stylesheet" type="text/css" href="style/slide.css"/>
    
</head>
		<?php
		define('INCLUDE_CHECK',true);
		$user = $_GET['user'];
		$pass = $_GET['pass'];
		$biletel = $_POST['nrbilet2'];
		require 'connect.php';
		
	if($_POST['extrage'])
	{
	
		$command2 = mysql_query("SELECT * FROM tz_members WHERE auth= '$user' AND password= '$pass'");
		$results2 = mysql_fetch_assoc($command2);
		
		$balanta = $balanta + $castig;
		
				mysql_query("	UPDATE tz_members
						SET				
							balanta = '$balanta'
						WHERE auth= '$user' AND password= '$pass'");
		
		$sql44="DELETE FROM bilete WHERE nr_bilet=$biletel";
		$result44=mysql_query($sql44);
	}
		?>
<div class="success">Fondurile au fost extrase si depozitate in contul tau.</div> 
