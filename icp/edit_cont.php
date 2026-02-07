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
		if($_POST['submit']=='Trimite')
		{
		if (!($_POST['password'] == $_POST['password2']))
		{
		
	?>
	<div class="error">Eroare: Prolele nu coincid.</div>
	
	<?php
			exit;
		}
	$_POST['password'] = mysql_real_escape_string($_POST['password']);
	$_POST['nume'] = mysql_real_escape_string($_POST['nume']);
	$_POST['adresa'] = mysql_real_escape_string($_POST['adresa']);
	$_POST['oras'] = mysql_real_escape_string($_POST['oras']);
	$_POST['telefon'] = mysql_real_escape_string($_POST['telefon']);
	// Escape the input data
		
		
	mysql_query("	UPDATE tz_members
					SET				
						password = '".$_POST['password']."',
						nume = 	'".$_POST['nume']."',
						adresa =	'".$_POST['adresa']."',
						oras =	'".$_POST['oras']."',
						telefon =	'".$_POST['telefon']."'
								
					WHERE id = '{$_SESSION['id']}'");
			
	if (($_POST['password'] == $_POST['password2']))
	{
	mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth si-a editat datele de contact','$admin',NOW())");
	?>
	<div class="success">Datele tale au fost editate.</div>
	
	<?php
	}
	}
}
		?>
		<form action="" method="post">
			<h3>Nume de Utilizator:  <input disabled=true type="text" name="auth" value="<?php echo $_SESSION['auth']; ?>"><br></h3>
			<h3>Email:  <input disabled=true type="text" name="email" value="<?php echo $email; ?>"><br></h3>
			
			<h3>Parola: <input type="password" name="password" value="<?php echo $parola; ?>"><br></h3>
			<h3>Rescrie Parola: <input type="password" name="password2" value="<?php echo $parola; ?>"><br></h3>
			
			
			<h3>Nume si Prenume:  <input type="text" name="nume" value="<?php echo $nume; ?>"><br></h3>
			<h3>Oras:  <input type="text" name="oras" value="<?php echo $oras; ?>"><br></h3>
			<h3>Adresa:  <input type="text" name="adresa" value="<?php echo $adresa; ?>"><br></h3>
			<h3>Telefon:  <input class="field" type="text" name="telefon" id="telefon" value="<?php echo $telefon; ?>"><br></h3>
			<input type="submit" name="submit" value="Trimite" class="buton_albastru" />
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
