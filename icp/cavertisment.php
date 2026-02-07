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
			if (($adminu == "da") or ($adminu == "avertisment"))
			{
			require 'meniu.php'; 
		?>
        
        <div class="container">
		<h1>Adauga avertismente unui Utilizator</h1><br>
		<form name="form1" method="post" action="avertisment.php">
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