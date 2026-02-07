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
		<h1>Tabel Utilizatori</h1>
		<table cellspacing="0">
		<tr><th>Nume Utilizator</th><th>Editeaza</th></tr>
		<?php
			$command1611="SELECT * FROM tz_members ORDER BY ID";
			$results1611 = mysql_query($command1611);
			while($row1611 = mysql_fetch_array($results1611))
			{
		?>
			<tr><th><?php echo $row1611['auth']; ?> <form name="form1" method="post" action="scontedit.php"><input type="text" name="casuta" value="<?php echo $row1611['auth']; ?>" style="display: none" /></th><th><input type="submit" name="submit" value="Editeaza" class="buton_albastru" /></form></th></tr>

			<?php
			}
			?>
			</table>
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
