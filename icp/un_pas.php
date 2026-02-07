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
		$command2="SELECT * FROM tz_members WHERE id = '{$_SESSION['id']}'";
		$results2 = mysql_query($command2);
		while($row2 = mysql_fetch_array($results2))
		{
		$auth = $row2['auth'];
		$admin = $row2['admin'];
		$nume = $row2["nume"];
		$oras = $row2["oras"];
		$adresa = $row2["adresa"];
		$telefon = $row2["telefon"];
		$activat = $row2["activat"];
		}
		if($_SESSION['id'] and ($activat !== "da"))
		{ 
			require 'meniu.php'; 
		?>
        
        <div class="container">
		<h1>Inca un Pas si contul tau poate fi utilizat</h1><br>
        <?php
		if($_POST['submit']=='Salveaza')
		{
			if (!$_POST['nume'])
			{
				?>
				<div class="error">Eroare: Nu ai completat campul Nume si Prenume.</div>
				<?php
				$eroare = "da";				
			}
			if($_POST['judet']=='neselectat')
			{
				?>
				<div class="error">Eroare: Nu ai ai selectat Judetul.</div>
				<?php	
				$eroare = "da";		
			}
			if (!$_POST['oras'])
			{
				?>
				<div class="error">Eroare: Nu ai completat campul Oras.</div>
				<?php	
				$eroare = "da";						
			}			if (!$_POST['telefon'])			{				?>				<div class="error">Eroare: Nu ai completat campul Telefon.</div>				<?php					$eroare = "da";									}
			if (!preg_match('/^[0-9]*$/',$_POST['telefon']))
			{
				?>
				<div class="error">Eroare: Caseta telefon trebuie sa contina doar cifre.</div>
				<?php
				$eroare = "da";
			}			if (strlen($_POST['telefon']) !== 10)			{				?>				<div class="error">Eroare: Numar de telefon invalid.</div>				<?php				$eroare = "da";			}
	if ($eroare !== "da")
	{
		mysql_query("	UPDATE tz_members
					SET	
						nume = '".$_POST['nume']."',
						oras = '".$_POST['oras']."',
						judet = '".$_POST['judet']."',
						
						activat = 'da',
						
						telefon =	'".$_POST['telefon']."'
								
					WHERE id = '{$_SESSION['id']}'");
		print "<div class=\"success\">Datele tale au fost salvate. Redirectionare...<meta http-equiv=\"refresh\" content=\"5; url=http://icp.infectati.ro/cont.php\"></div>";
	}
	
	}
		?>
		<form name="scoala" action="" method="post">	
			<div class="info">Info: Va rugam sa introduceti datele dvs. reale.</div><br>
			<h3>Nume si Prenume:  <input type="text" name="nume" value="<?php echo $nume; ?>"><br></h3>
			<h3>Judet/Provincie: <select name="judet">
				<option value="neselectat">Neselectat</option>
				<option value="Alba">Alba</option>
				<option value="Arad">Arad</option>
				<option value="Arges">Arges</option>
				<option value="Bacau">Bacau</option>
				<option value="Bihor">Bihor</option>
				<option value="Bistrita-Nasaud">Bistrita-Nasaud</option>
				<option value="Botosani">Botosani</option>
				<option value="Brasov">Brasov</option>
				<option value="Bucuresti">Bucuresti</option>
				<option value="Braila">Braila</option>
				<option value="Buzau">Buzau</option>
				<option value="Calarasi">Calarasi</option>
				<option value="Caras-Severin">Caras-Severin</option>
				<option value="Cluj">Cluj</option>
				<option value="Constanta">Constanta</option>
				<option value="Covasna">Covasna</option>
				<option value="Dambovita">Dambovita</option>
				<option value="Dolj">Dolj</option>
				<option value="Galati">Galati</option>
				<option value="Giurgiu">Giurgiu</option>
				<option value="Gorj">Gorj</option>
				<option value="Harghita">Harghita</option>
				<option value="Hunedoara">Hunedoara</option>
				<option value="Ialomita">Ialomita</option>
				<option value="Iasi">Iasi</option>
				<option value="Ilfov">Ilfov</option>
				<option value="Maramures">Maramures</option>
				<option value="Mehedinti">Mehedinti</option>
				<option value="Mures">Mures</option>
				<option value="Neamt">Neamt</option>
				<option value="Olt">Olt</option>
				<option value="Prahova">Prahova</option>
				<option value="Satu Mare">Satu Mare</option>
				<option value="Salaj">Salaj</option>
				<option value="Sibiu">Sibiu</option>
				<option value="Suceava">Suceava</option>
				<option value="Teleorman">Teleorman</option>
				<option value="Timis">Timiș</option>
				<option value="Tulcea">Tulcea</option>
				<option value="Vaslui">Vaslui</option>
				<option value="Valcea">Valcea</option>
				<option value="Vrancea">Vrancea</option>
			</select>

			<h3>Oras:  <input type="text" name="oras" value="<?php echo $oras; ?>"><br></h3>
			<h3>Telefon:  <input class="field" type="text" name="telefon" id="telefon" value="<?php echo $telefon; ?>"><br></h3>
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
<html>
      <div class="container tutorial-info">
      <center>Copyright 2012-2014 - Toate drepturile rezervate - Powered by <a href="http://www.infectati.ro/contact.php"><font color="#d10000">Echipa Infectatilor</font></a></center>
	  </div>
</html>
        </div>
</div>
</body>
</html>
