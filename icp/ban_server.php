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
		<h1>Baneaza/Debaneaza un Jucator</h1><br>
		<form name="form1" method="post" action="ban_server2.php">
			<h3>Cauta Utilizator: <input type="text" name="casuta" />
			<input type="submit" name="submit" value="Cauta" class="buton_albastru" /></h3>
		</form>
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
