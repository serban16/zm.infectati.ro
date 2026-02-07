<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="style/tabel_bilet_pariu.css"/>
<link rel="stylesheet" type="text/css" href="style/slide.css"/>

</head>
<body>

		<?php
		define('INCLUDE_CHECK',true);

		require 'connect.php';
		
  			$command256="SELECT * FROM setari WHERE id = '3'";
			$results256 = mysql_query($command256);
			
			while($row256 = mysql_fetch_array($results256))
				$link = $row256["valuare"];
			if ($link == "da") 
			{ 
		
		$user = $_GET['user'];
		$pass = $_GET['pass'];
	
	
		$cauta_sql32 = "SELECT * FROM bilete WHERE nr_bilet= '".$_POST['biletnr']."'";
		$cauta_query32 = mysql_query($cauta_sql32);
		if(mysql_num_rows($cauta_query32) >= 1)
		{
		
		$command1 = mysql_query("SELECT * FROM pari_edit WHERE id = '1'");
		$results1 = mysql_fetch_assoc($command1);
		$command2 = mysql_query("SELECT * FROM pari_edit WHERE id = '2'");
		$results2 = mysql_fetch_assoc($command2);
		$command3 = mysql_query("SELECT * FROM pari_edit WHERE id = '3'");
		$results3 = mysql_fetch_assoc($command3);
		$command4 = mysql_query("SELECT * FROM pari_edit WHERE id = '4'");
		$results4 = mysql_fetch_assoc($command4);
		$command5 = mysql_query("SELECT * FROM pari_edit WHERE id = '5'");
		$results5 = mysql_fetch_assoc($command5);
		$command6 = mysql_query("SELECT * FROM pari_edit WHERE id = '6'");
		$results6 = mysql_fetch_assoc($command6);
		$command7 = mysql_query("SELECT * FROM pari_edit WHERE id = '7'");
		$results7 = mysql_fetch_assoc($command7);
		$command8 = mysql_query("SELECT * FROM pari_edit WHERE id = '8'");
		$results8 = mysql_fetch_assoc($command8);
		$command9 = mysql_query("SELECT * FROM pari_edit WHERE id = '9'");
		$results9 = mysql_fetch_assoc($command9);
		$command10 = mysql_query("SELECT * FROM pari_edit WHERE id = '10'");
		$results10 = mysql_fetch_assoc($command10);
		$command11 = mysql_query("SELECT * FROM pari_edit WHERE id = '11'");
		$results11 = mysql_fetch_assoc($command11);
		$command12 = mysql_query("SELECT * FROM pari_edit WHERE id = '12'");
		$results12 = mysql_fetch_assoc($command12);
		$command13 = mysql_query("SELECT * FROM pari_edit WHERE id = '13'");
		$results13 = mysql_fetch_assoc($command13);
		$command14 = mysql_query("SELECT * FROM pari_edit WHERE id = '14'");
		$results14 = mysql_fetch_assoc($command14);
		$command15 = mysql_query("SELECT * FROM pari_edit WHERE id = '15'");
		$results15 = mysql_fetch_assoc($command15);
		
		while($row2 = mysql_fetch_array($cauta_query32))
		{
			$id_meci1 = $row2["id_meci1"];
			$id_meci2 = $row2["id_meci2"];
			$id_meci3 = $row2["id_meci3"];
			$id_meci4 = $row2["id_meci4"];
			$id_meci5 = $row2["id_meci5"];
			$id_meci6 = $row2["id_meci6"];
			$id_meci7 = $row2["id_meci7"];
			$id_meci8 = $row2["id_meci8"];
			$id_meci9 = $row2["id_meci9"];
			$id_meci10 = $row2["id_meci10"];
			$id_meci11 = $row2["id_meci11"];
			$id_meci12 = $row2["id_meci12"];
			$id_meci13 = $row2["id_meci13"];
			$id_meci14 = $row2["id_meci14"];
			$id_meci15 = $row2["id_meci15"];
		
			$cota1 = $row2["cota1"];
			$cota2 = $row2["cota2"];
			$cota3 = $row2["cota3"];
			$cota4 = $row2["cota4"];
			$cota6 = $row2["cota5"];
			$cota7 = $row2["cota7"];
			$cota8 = $row2["cota8"];
			$cota9 = $row2["cota9"];
			$cota10 = $row2["cota10"];
			$cota11 = $row2["cota11"];
			$cota12 = $row2["cota12"];
			$cota13 = $row2["cota13"];
			$cota14 = $row2["cota14"];
			$cota15 = $row2["cota15"];
			
			$echipa1 = $row2["echipa1"];
			$echipa2 = $row2["echipa2"];
			$echipa3 = $row2["echipa3"];
			$echipa4 = $row2["echipa4"];
			$echipa6 = $row2["echipa5"];
			$echipa7 = $row2["echipa7"];
			$echipa8 = $row2["echipa8"];
			$echipa9 = $row2["echipa9"];
			$echipa10 = $row2["echipa10"];
			$echipa11 = $row2["echipa11"];
			$echipa12 = $row2["echipa12"];
			$echipa13 = $row2["echipa13"];
			$echipa14 = $row2["echipa14"];
			$echipa15 = $row2["echipa15"];
			
			$cota_totala = $row2["cota_totala"];
			$plata = $row2["plata"];
			$castig = $row2["castig"];
			$nr_bilet = $row2["nr_bilet"];
		}
		?>
<table>
	<thead>
	<tr>
		<th>Meci</th>
		<th>Castiga</th>
		<th>Cota</th>
		<th>Stare</th>
	</tr>
	</thead>
	<tbody>
<?php if ($id_meci1 !== "")
{
		?>
	<tr>
<td><?php echo $results1["clan1"]; ?> vs <?php echo $results1["clan2"]; ?></td>
<td><?php if ($echipa1 == "1") echo $results1["clan1"]; else echo $results1["clan2"]; ?></td>
<td><?php echo $cota1; ?></td>
<td><?php if ($echipa1 == $results1["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results1["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?> </td>
	</tr>
<?php
}
?>
<?php if ($id_meci2 !== "")
{
		?>
	<tr>
<td><?php echo $results2["clan1"]; ?> vs <?php echo $results2["clan2"]; ?></td>
<td><?php if ($echipa2 == "1") echo $results2["clan1"]; else echo $results2["clan2"]; ?></td>
<td><?php echo $cota2; ?></td>
<td><?php if ($echipa2 == $results2["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results2["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci3 !== "")
{
		?>
	<tr>
<td><?php echo $results3["clan1"]; ?> vs <?php echo $results3["clan2"]; ?></td>
<td><?php if ($echipa3 == "1") echo $results3["clan1"]; else echo $results3["clan2"]; ?></td>
<td><?php echo $cota3; ?></td>
<td><?php if ($echipa3 == $results3["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results3["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci4 !== "")
{
		?>
	<tr>
<td><?php echo $results4["clan1"]; ?> vs <?php echo $results4["clan2"]; ?></td>
<td><?php if ($echipa4 == "1") echo $results4["clan1"]; else echo $results4["clan2"]; ?></td>
<td><?php echo $cota4; ?></td>
<td><?php if ($echipa4 == $results4["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results4["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci5 !== "")
{
		?>
	<tr>
<td><?php echo $results5["clan1"]; ?> vs <?php echo $results5["clan2"]; ?></td>
<td><?php if ($echipa5 == "1") echo $results5["clan1"]; else echo $results5["clan2"]; ?></td>
<td><?php echo $cota5; ?></td>
<td><?php if ($echipa5 == $results5["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results5["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci6 !== "")
{
		?>
	<tr>
<td><?php echo $results6["clan1"]; ?> vs <?php echo $results6["clan2"]; ?></td>
<td><?php if ($echipa6 == "1") echo $results6["clan1"]; else echo $results6["clan2"]; ?></td>
<td><?php echo $cota6; ?></td>
<td><?php if ($echipa6 == $results6["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results6["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci7 !== "")
{
		?>
	<tr>
<td><?php echo $results7["clan1"]; ?> vs <?php echo $results7["clan2"]; ?></td>
<td><?php if ($echipa7 == "1") echo $results7["clan1"]; else echo $results7["clan2"]; ?></td>
<td><?php echo $cota7; ?></td>
<td><?php if ($echipa7 == $results7["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results7["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci8 !== "")
{
		?>
	<tr>
<td><?php echo $results8["clan1"]; ?> vs <?php echo $results8["clan2"]; ?></td>
<td><?php if ($echipa8 == "1") echo $results8["clan1"]; else echo $results8["clan2"]; ?></td>
<td><?php echo $cota8; ?></td>
<td><?php if ($echipa8 == $results8["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results8["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci9 !== "")
{
		?>
	<tr>
<td><?php echo $results9["clan1"]; ?> vs <?php echo $results9["clan2"]; ?></td>
<td><?php if ($echipa9 == "1") echo $results9["clan1"]; else echo $results9["clan2"]; ?></td>
<td><?php echo $cota9; ?></td>
<td><?php if ($echipa9 == $results9["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results9["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci10 !== "")
{
		?>
	<tr>
<td><?php echo $results10["clan1"]; ?> vs <?php echo $results10["clan2"]; ?></td>
<td><?php if ($echipa10 == "1") echo $results10["clan1"]; else echo $results10["clan2"]; ?></td>
<td><?php echo $cota10; ?></td>
<td><?php if ($echipa10 == $results10["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results10["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci11 !== "")
{
		?>
	<tr>
<td><?php echo $results11["clan1"]; ?> vs <?php echo $results11["clan2"]; ?></td>
<td><?php if ($echipa11 == "1") echo $results11["clan1"]; else echo $results11["clan2"]; ?></td>
<td><?php echo $cota11; ?></td>
<td><?php if ($echipa11 == $results11["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results11["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci12 !== "")
{
		?>
	<tr>
<td><?php echo $results12["clan1"]; ?> vs <?php echo $results12["clan2"]; ?></td>
<td><?php if ($echipa12 == "1") echo $results12["clan1"]; else echo $results12["clan2"]; ?></td>
<td><?php echo $cota12; ?></td>
<td><?php if ($echipa12 == $results12["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results12["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci13 !== "")
{
		?>
	<tr>
<td><?php echo $results13["clan1"]; ?> vs <?php echo $results13["clan2"]; ?></td>
<td><?php if ($echipa13 == "1") echo $results13["clan1"]; else echo $results13["clan2"]; ?></td>
<td><?php echo $cota13; ?></td>
<td><?php if ($echipa13 == $results13["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results13["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}
?>
<?php if ($id_meci14 !== "")
{
		?>
	<tr>
<td><?php echo $results14["clan1"]; ?> vs <?php echo $results14["clan2"]; ?></td>
<td><?php if ($echipa14 == "1") echo $results14["clan1"]; else echo $results14["clan2"]; ?></td>
<td><?php echo $cota14; ?></td>
<td><?php if ($echipa14 == $results14["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results14["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
<td></td>
	</tr>
<?php
}
?>
<?php if ($id_meci15 !== "")
{
		?>
	<tr>
<td><?php echo $results15["clan1"]; ?> vs <?php echo $results15["clan2"]; ?></td>
<td><?php if ($echipa15 == "1") echo $results15["clan1"]; else echo $results15["clan2"]; ?></td>
<td><?php echo $cota15; ?></td>
<td><?php if ($echipa15 == $results15["echipa_castigatoare"]) { echo 'Castigat'; $stare = "castigat"; } else if ($results15["echipa_castigatoare"] == "") { echo 'Nejucat'; $stare3 = "nujucat"; } else { echo 'Pierdut'; $stare2 = "pierdut"; } ?></td>
	</tr>
<?php
}

?>
	</tbody>
  </table>
  <h3>Pret bilet: <?php echo $plata; ?> Euro (actitat)</h3>
  <h3>Castig: <?php echo $castig; ?> Euro</h3>
  <h3>Stare bilet: <?php if ($stare3 == "nujucat") { echo 'Nu s-au jucat toate meciurile';} else if ($stare2 == "pierdut") echo "Bilet Necastigator"; else if ($stare == "castigat") { echo "Bilet Castigator"; ?> <form name="paruiri33" method="post" action="extrage_succes.php"> <input type="hidden" name="nrbilet2" value="<?php echo $nr_bilet; ?>" /> <input type="hidden" name="user" value="<?php echo $user; ?>" /> <input type="hidden" name="pass" value="<?php echo $pass; ?>" /> <input type="hidden" name="castig" value="<?php echo $castig; ?>" /> <input type="submit" name="extrage" value="Extrage Banii" class="buton_albastru" />  </form>  <?php } ?></h3>
  <h3>Nr. Bilet: <?php echo $nr_bilet; ?></h3>



		<?php
		} else {
		?>
		
		<div class="error"> Biletul nu a fost gasit, te rog verifica din nou numarul biletului.</div>
		<?php
		}
		?>
</body>
</html>
<?php } ?>