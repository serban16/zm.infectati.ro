<?php

define('INCLUDE_CHECK',true);

require 'connect.php';
require 'functions.php';
require 'header.php';


// Those two files can be included only if INCLUDE_CHECK is defined



?>

<html>
<body>
<div class="pageContent">
    <div id="main">
      <div class="container">
        <h1>ICP</h1>
        <h2>Infect Control Panel</h2>
        </div>
		
		<?php
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
			require 'meniu.php'; 
		?>
        
        <div class="container">
		<?php
		
		$cauta_sql = "SELECT * FROM tz_members WHERE auth LIKE '".$_POST['casuta']."'";
		$cauta_query = mysql_query($cauta_sql);
		
		$cauta_sql2 = "SELECT * FROM ban_server WHERE nume LIKE '".$_POST['casuta']."'";
		$cauta_query2 = mysql_query($cauta_sql2);
		
		if((mysql_num_rows($cauta_query) >= 1) and (mysql_num_rows($cauta_query2) == 0))
		{
			mysql_query("INSERT INTO ban_server(nume,zm,cs,timp_cs,timp_zm) VALUES ('".$_POST['casuta']."','0','0','0','0')");
		}
		$cauta_sql2 = "SELECT * FROM ban_server WHERE nume LIKE '".$_POST['casuta']."'";
		$cauta_query2 = mysql_query($cauta_sql2);
		
		if (mysql_num_rows($cauta_query2) >= 1)
		{
		while($row2 = mysql_fetch_array($cauta_query2))
		{
			$nume = $row2["nume"];
			$zm = $row2["zm"];
			$cs = $row2["cs"];
			$timp_cs = $row2["timp_cs"];
			$timp_zm = $row2["timp_zm"];
			$motiv_cs = $row2["motiv_cs"];
			$motiv_zm = $row2["motiv_zm"];
		}

		?>
		
		<h1>Baneaza/Debaneaza un Jucator</h1><br>
		
		<form name="form2" method="post"  action="ban_server3.php">
		<input type="hidden" name="nume_ghinionist" value="<?php echo $nume; ?>">
		<?php
		if ($da == "da")
		{ ?>
			<br><h3>Zm.infectati.ro:</h3>
			<br><h3>Banat:<select name="ban_zm">
				<option <?php if ($zm == "1") { ?> selected <?php } ?> value="1">Da</option>
				<option <?php if ($zm == "0") { ?> selected <?php } ?> value="0">Nu</option>
			</select>
			Minute:  <input type="text" name="minute_zm" value="<?php echo $timp_zm; ?>">
			Motiv:  <input type="text" name="motiv_zm" value="<?php echo $motiv_zm; ?>"></h3>
		<?
		}
		if ($vodka =="da")
		{
		?>
			<br><br><br><h3>Cs.infectati.ro:</h3>
			<br><h3>Banat:<select name="ban_cs">
				<option <?php if ($cs == "1") { ?> selected <?php } ?> value="1">Da</option>
				<option <?php if ($cs == "0") { ?> selected <?php } ?> value="0">Nu</option>
			</select>
			Minute:  <input type="text" name="minute_cs" value="<?php echo $timp_cs; ?>">
			Motiv:  <input type="text" name="motiv_cs" value="<?php echo $motiv_cs; ?>"></h3><br>
			
		<?php
		}
		?>
			<input type="submit" name="submit2" value="Trimite" class="buton_albastru" /><br><br>

			
		</form>
		
		<?php
		}
		else
		{
		?>
		<h1>Nu a fost gasit nici un utilizator cu acest nume.</h1>
		<?php
		}
		?>
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
