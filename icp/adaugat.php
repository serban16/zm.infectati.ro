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
			$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results2 = mysql_query($command2);
			while($row2 = mysql_fetch_array($results2))
			{
				$auth = $row2['auth'];
				$admin = $row2['admin'];
			}
			require 'meniu.php'; 
		?>
        
        <div class="container">
		<?php
		
	// Escape the input data
		
		
	mysql_query("	UPDATE tz_members
					SET				
						balanta = '".$_POST['casuta3']."'
								
					WHERE auth LIKE '{$_POST['casuta2']}'");
		
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth i-a setat lui {$_POST['casuta2']} ".$_POST['casuta3']." Euro','$admin',NOW())");
		?>
		
		<h1><?php echo 'I-ai setat lui '; echo $_POST['casuta2']; echo ' '; echo $_POST['casuta3']; echo ' Euro.'; ?></h1><br>
		
		
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
