<head>
    <link rel="stylesheet" type="text/css" href="style/slide.css"/>
    
</head>
		<?php
		define('INCLUDE_CHECK',true);
		$user = $_POST['user'];
		$pass = $_POST['pass'];
		$castig = $_POST['castig'];
		$biletel = $_POST['nrbilet2'];
		require 'connect.php';
		
		
	$cauta_sql323 = "SELECT * FROM bilete WHERE nr_bilet= '$biletel'";
	$cauta_query323 = mysql_query($cauta_sql323);
	
	if(($_POST['extrage']) and (mysql_num_rows($cauta_query323) >= 1))
	{
	
		$command2 = mysql_query("SELECT * FROM tz_members WHERE auth= '$user' AND password= '$pass'");
		$results2 = mysql_fetch_assoc($command2);
		
		$balanta = $results2["balanta"];
		$admin = $results2['admin'];
		
		mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$user si-a extras banii de pe biletul cu nr.: $biletel . I-am adaugat $castig Euro ','$admin',NOW())");
		
		$balanta = $balanta + $castig;
		
				mysql_query("	UPDATE tz_members
						SET				
							balanta = '$balanta'
						WHERE auth= '$user' AND password= '$pass'");
		
		$sql44="DELETE FROM bilete WHERE nr_bilet=$biletel";
		$result44=mysql_query($sql44);
	?>
	<div class="success">Fondurile au fost extrase si depozitate in contul tau.</div>
	<?php
	}
	else
	{
		?>
<div class="success">Nu Spama mai Marius. :))</div> 
<?php
}
?>
