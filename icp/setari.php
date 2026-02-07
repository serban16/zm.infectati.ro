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
			
			$command2="SELECT * FROM setari WHERE id = '1'";
			$results2 = mysql_query($command2);
			
			while($row2 = mysql_fetch_array($results2))
				$concurs = $row2["valuare"];
				
			$command26="SELECT * FROM setari WHERE id = '2'";
			$results26 = mysql_query($command26);
			
			while($row26 = mysql_fetch_array($results26))
				$link = $row26["valuare"];
			
			$command262="SELECT * FROM setari WHERE id = '3'";
			$results262 = mysql_query($command262);
			
			while($row262 = mysql_fetch_array($results262))
				$pari = $row262["valuare"];
			
			if($_POST['submit']=='Trimite')
			{
				if (isset($_POST['concurs']))
				{
					mysql_query("	UPDATE setari
						SET				
							valuare = 'da'
						WHERE id = '1'");
				}
				else
				{
					mysql_query("	UPDATE setari
						SET				
							valuare = 'nu'
						WHERE id = '1'");
				}
				
				if (isset($_POST['link']))
				{
					mysql_query("	UPDATE setari
						SET				
							valuare = 'da'
						WHERE id = '2'");
				}
				else
				{
					mysql_query("	UPDATE setari
						SET				
							valuare = 'nu'
						WHERE id = '2'");
				}
				if (isset($_POST['pari']))
				{
					mysql_query("	UPDATE setari
						SET				
							valuare = 'da'
						WHERE id = '3'");
				}
				else
				{
					mysql_query("	UPDATE setari
						SET				
							valuare = 'nu'
						WHERE id = '3'");
				}
				header("Location: setari_editate.php");
			}
		?>
        
        <div class="container">
		<h1>Setari Site</h1><br>
		<form name="form1" method="post" action="">
			<h3>Concurs + newsletter: <input type="checkbox" <?php if ($concurs == "da") { ?> checked <?php } ?> name="concurs" value="concurs"><h3><br>
			<h3>Link unic pe utilizator: <input type="checkbox" <?php if ($link == "da") { ?> checked <?php } ?>  name="link" value="link"></h3><br>
			<h3>Pariuri: <input type="checkbox" <?php if ($pari == "da") { ?> checked <?php } ?>  name="pari" value="pari"></h3><br>
			<input type="submit" name="submit" value="Trimite" class="buton_albastru" /></h3>
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
