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
			if($_SESSION['id'])
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
		}
		$cauta_sql2 = "SELECT * FROM zp_bank WHERE auth LIKE '".$_POST['casuta']."'";
		$cauta_query2 = mysql_query($cauta_sql2);
		while($row26 = mysql_fetch_array($cauta_query2))
		{
			$cantitate = $row26["cantitate"];
		}
		$cauta_sql3 = "SELECT * FROM zp_bank WHERE auth = '{$_SESSION['auth']}'";
		$cauta_query3 = mysql_query($cauta_sql3);
		while($row266 = mysql_fetch_array($cauta_query3))
		{
			$cantitate2 = $row266["cantitate"];
		}

		?>
		
		<h1>Editeza Utilizator</h1><br>
		
		<form name="form2" method="post"  action="doneaza_banca3.php">
			<input type="text" name="casa" value="<?php echo $rezultat; ?>" style="display: none" />
			<input type="text" name="casa2" value="<?php echo $cantitate; ?>" style="display: none" />
			<input type="text" name="casa3" value="<?php echo $cantitate2; ?>" style="display: none" />
			<h3>Detii in contul tau bancar <?php echo $cantitate2; ?> Euro </h3><br>
			<h3>Trimite-i lui <font color="#d10000"><?php echo $rezultat; ?></font>  <input type="text" name="euro" value="0"> Euro<br></h3><br>
			
			<input type="submit" name="submit2" value="Doneaza" class="buton_albastru" />
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