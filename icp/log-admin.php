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
			if ($adminu == "da")
			{
			require 'meniu.php';
			$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results2 = mysql_query($command2);
			while($row2 = mysql_fetch_array($results2))
			{
				$auth = $row2['auth'];
				$admin = $row2['admin'];
			}
		?>
        
        <div class="container">
		<h1>Statistici Cumparari Zm.infectati.ro</h1><br>
		<?php
			$command1611="SELECT * FROM tz_members ORDER BY id";
			$results1611 = mysql_query($command1611);
			while($row1611 = mysql_fetch_array($results1611))
			{
			if (($row1611['access_zm'] <> "z") or ($row1611['access_vip'] <> "") or ($row1611['access_bank'] <> ""))
			{
		$zm_access = $row1611['access_zm'];
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
		
		$zm_access_banca = $row1611['access_zm_bank'];
		if ($zm_access_banca == "abcde")
		{
			$zm_access_banca = "2500 + Give/Remove";
		}
		else if ($zm_access_banca == "abcd")
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
		
		$zm_access_vip = $row1611['access_zm_vip'];
		if ($zm_access_vip == "abcde")
		{
			$zm_access_vip = "Da";
		}
		else
			$zm_access_vip = "Nu";
		?><h3>Nume: <?php echo $row1611['auth'];?><br> Grad Admin: <?php echo $zm_access;?><br> Grad VIP: <?php echo $zm_access_vip?><br> Grad Banca: <?php echo $zm_access_banca;?> Euro<br><br></h3>
		<?php
			}
			}
			?>
			<br><h1>Statistici Cumparari Cs.infectati.ro</h1>
			<?php
			$command16112="SELECT * FROM tz_members ORDER BY id";
			$results16112 = mysql_query($command16112);
			while($row16112 = mysql_fetch_array($results16112))
			{
			if ($row16112['access_cs'] <> "z")
			{
		$access_cs = $row16112['access_cs'];
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
		}
		?><h3>Nume: <?php echo $row16112['auth'];?><br> Grad Admin: <?php echo $access_cs;?><br><br></h3>
		<?php
			}
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