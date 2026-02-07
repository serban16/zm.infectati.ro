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
			}
			$commanda="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
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
					

						
					mysql_query("	UPDATE tz_members
						SET				
							access_zm_bank = 'abcd',
							balanta = '$balanta',
							zm_expira_banca = '$expiry'
						WHERE id = '{$_SESSION['id']}'");
					$from = "infectati@yahoo.ro";
					$headers = "From:" . $from;
			
					$Body = "";
					$Body .= "Ai cumparat pe Zm.infectati.ro Marire banca la 2500 Euro si iti expira pe data de ";
					$Body .= $expiry;					
					$Body .= "\n";
					$Body .= "Echipa Infectati.ro";
			
					mail($email, "ICP Infect Control Panel - Cumparare Grad", $Body, $headers);

					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth a cumpara prelungire banca 2500 Euro pe zm.infectati.ro si a platit $pret Euro','$admin',NOW())");
					
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
			<h3>Esti sigur ca vrei sa cumperi Marire banca la 2500 Euro pe server-ul Zm.infectati.ro ?<br><br></h3>
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
