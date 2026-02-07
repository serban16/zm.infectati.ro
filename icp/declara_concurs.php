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
			
			$command256="SELECT * FROM setari WHERE id = '1'";
			$results256 = mysql_query($command256);
			
			while($row256 = mysql_fetch_array($results256))
				$concurs = $row256["valuare"];
			if (($concurs == "da") and ($adminu == "da"))
			{
			require 'meniu.php';
			
			if($_POST['submit']=='Trimite')
			{
			$command161="SELECT * FROM tz_members WHERE concurs='da' and admin <>'da' ORDER BY RAND() ";
			$results161 = mysql_query($command161);
			while($row161 = mysql_fetch_array($results161))
			{
				$castigator = $row161["auth"];
				$grad = $row161["access_zm_vip"];
				$expira_vip = $row161["zm_expira_vip"];
				$zm_access = $row161["access_zm"];
			}
			if ($grad == "abcde")
				$expiry = date("Y-m-d", strtotime("+1 Month", strtotime($expira_vip)));
			else
				$expiry = date("Y-m-d", time() + 3*24*60*60 );
				
			if (($zm_access == "z") or ($zm_access == "x"))
					{
							$zm_access = "x";
						}
						else if (($zm_access == "b") or ($zm_access == "bx"))
						{
							$zm_access = "bx";
						}
						else if (($zm_access == "cefij") or ($zm_access == "cefijx"))
						{
							$zm_access = "cefijx";
						}
						else if (($zm_access == "cdefijm") or ($zm_access == "cdefijmx"))
						{
							$zm_access = "cdefijmx";
						}
						else if (($zm_access == "cdefgijmn") or ($zm_access == "cdefgijmnx"))
						{
							$zm_access = "cdefgijmnx";
						}
						else if (($zm_access == "abcdefghijklmnopqrstu") or ($zm_access == "abcdefghijklmnopqrstux"))
						{
							$zm_access = "abcdefghijklmnopqrstux";
						}
						else if (($zm_access == "bcefij") or ($zm_access == "bcefijx"))
						{
							$zm_access = "bcefijx";
						}
						else if (($zm_access == "bcdefijm") or ($zm_access == "bcdefijmx"))
						{
							$zm_access = "bcdefijmx";
						}
						else if (($zm_access == "bcdefgijmn") or ($zm_access == "bcdefgijmnx"))
						{
							$zm_access = "bcdefgijmnx";
						}
						
				mysql_query("	UPDATE tz_members
						SET				
							access_zm_vip = 'abcde',
							access_zm = '$zm_access',
							zm_expira_vip = '$expiry',
							zm_expira_access = '$expiry'
						WHERE auth = '$castigator'");
			}
		?>
        
        <div class="container">
		<h1>Email-uri participante:</h1><br>
		<?php
			$command1611="SELECT * FROM tz_members WHERE concurs='da' ORDER BY ID";
			$results1611 = mysql_query($command1611);
			while($row1611 = mysql_fetch_array($results1611))
			{
			echo "<<td>" . $row1611['email'] . "</td>>,";
			}

		?>
		<br>
		<form name="form1" method="post" action="">

			<input type="submit" name="submit" value="Trimite" class="buton_albastru" /></h3>
		</form>
		
		
		<?php
		if($_POST['submit']=='Trimite')
		{
			$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results2 = mysql_query($command2);
			while($row2 = mysql_fetch_array($results2))
			{
				$auth = $row2['auth'];
				$admin = $row2['admin'];
			}
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth la desemnat pe $castigator ca fiind castigator','$admin',NOW())");
		?>
		<h3>Castigatorul de saptamana aceasta este <?php echo $castigator; ?></h3>
		<?php
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
