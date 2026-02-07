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
        <h1>Contul Meu</h1>
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
		$email = $row2["email"];
		$balanta = $row2["balanta"];
		$nume = $row2["nume"];
		$oras = $row2["oras"];
		$judet = $row2["judet"];
		$telefon = $row2["telefon"];
		}
		if ($_POST['submit1']=='Sterge')
		{
			mysql_query("DELETE FROM donatie WHERE rezultat = 'corect' AND id_real = '{$_SESSION['id']}'");
			header("Location: mesaj_sters.php");
		}
		if ($_POST['submit2']=='Sterge')
		{
			mysql_query("DELETE FROM donatie WHERE rezultat = 'corect' AND id_real = '{$_SESSION['id']}'");
			header("Location: mesaj_sters.php");
		}
		if ($_POST['submit3']=='Sterge')
		{
			mysql_query("DELETE FROM donatie WHERE rezultat = 'gresit' AND id_real = '{$_SESSION['id']}'");
			header("Location: mesaj_sters.php");
		}
		if ($_POST['submit4']=='Sterge')
		{
			mysql_query("DELETE FROM donatie WHERE rezultat = 'gresit' AND id_real = '{$_SESSION['id']}'");
			header("Location: mesaj_sters.php");
		}
		$total_donatii2 = mysql_query("SELECT * FROM donatie WHERE rezultat = 'asteptare' AND id_real = '{$_SESSION['id']}'");
		if (mysql_num_rows($total_donatii2) == 1) {
		?>
		<div class="warning">Cererea ta de adaugare fonduri este inca in asteptare. Vei fi contactat in scurt timp.</div>
		<?php
		}
		if (mysql_num_rows($total_donatii2) > 1) {
		?>
		<div class="warning">Cererile tale de adaugare fonduri sunt inca in asteptare. Vei fi contactat in scurt timp.</div>
		<?php
		}
		$total_donatii3 = mysql_query("SELECT * FROM donatie WHERE rezultat = 'corect' AND id_real = '{$_SESSION['id']}'");
		if (mysql_num_rows($total_donatii3) == 1) {
		?>
		<div class="success"><form name="form1" method="post" action="">Cererea ta de adaugare fonduri a fost acceptata. <input type="submit" name="submit1" value="Sterge" class="buton_albastru" /></form></div>
		<?php
		}
		if (mysql_num_rows($total_donatii3) > 1) {
		?>
		<div class="success"><form name="form2" method="post" action="">Cererile tale de adaugare fonduri au fost acceptate. <input type="submit" name="submit2" value="Sterge" class="buton_albastru" /></form></div>
		<?php
		}
		$total_donatii3 = mysql_query("SELECT * FROM donatie WHERE rezultat = 'gresit' AND id_real = '{$_SESSION['id']}'");
		if (mysql_num_rows($total_donatii3) == 1) {
		?>
		<div class="error"><form name="form3" method="post" action="">Eroare: Cererea ta de adaugare fonduri a fost respinsa deoarece codul a fost gresit. <input type="submit" name="submit3" value="Sterge" class="buton_albastru" /></form></div>
		<?php
		}
		if (mysql_num_rows($total_donatii3) > 1) {
		?>
		<div class="error"><form name="form4" method="post" action=""> Eroare: Cererile tale de adaugare fonduri au fost respinse deoarece codurile au fost gresite. <input type="submit" name="submit4" value="Sterge" class="buton_albastru" /></form></div>
		<?php
		}
		?>
			<h1>Nume de Utilizator:<font color="#d10000"> <?php echo $_SESSION['auth']; ?></font></h1>
			<h1>Email:<font color="#d10000"> <?php echo $email; ?></font></h1>
			<h1>Nume si Prenume:<font color="#d10000"> <?php echo $nume; ?></font></h1>
			<h1>Judet:<font color="#d10000"> <?php echo $judet; ?></font></h1>
			<h1>Oras:<font color="#d10000"> <?php echo $oras; ?></font></h1>
			<h1>Telefon:<font color="#d10000"> <?php echo $telefon; ?></font></h1><br>
			<form name="form5" method="post" action="edit_pass.php"><input type="submit" name="submit5" value="Schimba Parola" class="buton_albastru" /></form><br>
			<br><h1>Balanta Credit:<font color="#d10000"> <?php echo $balanta; ?></font> Euro &nbsp;&nbsp;&nbsp;&nbsp; <a href="iaddfond.php">Adauga Fonduri</a></h1>
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