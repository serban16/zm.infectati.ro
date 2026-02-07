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
				$adminu = $row16["admin"];
			}
			if (($adminu == "da") or ($adminu == "avertisment"))
			{
			$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results2 = mysql_query($command2);
			while($row2 = mysql_fetch_array($results2))
			{
				$auth = $row2['auth'];
				$admin = $row2['admin'];
			}
			require 'meniu.php'; 
		?>
        
        <div class="container">
		<?php
	$command2="SELECT * FROM tz_members WHERE auth LIKE '{$_POST['casuta4']}'";
	$results2 = mysql_query($command2);
	while($row2 = mysql_fetch_array($results2))
	{
		$access_cs = $row2["access_cs"];
		$access_zm = $row2["access_zm"];
		$access_zm_vip = $row2["access_zm_vip"];
		$avertisment_cs = $row2["avertisment_cs"];
		$avertisment_zm = $row2["avertisment_zm"];
		$avertisment_zm_vip = $row2["avertisment_zm_vip"];
	}

	if ($_POST['casuta1'] !== $avertisment_cs)
		$expiry_cs = date("Y-m-d", time() + 30*24*60*60 );
	if ($_POST['casuta2'] !== $avertisment_zm)
		$expiry_zm = date("Y-m-d", time() + 30*24*60*60 );
	if ($_POST['casuta3'] !== $avertisment_zm_vip)
		$expiry_zm_vip = date("Y-m-d", time() + 30*24*60*60 );

	if ($_POST['casuta1'] == "3")
	{
		if ($access_cs == "z")
		{
			$access_cs = "z";
		}
		else if ($access_cs == "b")
		{
			$access_cs = "b";
		}
		else if ($access_cs == "cefij")
		{
			$access_cs = "z";
		}
		else if ($access_cs == "cdefijm")
		{
			$access_cs = "cefij";
		}
		else if ($access_cs == "cdefgijmn")
		{
			$access_cs = "cdefijm";
		}
		else if ($access_cs == "abcdefghijklmnopqrstu")
		{
			$access_cs = "cdefgijmn";
		}
		else if ($access_cs == "bcefij")
		{
			$access_cs = "b";
		}
		else if ($access_cs == "bcdefijm")
		{
			$access_cs = "bcefij";
		}
		else if ($access_cs == "bcdefgijmn")
		{
			$access_cs = "bcdefijm";
		}
		$alert = "0";
		$expiry_cs = "3000-01-01";
		if ($avertisment_cs !== $_POST['casuta1'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta4']} 3 avertismente la gradul de admin pe server-ul cs.infectati.ro','$admin',NOW())");
	}
	else if ($_POST['casuta1'] == "2")
	{
		$alert = "2";
		if ($avertisment_cs !== $_POST['casuta1'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta4']} 2 avertismente la gradul de admin pe server-ul cs.infectati.ro','$admin',NOW())");
	}
	else if ($_POST['casuta1'] == "1")
	{
		$alert = "1";
		if ($avertisment_cs !== $_POST['casuta1'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta4']} 1 avertisment la gradul de admin pe server-ul cs.infectati.ro','$admin',NOW())");
	}
	else if ($_POST['casuta1'] == "0")
	{
		$alert = "0";
		$expiry_cs = "3000-01-01";
		if ($avertisment_cs !== $_POST['casuta1'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a scos toate avertismentele lui {$_POST['casuta4']} la gradul de admin pe server-ul cs.infectati.ro','$admin',NOW())");
	}
	
	if ($_POST['casuta2'] == "3")
	{
		if ($access_zm == "z")
		{
			$access_zm = "z";
		}
		else if ($access_zm == "b")
		{
			$access_zm = "b";
		}
		else if ($access_zm == "cefij")
		{
			$access_zm = "z";
		}
		else if ($access_zm == "cdefijm")
		{
			$access_zm = "cefij";
		}
		else if ($access_zm == "cdefgijmn")
		{
			$access_zm = "cdefijm";
		}
		else if ($access_zm == "abcdefghijklmnopqrstu")
		{
			$access_zm = "cdefgijmn";
		}
		else if ($access_zm == "bcefij")
		{
			$access_zm = "b";
		}
		else if ($access_zm == "bcdefijm")
		{
			$access_zm = "bcefij";
		}
		else if ($access_zm == "bcdefgijmn")
		{
			$access_zm = "bcdefijm";
		}
		else if ($access_zm == "x")
		{
			$access_zm = "x";
		}
		else if ($access_zm == "bx")
		{
			$access_zm = "bx";
		}
		else if ($access_zm == "cefijx")
		{
			$access_zm = "x";
		}
		else if ($access_zm == "cdefijmx")
		{
			$access_zm = "cefijx";
		}
		else if ($access_zm == "cdefgijmnx")
		{
			$access_zm = "cdefijmx";
		}
		else if ($access_zm == "abcdefghijklmnopqrstux")
		{
			$access_zm = "cdefgijmnx";
		}
		else if ($access_zm == "bcefijx")
		{
			$access_zm = "bx";
		}
		else if ($access_zm == "bcdefijmx")
		{
			$access_zm = "bcefijx";
		}
		else if ($access_zm == "bcdefgijmnx")
		{
			$access_zm = "bcdefijmx";
		}
		$alert2 = "0";
		$expiry_zm = "3000-01-01";
		if ($avertisment_zm !== $_POST['casuta2'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta4']} la gradul de admin 3 avertismente pe server-ul zm.infectati.ro','$admin',NOW())");
	}
	else if ($_POST['casuta2'] == "2")
	{
		$alert2 = "2";
		if ($avertisment_zm !== $_POST['casuta2'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta4']} la gradul de admin 2 avertismente pe server-ul zm.infectati.ro','$admin',NOW())");
	}
	else if ($_POST['casuta2'] == "1")
	{
		$alert2 = "1";
		if ($avertisment_zm !== $_POST['casuta2'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta4']} la gradul de admin 1 avertisment pe server-ul zm.infectati.ro','$admin',NOW())");
	}
	else if ($_POST['casuta2'] == "0")
	{
		$alert2 = "0";
		$expiry_zm = "3000-01-01";
		if ($avertisment_zm !== $_POST['casuta2'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a scos toate avertismentele lui {$_POST['casuta4']} la gradul de admin pe server-ul zm.infectati.ro','$admin',NOW())");
	}

	if ($_POST['casuta3'] == "3")
	{
		if ($access_zm == "x")
		{
			$access_zm = "z";
		}
		else if ($access_zm == "bx")
		{
			$access_zm = "b";
		}
		else if ($access_zm == "cefijx")
		{
			$access_zm = "cefij";
		}
		else if ($access_zm == "cdefijmx")
		{
			$access_zm = "cdefijm";
		}
		else if ($access_zm == "cdefgijmnx")
		{
			$access_zm = "cdefgijmn";
		}
		else if ($access_zm == "abcdefghijklmnopqrstux")
		{
			$access_zm = "abcdefghijklmnopqrstu";
		}
		else if ($access_zm == "bcefijx")
		{
			$access_zm = "bcefij";
		}
		else if ($access_zm == "bcdefijmx")
		{
			$access_zm = "bcdefijm";
		}
		else if ($access_zm == "bcdefgijmnx")
		{
			$access_zm = "bcdefgijmn";
		}
		
		if ($access_zm_vip == "abcde")
		{
			$access_zm_vip = "";
		}
		$alert3 = "0";
		$expiry_zm_vip = "3000-01-01";
		if ($avertisment_zm_vip !== $_POST['casuta3'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta4']} la gradul de VIP 3 avertismente pe server-ul zm.infectati.ro','$admin',NOW())");
	}
	else if ($_POST['casuta3'] == "2")
	{
		$alert3 = "2";
		if ($avertisment_zm_vip !== $_POST['casuta3'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta4']} la gradul de VIP 2 avertismente pe server-ul zm.infectati.ro','$admin',NOW())");
	}
	else if ($_POST['casuta3'] == "1")
	{
		$alert3 = "1";
		if ($avertisment_zm_vip !== $_POST['casuta3'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta4']} la gradul de VIP 1 avertisment pe server-ul zm.infectati.ro','$admin',NOW())");
	}
	else if ($_POST['casuta3'] == "0")
	{
		$alert3 = "0";
		if ($avertisment_zm_vip !== $_POST['casuta3'])
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a scos toate avertismentele lui {$_POST['casuta4']} la gradul de VIP pe server-ul zm.infectati.ro','$admin',NOW())");
	}
		
	mysql_query("	UPDATE tz_members
					SET	
						access_cs = '$access_cs',
						access_zm = '$access_zm',
						access_zm_vip = '$access_zm_vip',

						avertisment_cs_expira = '$expiry_cs',
						avertisment_zm_expira = '$expiry_zm',
						avertisment_zm_vip_expira = '$expiry_zm_vip',
						
						avertisment_cs = '$alert',
						avertisment_zm = '$alert2',
						avertisment_zm_vip = '$alert3'
								
					WHERE auth LIKE '{$_POST['casuta4']}'");
		

		?>
		
		<h1><?php echo 'Avertismentele lui '; echo $_POST['casuta4']; echo ' au fost actualizate.'; ?></h1><br>
		
		
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