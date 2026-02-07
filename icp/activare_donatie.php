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
		?>
        
        <div class="container">
		<h1>Activare donatie</h1><br>
		<?php
			$command1611="SELECT * FROM donatie WHERE rezultat = 'asteptare' ORDER BY id ";
			$results1611 = mysql_query($command1611);
			while($row1611 = mysql_fetch_array($results1611))
			{
			$cod = $row1611['cod'];
		?><form name="form1" method="post" action="valideaza.php"><h3>Nume utilizator:<font color="#d10000"> <?php echo $row1611['auth']; ?> </font><input type="text" name="casuta" value="<?php echo $row1611['auth']; ?>" style="display: none" /></h3>
		  <h3>Retea:<font color="#d10000"> <?php echo $row1611['retea']; ?></font></h3>
		  <h3>Cod Cartela Reincarcabila:<font color="#d10000"> <?php echo $row1611['cod']; ?></font><input type="text" name="casuta_cod" value="<?php echo $row1611['cod']; ?>" style="display: none" /></h3>
		  <input type="submit" name="submit" value="Valideaza" class="buton_albastru" /></form><br><br>
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
