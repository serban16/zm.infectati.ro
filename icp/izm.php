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
        <h1>Zm.Infectati.ro</h1>
        <h2>Infect Control Panel</h2>
        </div>
		
		<?php if($_SESSION['id'])
		{ 
			require 'meniu.php'; 
		?>
        
        <div class="container">
        <?php
		$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
		$results2 = mysql_query($command2);
		while($row2 = mysql_fetch_array($results2))
		{
		$zm_rank = $row2["zm_rank"];
		$zm_kills = $row2["zm_kills"];
		$zm_deaths = $row2["zm_deaths"];
		$zm_access = $row2["access_zm"];
		$zm_access_vip = $row2["access_zm_vip"];
		$zm_access_banca = $row2["access_zm_bank"];
		$expira_cs = $row2["expira_cs"];
		$zm_expira_vip = $row2["zm_expira_vip"];
		$zm_expira_access = $row2["zm_expira_access"];
		$zm_expira_banca = $row2["zm_expira_banca"];
		
		$avertisment_zm = $row2["avertisment_zm"];
		$avertisment_zm_vip = $row2["avertisment_zm_vip"];
		}
		$command223 = mysql_query("SELECT * FROM zp_bank WHERE auth = '{$_SESSION['auth']}'");
		$results223 = mysql_fetch_assoc($command223);

		$banca = $results223["cantitate"];

		
		if (($zm_access == "z") or ($zm_access == "x"))
		{
			$zm_access = "Nume rezervat";
		}
		else if (($zm_access == "b") or ($zm_access == "bx"))
		{
			$zm_access = "Slot";
		}
		else if (($zm_access == "cefij") or ($zm_access == "cefijx"))
		{
			$zm_access = "Mini-Admin";
		}
		else if (($zm_access == "cdefijm") or ($zm_access == "cdefijmx"))
		{
			$zm_access = "Co-Administrator";
		}
		else if (($zm_access == "cdefgijmn") or ($zm_access == "cdefgijmnx"))
		{
			$zm_access = "Administrator";
		}
		else if (($zm_access == "abcdefghijklmnopqrstu") or ($zm_access == "abcdefghijklmnopqrstux"))
		{
			$zm_access = "Owner";
		}	
		else if (($zm_access == "bcefij") or ($zm_access == "bcefijx"))
		{
			$zm_access = "Mini-Admin";
		}
		else if (($zm_access == "bcdefijm") or ($zm_access == "bcdefijmx"))
		{
			$zm_access = "Co-Administrator";
		}
		else if (($zm_access == "bcdefgijmn") or ($zm_access == "bcdefgijmnx"))
		{
			$zm_access = "Administrator";
		}
		else if (($zm_access == "abcdefghijklmnopqrstu") or ($zm_access == "abcdefghijklmnopqrstux"))
		{
			$zm_access = "Owner";
		}
		
		if (($zm_access_banca == "abcde") or ($zm_access_banca == "abcd"))
		{
			$zm_access_banca = "2500";
		}
		else if ($zm_access_banca == "abc")
		{
			$zm_access_banca = "2000";
		}
		else if ($zm_access_banca == "ab")
		{
			$zm_access_banca = "1500";
		}
		else if ($zm_access_banca == "a")
		{
			$zm_access_banca = "1000";
		}
		else 
			$zm_access_banca = "500";
				$zm_expira_access = DateTime::createFromFormat('Y-m-d', $zm_expira_access);		$zm_expira_access = $zm_expira_access->format('d-m-Y');				$zm_expira_vip = DateTime::createFromFormat('Y-m-d', $zm_expira_vip);		$zm_expira_vip = $zm_expira_vip->format('d-m-Y');		$zm_expira_banca = DateTime::createFromFormat('Y-m-d', $zm_expira_banca);		$zm_expira_banca = $zm_expira_banca->format('d-m-Y');
		
		if ($zm_expira_vip == "01-01-3000")
			$zm_expira_vip = "Nu ai VIP sau este permanent";
			
		if ($zm_expira_access == "01-01-3000")
			$zm_expira_access = "Permanent";
			
		if ($zm_expira_banca == "01-01-3000")
			$zm_expira_banca = "Nu ai cont bancar marit sau este permanent";
		
		if ($zm_access == "Nume rezervat")
			$zm_expira_access = "Permenent";
		
		if ($zm_access_vip == "abcde")
		{
			$zm_access_vip = "Da";
		}
		else
			$zm_access_vip = "Nu";
		?>
			<h1>Nume server:<font color="#d10000"> <?php echo $_SESSION['auth']; ?></font></h1>
			<h1>Pozitie Rank: <?php if ($zm_rank !== ""){  ?> <font color="#d10000">Locul <?php echo $zm_rank; ?></font> cu <font color="#d10000"><?php echo $zm_kills; ?> </font>omorari si <font color="#d10000"><?php echo $zm_deaths; ?></font> decese.</font><?php } else { ?><font color="#d10000">Nu ai intrat inca pe server</font> <?php } ?></h1>
			<h1><form method="link" action="doneaza_banca.php">Cont Banca:<?php if ($banca !== ""){  ?><font color="#d10000"> <?php echo $banca; ?></font> Euro din <font color="#d10000"> <?php echo $zm_access_banca; ?></font> Euro <input type="submit" name="submit5" value="Doneaza" class="buton_albastru" /> <?php } else { ?><font color="#d10000"> Nu ai intrat inca pe server</font> <?php } ?></form></h1>
			<h1>Grad Admin:<font color="#d10000"> <?php echo $zm_access; ?></font></h1>
			<h1>Grad VIP:<font color="#d10000"> <?php echo $zm_access_vip; ?></font></h1>
			<h1>Data Expirarii Admin-ului:<font color="#d10000"> <?php echo $zm_expira_access; ?></font> <?php if ($zm_expira_access < "3000-01-01") { ?> <form method="link" action="prelungire_zm_admin.php"><input type="submit" name="submit1" value="Prelungeste Admin" class="buton_albastru" /></form></h1> <?php } ?>
			<h1>Data Expirarii VIP-ului:<font color="#d10000"> <?php echo $zm_expira_vip; ?></font> <?php if ($zm_expira_vip < "3000-01-01") { ?> <form method="link" action="prelungire_zm_vip.php"><input type="submit" name="submit2" value="Prelungeste VIP" class="buton_albastru" /></form></h1> <?php } ?>
			<h1>Data Expirarii Contului Bancar:<font color="#d10000"> <?php echo $zm_expira_banca; ?></font> <?php if ($zm_expira_banca < "3000-01-01") { ?> <form method="link" action="prelungire_zm_banca.php"><input type="submit" name="submit3" value="Prelungeste Banca" class="buton_albastru" /></form></h1> <?php } ?><br>
			<?php 
			if ($zm_access !== "Nume rezervat")
			{
			?>
				<h1>Avertismente Admin:<font color="#d10000"> <?php echo $avertisment_zm; ?></font> din 3</h1>
			<?php
			}
			if ($zm_access_vip == "Da")
			{
			?>
				<h1>Avertismente VIP:<font color="#d10000"> <?php echo $avertisment_zm_vip; ?></font> din 3</h1>
			<?php
			}
			?>
			<br><h1>Statistici Server:</h1>
			<a href="http://infectati.ro/statistici/server.php?s=13"><img src="http://infectati.ro/statistici/lgsl_files/lgsl_image.php?s=13" /></a>
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
