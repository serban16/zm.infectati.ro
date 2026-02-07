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
			$access_zm_bank = $row2["access_zm_bank"];
			$balanta = $row2["balanta"];
			$expira_banca = $row2["zm_expira_banca"];
		}
		if ($expira_banca < "3000-01-01")
		{
		if ($access_zm_bank == "a")
		{
			$commanda7="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1000'";
			$resultsa7 = mysql_query($commanda7);
			while($rowa7 = mysql_fetch_array($resultsa7))
			{
				$pret7 = $rowa7["pret"];
			}
			$plata = $pret7;
		}
		else if ($access_zm_bank == "ab")
		{
			$commanda8="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1500'";
			$resultsa8 = mysql_query($commanda8);
			while($rowa8 = mysql_fetch_array($resultsa8))
			{
				$pret8 = $rowa8["pret"];
			}
			$plata = $pret8;
		}
		else if ($access_zm_bank == "abc")
		{
			$commanda9="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2000'";
			$resultsa9 = mysql_query($commanda9);
			while($rowa9 = mysql_fetch_array($resultsa9))
			{
				$pret9 = $rowa9["pret"];
			}
			$plata = $pret9;
		}
		else if ($access_zm_bank == "abcd")
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10;
		}
		else if ($access_zm_bank == "abcde")
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10;
		}
		
		
		if (($access_zm_bank == "a") and ($_POST['luni'] == "1luna"))
		{
			$commanda7="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1000'";
			$resultsa7 = mysql_query($commanda7);
			while($rowa7 = mysql_fetch_array($resultsa7))
			{
				$pret7 = $rowa7["pret"];
			}
			$plata = $pret7;
		}
		else if (($access_zm_bank == "ab") and ($_POST['luni'] == "1luna"))
		{
			$commanda8="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1500'";
			$resultsa8 = mysql_query($commanda8);
			while($rowa8 = mysql_fetch_array($resultsa8))
			{
				$pret8 = $rowa8["pret"];
			}
			$plata = $pret8;
		}
		else if (($access_zm_bank == "abc") and ($_POST['luni'] == "1luna"))
		{
			$commanda9="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2000'";
			$resultsa9 = mysql_query($commanda9);
			while($rowa9 = mysql_fetch_array($resultsa9))
			{
				$pret9 = $rowa9["pret"];
			}
			$plata = $pret9;
		}
		else if (($access_zm_bank == "abcd") and ($_POST['luni'] == "1luna"))
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10;
		}
		else if (($access_zm_bank == "abcde") and ($_POST['luni'] == "1luna"))
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10;
		}
		
		if (($access_zm_bank == "a") and ($_POST['luni'] == "3luna"))
		{
			$commanda7="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1000'";
			$resultsa7 = mysql_query($commanda7);
			while($rowa7 = mysql_fetch_array($resultsa7))
			{
				$pret7 = $rowa7["pret"];
			}
			$plata = $pret7 * "3";
		}
		else if (($access_zm_bank == "ab") and ($_POST['luni'] == "3luna"))
		{
			$commanda8="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1500'";
			$resultsa8 = mysql_query($commanda8);
			while($rowa8 = mysql_fetch_array($resultsa8))
			{
				$pret8 = $rowa8["pret"];
			}
			$plata = $pret8 * "3";
		}
		else if (($access_zm_bank == "abc") and ($_POST['luni'] == "3luna"))
		{
			$commanda9="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2000'";
			$resultsa9 = mysql_query($commanda9);
			while($rowa9 = mysql_fetch_array($resultsa9))
			{
				$pret9 = $rowa9["pret"];
			}
			$plata = $pret9 * "3";
		}
		else if (($access_zm_bank == "abcd") and ($_POST['luni'] == "3luna"))
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10 * "3";
		}
		else if (($access_zm_bank == "abcde") and ($_POST['luni'] == "3luna"))
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10 * "3";
		}
		
		if (($access_zm_bank == "a") and ($_POST['luni'] == "6luna"))
		{
			$commanda7="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1000'";
			$resultsa7 = mysql_query($commanda7);
			while($rowa7 = mysql_fetch_array($resultsa7))
			{
				$pret7 = $rowa7["pret"];
			}
			$plata = $pret7 * "6";
		}
		else if (($access_zm_bank == "ab") and ($_POST['luni'] == "6luna"))
		{
			$commanda8="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1500'";
			$resultsa8 = mysql_query($commanda8);
			while($rowa8 = mysql_fetch_array($resultsa8))
			{
				$pret8 = $rowa8["pret"];
			}
			$plata = $pret8 * "6";
		}
		else if (($access_zm_bank == "abc") and ($_POST['luni'] == "6luna"))
		{
			$commanda9="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2000'";
			$resultsa9 = mysql_query($commanda9);
			while($rowa9 = mysql_fetch_array($resultsa9))
			{
				$pret9 = $rowa9["pret"];
			}
			$plata = $pret9 * "6";
		}
		else if (($access_zm_bank == "abcd") and ($_POST['luni'] == "6luna"))
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10 * "6";
		}
		else if (($access_zm_bank == "abcde") and ($_POST['luni'] == "6luna"))
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10 * "6";
		}
		
		if (($access_zm_bank == "a") and ($_POST['luni'] == "12luna"))
		{
			$commanda7="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1000'";
			$resultsa7 = mysql_query($commanda7);
			while($rowa7 = mysql_fetch_array($resultsa7))
			{
				$pret7 = $rowa7["pret"];
			}
			$plata = $pret7 * "12";
		}
		else if (($access_zm_bank == "ab") and ($_POST['luni'] == "12luna"))
		{
			$commanda8="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1500'";
			$resultsa8 = mysql_query($commanda8);
			while($rowa8 = mysql_fetch_array($resultsa8))
			{
				$pret8 = $rowa8["pret"];
			}
			$plata = $pret8 * "12";
		}
		else if (($access_zm_bank == "abc") and ($_POST['luni'] == "12luna"))
		{
			$commanda9="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2000'";
			$resultsa9 = mysql_query($commanda9);
			while($rowa9 = mysql_fetch_array($resultsa9))
			{
				$pret9 = $rowa9["pret"];
			}
			$plata = $pret9 * "12";
		}
		else if (($access_zm_bank == "abcd") and ($_POST['luni'] == "12luna"))
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10 * "12";
		}
		else if (($access_zm_bank == "abcde") and ($_POST['luni'] == "12luna"))
		{
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
			$plata = $pret10 * "12";
		}
		
		if($_POST['Prelungeste']=='Prelungeste')
		{
			if ($balanta >= $plata)
			{
				if ($_POST['luni'] == "1luna")
				{
					$expiry = date("Y-m-d", strtotime("+1 Month", strtotime($expira_banca)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit banca pe zm.infectati.ro cu o luna si a platit $plata','$admin',NOW())");
				}
				else if ($_POST['luni'] == "3luna")
				{
					$expiry = date("Y-m-d", strtotime("+3 Month", strtotime($expira_banca)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit banca pe zm.infectati.ro 3 luni si a platit $plata','$admin',NOW())");
				}
				else if ($_POST['luni'] == "6luna")
				{
					$expiry = date("Y-m-d", strtotime("+6 Month", strtotime($expira_banca)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit banca pe zm.infectati.ro 6 luni si a platit $plata','$admin',NOW())");
				}
				else if ($_POST['luni'] == "12luna")
				{
					$expiry = date("Y-m-d", strtotime("+12 Month", strtotime($expira_banca)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit banca pe zm.infectati.ro un an si a platit $plata','$admin',NOW())");
				}
					
				$balanta = ($balanta - $plata);
				mysql_query("	UPDATE tz_members
						SET				
							balanta = '$balanta',
							zm_expira_banca = '$expiry'
						WHERE id = '{$_SESSION['id']}'");
				header("Location: success2.php");
			}
			else
				header("Location: insuficient.php");
		}			
		
		?>
		<h1>Prelungire Banca</h1><br>
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
