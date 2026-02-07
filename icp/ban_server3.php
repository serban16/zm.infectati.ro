<?php

define('INCLUDE_CHECK',true);

require 'connect.php';
require 'functions.php';
require 'header.php';


// Those two files can be included only if INCLUDE_CHECK is defined
			$command16="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results16 = mysql_query($command16);
			while($row16 = mysql_fetch_array($results16))
			{
				$auth = $row16["auth"];
				$access_cs = $row16["access_cs"];
				$zm_access = $row16["access_zm"];
			}
			
			$da = "nu";
			if ($access_cs == "cdefijm")
			{
				$da = "da";
			}
			else if ($access_cs == "cdefgijmn")
			{
				$da = "da";
			}
			else if ($access_cs == "abcdefghijklmnopqrstu")
			{
				$da = "da";
			}
			else if ($access_cs == "bcefij")
			{
				$da = "da";
			}
			else if ($access_cs == "bcdefijm")
			{
				$da = "da";
			}
			else if ($access_cs == "bcdefgijmn")
			{
				$da = "da";
			}
			
			$vodka ="nu";
			
			if (($zm_access == "cefij") or ($zm_access == "cefijx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "cdefijm") or ($zm_access == "cdefijmx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "cdefgijmn") or ($zm_access == "cdefgijmnx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "abcdefghijklmnopqrstu") or ($zm_access == "abcdefghijklmnopqrstux"))
			{
				$vodka ="da";
			}	
			else if (($zm_access == "bcefij") or ($zm_access == "bcefijx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "bcdefijm") or ($zm_access == "bcdefijmx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "bcdefgijmn") or ($zm_access == "bcdefgijmnx"))
			{
				$vodka ="da";
			}
			else if (($zm_access == "abcdefghijklmnopqrstu") or ($zm_access == "abcdefghijklmnopqrstux"))
			{
				$vodka ="da";
			}
			if (($da == "da") or ($vodka =="da"))
			{
		$cauta_sql = "SELECT * FROM ban_server WHERE nume LIKE '".$_POST['nume_ghinionist']."'";
		$cauta_query = mysql_query($cauta_sql);			
		while($row2 = mysql_fetch_array($cauta_query))
		{
			$zm = $row2["zm"];
			$cs = $row2["cs"];
			$timp_cs = $row2["timp_cs"];
			$timp_zm = $row2["timp_zm"];
			$motiv_cs = $row2["motiv_cs"];
			$motiv_zm = $row2["motiv_zm"];
		}
		
		if (($zm !== $_POST['ban_zm']) and ($zm !== "1"))
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth la banat pe ".$_POST['nume_ghinionist']." pe server-ul Zm.Infectati.ro timp de ".$_POST['minute_zm']." minute pe motivul ".$_POST['motiv_zm']."','$admin',NOW())");
		else if (($zm !== $_POST['ban_zm']) and ($zm == "0"))
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth la debanat pe ".$_POST['nume_ghinionist']." pe server-ul Zm.Infectati.ro ','$admin',NOW())");
			
		if (($cs !== $_POST['ban_cs']) and ($cs !== "1"))
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth la banat pe ".$_POST['nume_ghinionist']." pe server-ul Cs.Infectati.ro timp de ".$_POST['minute_cs']." minute pe motivul ".$_POST['motiv_cs']."','$admin',NOW())");
		else if (($cs !== $_POST['ban_cs']) and ($cs == "0"))
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth la debanat pe ".$_POST['nume_ghinionist']." pe server-ul Cs.Infectati.ro ','$admin',NOW())");

?>

<html>
<body>
<div class="pageContent">
    <div id="main">
      <div class="container">
        <h1>ICP</h1>
        <h2>Infect Control Panel</h2>
        </div>
<?php require 'meniu.php'; ?>
	<div class="container">	
		<?php
		mysql_query("	UPDATE ban_server
					SET
						zm = '".$_POST['ban_zm']."',
						cs = '".$_POST['ban_cs']."',
						timp_cs = '".$_POST['minute_cs']."',
						timp_zm = '".$_POST['minute_zm']."',
						motiv_zm = '".$_POST['motiv_zm']."',
						motiv_cs = '".$_POST['motiv_cs']."'
				
								
					WHERE nume = '".$_POST['nume_ghinionist']."'");		
		?>
		<h1><?php echo 'Datele Utilizatorului '; echo $_POST['nume_ghinionist']; echo ' au fost editate.'; ?></h1><br>
		
		
		<?php
		
		}
		else
		{
			header("Location: index.php");
		}
		?>
    </div>
          <div class="clear"></div>
		 <?php
			require 'foother.php';
		 ?>
        </div>
</div>
</body>
</html>
