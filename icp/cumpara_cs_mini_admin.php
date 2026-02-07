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
	<?php require 'meniu.php'; ?>
		
        
        <div class="container">
        <?php
		if($_SESSION['id'])
		{ 
			$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results2 = mysql_query($command2);
			while($row2 = mysql_fetch_array($results2))
			{
				$auth = $row2['auth'];
				$admin = $row2['admin'];
				$email = $row2["email"];
				$balanta = $row2["balanta"];
				$cs_access = $row2["access_cs"];
			}
			$commanda="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa = mysql_query($commanda);
			while($rowa = mysql_fetch_array($resultsa))
			{
				$pret = $rowa["pret"];
			}
			if($_POST['submit']=='Da')
			{
			
				if ($balanta >= $pret)
				{
					$balanta = $balanta - $pret;
					$expiry = date("Y-m-d", time() + 31*24*60*60 );
 
					$today = date("Y-m-d", time());
					
						if ($cs_access == "z")
						{
							$cs_access = "cefij";
						}
						else if ($cs_access == "cefij")
						{
							$cs_access = "cefij";
						}
						else if ($cs_access == "cefij")
						{
							$cs_access = "cefij";
						}
						else if ($cs_access == "cdefijm")
						{
							$cs_access = "cefij";
						}
						else if ($cs_access == "cdefgijmn")
						{
							$cs_access = "cefij";
						}
						else if ($cs_access = "abcdefghijklmnopqrstu")
						{
							$cs_access = "cefij";
						}
						
					mysql_query("	UPDATE tz_members
						SET				
							access_cs = '$cs_access',
							balanta = '$balanta',
							cs_expira_access = '$expiry'
						WHERE id = '{$_SESSION['id']}'");
					$from = "infectati@yahoo.ro";
					$headers = "From:" . $from;
			
					$Body = "";
					$Body .= "Ai cumparat pe Cs.infectati.ro Mini-Admin si iti expira pe data de ";
					$Body .= $expiry;					
					$Body .= "\n";
					$Body .= "Echipa Infectati.ro";
			
					mail($email, "ICP Infect Control Panel - Cumparare Grad", $Body, $headers);
					
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth a cumpara Mini-Admin pe cs.infectati.ro si a platit $pret Euro','$admin',NOW())");

					header("Location: success.php");
				}
				else
					header("Location: insuficient.php");
			}
			else if($_POST['submit']=='Nu')
			{
				header("Location: cumparacs.php");

			}
		?>
		<form action="" method="post">
		<center>
			<h3>Esti sigur ca vrei sa cumperi Mini-Admin pe server-ul Cs.infectati.ro ?<br><br></h3>
			<input type="submit" name="submit" value="Da" class="buton_verde" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    <input type="submit" name="submit" value="Nu" class="buton_rosu" />
		</center>
		</form>
		<?php
		}
		else
		{
			header("Location: autentifica.php");
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
