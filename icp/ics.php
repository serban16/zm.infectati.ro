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
        <h1>Cs.infectati.ro</h1>
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
		$cs_rank = $row2["cs_rank"];
		$cs_kills = $row2["cs_kills"];
		$cs_deaths = $row2["cs_deaths"];
		$access_cs = $row2["access_cs"];
		$expira_cs = $row2["cs_expira_access"];
		$avertisment_cs = $row2["avertisment_cs"];
		}
		if ($access_cs == "z")
		{
			$access_cs = "Nume rezervat";
		}
		else if ($access_cs == "b")
		{
			$access_cs = "Slot";
		}
		else if ($access_cs == "cefij")
		{
			$access_cs = "Mini-Admin";
		}
		else if ($access_cs == "cdefijm")
		{
			$access_cs = "Co-Administrator";
		}
		else if ($access_cs == "cdefgijmn")
		{
			$access_cs = "Administrator";
		}
		else if ($access_cs == "abcdefghijklmnopqrstu")
		{
			$access_cs = "Owner";
		}
		else if ($access_cs == "bcefij")
		{
			$access_cs = "Mini-Admin";
		}
		else if ($access_cs == "bcdefijm")
		{
			$access_cs = "Co-Administrator";
		}
		else if ($access_cs == "bcdefgijmn")
		{
			$access_cs = "Administrator";
		}		$expira_cs = DateTime::createFromFormat('Y-m-d', $expira_cs);		$expira_cs = $expira_cs->format('d-m-Y');
		if ($expira_cs == "01-01-3000")
			$expira_cs = "Permanent";
		?>
			<h1>Nume server:<font color="#d10000"> <?php echo $_SESSION['auth']; ?></font></h1>
			<h1>Pozitie Rank: <?php if ($cs_rank !== ""){  ?> <font color="#d10000">Locul <?php echo $cs_rank; ?></font> cu <font color="#d10000"><?php echo $cs_kills; ?> </font>omorari si <font color="#d10000"><?php echo $cs_deaths; ?></font> decese.</font><?php } else { ?><font color="#d10000">Nu ai intrat inca pe server</font> <?php } ?></h1>
			<h1>Grad Server:<font color="#d10000"> <?php echo $access_cs; ?></font></h1>
			<h1><form name="form1" method="post" action="prelungire_cs_admin.php">Data Expirarii Gradului:<font color="#d10000"> <?php echo $expira_cs; ?></font><?php if ($expira_cs < "3000-01-01") { ?> <input type="submit" name="admin_cs" value="Prelungeste Admin" class="buton_albastru" /></form> <?php } ?></h1><br>
		<?php
			if ($access_cs !== "Nume rezervat")
			{
			?>
				<h1>Avertismente Admin:<font color="#d10000"> <?php echo $avertisment_cs; ?></font> din 3</h1>
			<?php
			}
			?>
			<br><h1>Statistici Server:</h1>
			<a href="http://infectati.ro/statistici/server.php?s=14"><img src="http://infectati.ro/statistici/lgsl_files/lgsl_image.php?s=14" /></a>
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

