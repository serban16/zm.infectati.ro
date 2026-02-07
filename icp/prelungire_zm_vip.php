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
			$access_vip = $row2["access_zm_vip"];
			$balanta = $row2["balanta"];
			$expira_vip = $row2["zm_expira_vip"];
		}
		if ($expira_vip < "3000-01-01")
		{
		
		if ($access_vip == "abcde")
		{
			$commanda6="SELECT * FROM preturi WHERE nume_produs = 'zm_vip'";
			$resultsa6 = mysql_query($commanda6);
			while($rowa6 = mysql_fetch_array($resultsa6))
			{
				$pret6 = $rowa6["pret"];
			}
			$plata = $pret6;
		}
			
		if (($access_vip == "abcde") and ($_POST['luni'] == "1luna"))
		{
			$commanda6="SELECT * FROM preturi WHERE nume_produs = 'zm_vip'";
			$resultsa6 = mysql_query($commanda6);
			while($rowa6 = mysql_fetch_array($resultsa6))
			{
				$pret6 = $rowa6["pret"];
			}
			$plata = $pret6;
		}		
		else if (($access_vip == "abcde") and ($_POST['luni'] == "3luna"))
		{
			$commanda6="SELECT * FROM preturi WHERE nume_produs = 'zm_vip'";
			$resultsa6 = mysql_query($commanda6);
			while($rowa6 = mysql_fetch_array($resultsa6))
			{
				$pret6 = $rowa6["pret"];
			}
			$plata = $pret6 * "3";
		}		
		else if (($access_vip == "abcde") and ($_POST['luni'] == "6luna"))
		{
			$commanda6="SELECT * FROM preturi WHERE nume_produs = 'zm_vip'";
			$resultsa6 = mysql_query($commanda6);
			while($rowa6 = mysql_fetch_array($resultsa6))
			{
				$pret6 = $rowa6["pret"];
			}
			$plata = $pret6 * "6";
		}
		else if (($access_vip == "abcde") and ($_POST['luni'] == "12luna"))
		{
			$commanda6="SELECT * FROM preturi WHERE nume_produs = 'zm_vip'";
			$resultsa6 = mysql_query($commanda6);
			while($rowa6 = mysql_fetch_array($resultsa6))
			{
				$pret6 = $rowa6["pret"];
			}
			$plata = $pret6 * "12";
		}
		
		if($_POST['Prelungeste']=='Prelungeste')
		{
			if ($balanta >= $plata)
			{
				if ($_POST['luni'] == "1luna")
				{
					$expiry = date("Y-m-d", strtotime("+1 Month", strtotime($expira_vip)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit VIP-ul pe zm.infectati.ro cu o luna si a platit $plata','$admin',NOW())");
				}
				else if ($_POST['luni'] == "3luna")
				{
					$expiry = date("Y-m-d", strtotime("+3 Month", strtotime($expira_vip)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit VIP-ul pe zm.infectati.ro 3 luni si a platit $plata','$admin',NOW())");
				}
				else if ($_POST['luni'] == "6luna")
				{
					$expiry = date("Y-m-d", strtotime("+6 Month", strtotime($expira_vip)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit VIP-ul pe zm.infectati.ro 6 luni si a platit $plata','$admin',NOW())");
				}
				else if ($_POST['luni'] == "12luna")
				{
					$expiry = date("Y-m-d", strtotime("+12 Month", strtotime($expira_vip)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit VIP-ul pe zm.infectati.ro un an si a platit $plata','$admin',NOW())");
				}
					
				$balanta = ($balanta - $plata);
				mysql_query("	UPDATE tz_members
						SET				
							balanta = '$balanta',
							zm_expira_vip = '$expiry'
						WHERE id = '{$_SESSION['id']}'");
				header("Location: success2.php");
			}
			else
				header("Location: insuficient.php");
		}			
		
		?>
		<h1>Prelungire Vip</h1><br>
		<form name="prelungire" action="" method="post">
			<h3>Prelungire: <select name="luni" onchange="this.form.submit();">
				<option <?php if ($_POST['luni'] == "1luna") { ?> selected <?php } ?> value="1luna">O Luna</option>
				<option <?php if ($_POST['luni'] == "3luna") { ?> selected <?php } ?> value="3luna">3 Luni</option>
				<option <?php if ($_POST['luni'] == "6luna") { ?> selected <?php } ?> value="6luna">6 Luni</option>
				<option <?php if ($_POST['luni'] == "12luna") { ?> selected <?php } ?> value="12luna">Un An</option>
			</select></h3><br>
			<h1>Total Plata: <?php echo $plata; echo ' Euro' ?></h1>
			<input type="submit" name="Prelungeste" value="Prelungeste" class="buton_albastru" />
		</form>
		<?php
		}
		else
		{
			header("Location: index.php");
		}
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
