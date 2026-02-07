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
        <h1>Editeaza Cont</h1>
        <h2>Infect Control Panel</h2>
        </div>
		
		<?php if($_SESSION['id'])
		{ 
			require 'meniu.php'; 
		?>
        
        <div class="container">
        <?php
		$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
		$results2 = mysql_query($command2);
		while($row2 = mysql_fetch_array($results2))
		{
		$auth = $row2['auth'];
		$admin = $row2['admin'];
		$email = $row2["email"];
		$balanta = $row2["balanta"];
		$nume = $row2["nume"];
		$oras = $row2["oras"];
		$adresa = $row2["adresa"];
		$telefon = $row2["telefon"];
		$parola = $row2["password"];
		}
		if($_POST['submit']=='Salveaza')
		{
			if ($_POST['password'] !== $_POST['password2'])
			{
				?>
				<div class="error">Eroare: Parolele nu coincid.</div>
				<?php
				$eroare = "da";
			}
			if ($parola !== $_POST['password3'])
			{
				?>	
				<div class="error">Eroare: Parola veche nu este corecta.</div>
				<?php
				$eroare = "da";		
			}
	if($eroare !== "da")
	{
	mysql_query("	UPDATE tz_members
					SET				
						password = '".$_POST['password']."'
								
					WHERE id = '{$_SESSION['id']}'");
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a schimbat parola','$admin',NOW())");
		?>
	<div class="success">Parola ta a fost editata.</div>
	
	<?php
	}
	}
		?>
		<h1>Schimba Parola</h1><br>
		<form action="" method="post">
			
			<h3>Parola Veche: <input type="password" name="password3" value=""><br></h3>
			<h3>Parola Noua: <input type="password" name="password" value=""><br></h3>
			<h3>Rescrie Parola: <input type="password" name="password2" value=""><br></h3>
			
			<br><input type="submit" name="submit" value="Salveaza" class="buton_albastru" />
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
