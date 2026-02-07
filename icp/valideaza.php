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
			$command22="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
			$results22 = mysql_query($command22);
			while($row22 = mysql_fetch_array($results22))
			{
				$auth = $row22['auth'];
				$admin = $row22['admin'];
			}
		if ($_POST['submit2']=='Adauga')
		{
			mysql_query("	UPDATE tz_members
					SET				
						balanta = '".$_POST['casuta3']."'
								
					WHERE auth LIKE '{$_POST['casuta']}'");
			
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth a validat codul lui $rezultat si i-a adaugat ".$_POST['casuta3']." Euro','$admin',NOW())");
			mysql_query("UPDATE donatie SET rezultat = 'corect' WHERE cod LIKE '{$_POST['casuta_cod2']}'");
			header("Location: cod_corect.php");
		}
		if ($_POST['submit3']=='Incorect')
		{
			mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth a respins codul lui $rezultat','$admin',NOW())");
			mysql_query("UPDATE donatie SET rezultat = 'gresit' WHERE cod LIKE '{$_POST['casuta_cod2']}'");
			header("Location: cod_incorect.php");
		}
		?>
		
		<h1><?php echo 'Editeaza balanta de credit lui '; echo $rezultat; ?></h1><br>
		
		<form name="form2" method="post" action="">
			<input type="hidden" name="casuta" value="<?php echo $rezultat; ?>" />
			<input type="text" name="casuta_cod2" value="<?php echo $_POST['casuta_cod']; ?>" style="display: none" />
			<h3>Balanta Credit: <input type="text" name="casuta3" value="<?php echo $balanta2; ?>" /> Euro 
			<input type="submit" name="submit2" value="Adauga" class="buton_verde" />    <input type="submit" name="submit3" value="Incorect" class="buton_rosu" /></h3>
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