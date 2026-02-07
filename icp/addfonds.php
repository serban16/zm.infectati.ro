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
		<?php
		
		$cauta_sql = "SELECT * FROM tz_members WHERE auth LIKE '".$_POST['casuta']."'";
		$cauta_query = mysql_query($cauta_sql);
		if(mysql_num_rows($cauta_query) >= 1)
		{
		while($row2 = mysql_fetch_array($cauta_query))
		{
			$rezultat = $row2["auth"];
			$balanta2 = $row2["balanta"];
		}

		?>
		
		<h1><?php echo 'Editeaza balanta de credit lui '; echo $rezultat; ?></h1><br>
		
		<form name="form2" method="post"  action="adaugat.php">
			<input type="hidden" name="casuta2" value="<?php echo $rezultat; ?>" />
			<h3>Balanta Credit: <input type="text" name="casuta3" value="<?php echo $balanta2; ?>" /> Euro 
			<input type="submit" name="submit2" value="Adauga" class="buton_albastru" /></h3>
		</form>
		
		<?php
		}
		else
		{
		?>
		<h1>Nu a fost gasit nici un utilizator cu acest nume.</h1>
		<?php
		}
		?>
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