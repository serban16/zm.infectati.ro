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
			$access_cs = $row2["access_cs"];
			$balanta = $row2["balanta"];
			$expira_cs = $row2["cs_expira_access"];
		}

		if ($expira_cs < "3000-01-01")
		{
		if ($access_cs == "b")
		{
			$commanda="SELECT * FROM preturi WHERE nume_produs = 'cs_slot'";
			$resultsa = mysql_query($commanda);
			while($rowa = mysql_fetch_array($resultsa))
			{
				$pret = $rowa["pret"];
			}
			$plata = $pret;
		}
		else if ($access_cs == "cefij")
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2;
		}
		else if ($access_cs == "cdefijm")
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3;
		}
		else if ($access_cs == "cdefgijmn")
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4;
		}
		else if ($access_cs == "abcdefghijklmnopqrstu")
		{
			$commanda5="SELECT * FROM preturi WHERE nume_produs = 'cs_owner'";
			$resultsa5 = mysql_query($commanda5);
			while($rowa5 = mysql_fetch_array($resultsa5))
			{
				$pret5 = $rowa5["pret"];
			}
			$plata = $pret5;
		}
		else if ($access_cs == "bcefij")
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2;
		}
		else if ($access_cs == "bcdefijm")
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3;
		}
		else if ($access_cs == "bcdefgijmn")
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4;
		}
		
		
		if (($access_cs == "b") and ($_POST['luni'] == "1luna"))
		{
			$commanda="SELECT * FROM preturi WHERE nume_produs = 'cs_slot'";
			$resultsa = mysql_query($commanda);
			while($rowa = mysql_fetch_array($resultsa))
			{
				$pret = $rowa["pret"];
			}
			$plata = $pret;
		}
		else if (($access_cs == "cefij") and ($_POST['luni'] == "1luna"))
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2;
		}
		else if (($access_cs == "cdefijm") and ($_POST['luni'] == "1luna"))
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3;
		}
		else if (($access_cs == "cdefgijmn") and ($_POST['luni'] == "1luna"))
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4;
		}
		else if (($access_cs == "abcdefghijklmnopqrstu") and ($_POST['luni'] == "1luna"))
		{
			$commanda5="SELECT * FROM preturi WHERE nume_produs = 'cs_owner'";
			$resultsa5 = mysql_query($commanda5);
			while($rowa5 = mysql_fetch_array($resultsa5))
			{
				$pret5 = $rowa5["pret"];
			}
			$plata = $pret5;
		}
		else if (($access_cs == "bcefij") and ($_POST['luni'] == "1luna"))
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2;
		}
		else if (($access_cs == "bcdefijm")  and ($_POST['luni'] == "1luna"))
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3;
		}
		else if (($access_cs == "bcdefgijmn")  and ($_POST['luni'] == "1luna"))
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4;
		}
		
		if (($access_cs == "b") and ($_POST['luni'] == "3luna"))
		{
			$commanda="SELECT * FROM preturi WHERE nume_produs = 'cs_slot'";
			$resultsa = mysql_query($commanda);
			while($rowa = mysql_fetch_array($resultsa))
			{
				$pret = $rowa["pret"];
			}
			$plata = $pret * "3";
		}
		else if (($access_cs == "cefij") and ($_POST['luni'] == "3luna"))
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2 * "3";
		}
		else if (($access_cs == "cdefijm") and ($_POST['luni'] == "3luna"))
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3 * "3";
		}
		else if (($access_cs == "cdefgijmn") and ($_POST['luni'] == "3luna"))
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4 * "3";
		}
		else if (($access_cs == "abcdefghijklmnopqrstu") and ($_POST['luni'] == "3luna"))
		{
			$commanda5="SELECT * FROM preturi WHERE nume_produs = 'cs_owner'";
			$resultsa5 = mysql_query($commanda5);
			while($rowa5 = mysql_fetch_array($resultsa5))
			{
				$pret5 = $rowa5["pret"];
			}
			$plata = $pret5 * "3";
		}
		else if (($access_cs == "bcefij") and ($_POST['luni'] == "3luna"))
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2 * "3";
		}
		else if (($access_cs == "bcdefijm")  and ($_POST['luni'] == "3luna"))
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3 * "3";
		}
		else if (($access_cs == "bcdefgijmn")  and ($_POST['luni'] == "3luna"))
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4 * "3";
		}
		
		if (($access_cs == "b") and ($_POST['luni'] == "6luna"))
		{
			$commanda="SELECT * FROM preturi WHERE nume_produs = 'cs_slot'";
			$resultsa = mysql_query($commanda);
			while($rowa = mysql_fetch_array($resultsa))
			{
				$pret = $rowa["pret"];
			}
			$plata = $pret * "6";
		}
		else if (($access_cs == "cefij") and ($_POST['luni'] == "6luna"))
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2 * "6";
		}
		else if (($access_cs == "cdefijm") and ($_POST['luni'] == "6luna"))
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3 * "6";
		}
		else if (($access_cs == "cdefgijmn") and ($_POST['luni'] == "6luna"))
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4 * "6";
		}
		else if (($access_cs == "abcdefghijklmnopqrstu") and ($_POST['luni'] == "6luna"))
		{
			$commanda5="SELECT * FROM preturi WHERE nume_produs = 'cs_owner'";
			$resultsa5 = mysql_query($commanda5);
			while($rowa5 = mysql_fetch_array($resultsa5))
			{
				$pret5 = $rowa5["pret"];
			}
			$plata = $pret5 * "6";
		}
		else if (($access_cs == "bcefij") and ($_POST['luni'] == "6luna"))
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2 * "6";
		}
		else if (($access_cs == "bcdefijm")  and ($_POST['luni'] == "6luna"))
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3 * "6";
		}
		else if (($access_cs == "bcdefgijmn")  and ($_POST['luni'] == "6luna"))
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4 * "6";
		}
		
		if (($access_cs == "b") and ($_POST['luni'] == "12luna"))
		{
			$commanda="SELECT * FROM preturi WHERE nume_produs = 'cs_slot'";
			$resultsa = mysql_query($commanda);
			while($rowa = mysql_fetch_array($resultsa))
			{
				$pret = $rowa["pret"];
			}
			$plata = $pret * "12";
		}
		else if (($access_cs == "cefij") and ($_POST['luni'] == "12luna"))
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2 * "12";
		}
		else if (($access_cs == "cdefijm") and ($_POST['luni'] == "12luna"))
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3 * "12";
		}
		else if (($access_cs == "cdefgijmn") and ($_POST['luni'] == "12luna"))
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4 * "12";
		}
		else if (($access_cs == "abcdefghijklmnopqrstu") and ($_POST['luni'] == "12luna"))
		{
			$commanda5="SELECT * FROM preturi WHERE nume_produs = 'cs_owner'";
			$resultsa5 = mysql_query($commanda5);
			while($rowa5 = mysql_fetch_array($resultsa5))
			{
				$pret5 = $rowa5["pret"];
			}
			$plata = $pret5 * "12";
		}
		else if (($access_cs == "bcefij") and ($_POST['luni'] == "12luna"))
		{
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'cs_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$plata = $pret2 * "12";
		}
		else if (($access_cs == "bcdefijm")  and ($_POST['luni'] == "12luna"))
		{
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'cs_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$plata = $pret3 * "12";
		}
		else if (($access_cs == "bcdefgijmn")  and ($_POST['luni'] == "12luna"))
		{
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'cs_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$plata = $pret4 * "12";
		}
		
		if($_POST['Prelungeste']=='Prelungeste')
		{
			if ($balanta >= $plata)
			{
				if ($_POST['luni'] == "1luna")
				{
					$expiry = date("Y-m-d", strtotime("+1 Month", strtotime($expira_cs)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit gradul pe cs.infectati.ro cu o luna si a platit $plata','$admin',NOW())");
				}
				else if ($_POST['luni'] == "3luna")
				{
					$expiry = date("Y-m-d", strtotime("+3 Month", strtotime($expira_cs)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit gradul pe cs.infectati.ro 3 luni si a platit $plata','$admin',NOW())");
				}
				else if ($_POST['luni'] == "6luna")
				{
					$expiry = date("Y-m-d", strtotime("+6 Month", strtotime($expira_cs)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit gradul pe cs.infectati.ro 6 luni si a platit $plata','$admin',NOW())");
				}
				else if ($_POST['luni'] == "12luna")
				{
					$expiry = date("Y-m-d", strtotime("+12 Month", strtotime($expira_cs)));
					mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a prelungit gradul pe cs.infectati.ro un an si a platit $plata','$admin',NOW())");
				}	
				$balanta = ($balanta - $plata);
				mysql_query("	UPDATE tz_members
						SET				
							balanta = '$balanta',
							cs_expira_access = '$expiry'
						WHERE id = '{$_SESSION['id']}'");
				header("Location: success2.php");
			}
			else
				header("Location: insuficient.php");
		}			
		
		?>
		<h1>Prelungire Admin</h1><br>
		<form name="prelungire" action="" method="post">
			<h3>Prelungire: <select name="luni" onchange="this.form.submit();">
				<option <?php if ($_POST['luni'] == "1luna") { ?> selected <?php } ?> value="1luna">O Luna</option>
				<option <?php if ($_POST['luni'] == "3luna") { ?> selected <?php } ?> value="3luna">3 Luni</option>
				<option <?php if ($_POST['luni'] == "6luna") { ?> selected <?php } ?> value="6luna">6 Luni</option>
				<option <?php if ($_POST['luni'] == "12luna") { ?> selected <?php } ?> value="12luna">Un An</option>
			</select></h3><br>
			<h1>Total Plata: <?php echo $plata; echo ' Euro' ?></h1>
			<input type="submit" name="Prelungeste" value="Prelungeste" class="buton_albastru"/>
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
