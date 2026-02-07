<?php
session_start();
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
	
		$bla2 = mysql_query("SELECT * FROM tz_members WHERE auth= '$user' AND password= '$pass'");
		$absolut2 = mysql_fetch_assoc($bla2);

		$auth = $absolut2['auth'];
		$balanta = $absolut2["balanta"];
		$admin = $absolut2['admin'];
			
			
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
		
    //current URL of the Page. cart_update.php redirects back to this URL
	$current_url = base64_encode($url="http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
		
	if($_POST['rahat']=='cumpara')
	{
	
		if ($balanta >= $_POST['plata'])
		{
		$balanta = $balanta - $_POST['plata'];
		
				mysql_query("	UPDATE tz_members
						SET				
							balanta = '$balanta'
						WHERE auth= '$user' AND password= '$pass'");
						
		$numar = rand(1000000,9999999);
		mysql_query("	INSERT INTO bilete(cota_totala,plata,castig,nr_bilet)
						VALUES(
							'".$_POST['total']."',
							'".$_POST['plata']."',
							'".$_POST['total2']."',
							'$numar'	
						)");
		
		mysql_query("INSERT INTO log(comanda,admin,data) VALUES ('$auth a cumparat biletul cu nr.: $numar si a platit $plata','$admin',NOW())");
			
			
		foreach ($_SESSION["products"] as $cart_itm2)
		{
			
		$exact = mysql_fetch_assoc(mysql_query("SELECT * FROM bilete WHERE nr_bilet = '$numar'"));
		
			if ($cart_itm2["id"] == "1")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci1 = '".$cart_itm2["id"]."',
							cota1 = '".$cart_itm2["cota"]."',
							echipa1 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "2")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci2 = '".$cart_itm2["id"]."',
							cota2 = '".$cart_itm2["cota"]."',
							echipa2 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "3")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci3 = '".$cart_itm2["id"]."',
							cota3 = '".$cart_itm2["cota"]."',
							echipa3 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "4")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci4 = '".$cart_itm2["id"]."',
							cota4 = '".$cart_itm2["cota"]."',
							echipa4 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "5")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci5 = '".$cart_itm2["id"]."',
							cota5 = '".$cart_itm2["cota"]."',
							echipa5 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "6")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci6 = '".$cart_itm2["id"]."',
							cota6 = '".$cart_itm2["cota"]."',
							echipa6 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "7")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci7 = '".$cart_itm2["id"]."',
							cota7 = '".$cart_itm2["cota"]."',
							echipa7 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "8")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci8 = '".$cart_itm2["id"]."',
							cota8 = '".$cart_itm2["cota"]."',
							echipa8 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "9")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci9 = '".$cart_itm2["id"]."',
							cota9 = '".$cart_itm2["cota"]."',
							echipa9 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "10")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci10 = '".$cart_itm2["id"]."',
							cota10 = '".$cart_itm2["cota"]."',
							echipa10 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "11")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci11 = '".$cart_itm2["id"]."',
							cota11 = '".$cart_itm2["cota"]."',
							echipa11 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "12")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci12 = '".$cart_itm2["id"]."',
							cota12 = '".$cart_itm2["cota"]."',
							echipa12 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "13")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci13 = '".$cart_itm2["id"]."',
							cota13 = '".$cart_itm2["cota"]."',
							echipa13 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "14")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci14 = '".$cart_itm2["id"]."',
							cota14 = '".$cart_itm2["cota"]."',
							echipa14 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
			if ($cart_itm2["id"] == "15")
			{
				mysql_query("	UPDATE bilete
						SET				
							id_meci15 = '".$cart_itm2["id"]."',
							cota15 = '".$cart_itm2["cota"]."',
							echipa15 = '".$cart_itm2["echipa"]."'
						WHERE nr_bilet = '$numar'");
			}
		
		}

		header("Location: bilet_succes.php?nr=".$numar);
		
		}
		else
			header("Location: bilet_insuficient.php");
	}
		?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style/style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="style/tabel_meciuri.css"/>
<link rel="stylesheet" type="text/css" href="style/slide.css"/> 
</head>
<div id="products-wrapper">
    <div class="products">
<body>
<table>
	<thead>
	<tr>
		<th>Clanuri</th>
		<th>1</th>
		<th>2</th>
		<th>Data</th>
		<th>Echipa castigatoare</th>
	</tr>
	</thead>
	<tbody>
<?php
if ($results1["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results1["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results1["clan2"]; ?></td>
		<?php if ($results1["dezactivat"] == "da") { ?>
		<td><?php echo $results1["cota1"]; ?></td>
		<td><?php echo $results1["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results1["cota1"]; ?></button><input type="hidden" name="id" value="1" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results1["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results1["cota2"]; ?></button><input type="hidden" name="id" value="1" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results1["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results1["data"]; ?></td>
		<td><?php if ($results1["echipa_castigatoare"] == "1") echo $results1["clan1"]; else if ($results1["echipa_castigatoare"] == "2") echo $results1["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>
<?php
if ($results2["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results2["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results2["clan2"]; ?></td>
		<?php if ($results2["dezactivat"] == "da") { ?>
		<td><?php echo $results2["cota1"]; ?></td>
		<td><?php echo $results2["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results2["cota1"]; ?></button><input type="hidden" name="id" value="2" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results2["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results2["cota2"]; ?></button><input type="hidden" name="id" value="2" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results2["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results2["data"]; ?></td>
		<td><?php if ($results2["echipa_castigatoare"] == "1") echo $results2["clan1"]; else if ($results2["echipa_castigatoare"] == "2") echo $results2["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results3["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results3["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results3["clan2"]; ?></td>
		<?php if ($results3["dezactivat"] == "da") { ?>
		<td><?php echo $results3["cota1"]; ?></td>
		<td><?php echo $results3["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results3["cota1"]; ?></button><input type="hidden" name="id" value="3" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results3["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results3["cota2"]; ?></button><input type="hidden" name="id" value="3" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results3["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results3["data"]; ?></td>
		<td><?php if ($results3["echipa_castigatoare"] == "1") echo $results3["clan1"]; else if ($results3["echipa_castigatoare"] == "2") echo $results3["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results4["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results4["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results4["clan2"]; ?></td>
		<?php if ($results4["dezactivat"] == "da") { ?>
		<td><?php echo $results4["cota1"]; ?></td>
		<td><?php echo $results4["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results4["cota1"]; ?></button><input type="hidden" name="id" value="4" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results4["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results4["cota2"]; ?></button><input type="hidden" name="id" value="4" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results4["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results4["data"]; ?></td>
		<td><?php if ($results4["echipa_castigatoare"] == "1") echo $results4["clan1"]; else if ($results4["echipa_castigatoare"] == "2") echo $results4["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results5["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results5["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results5["clan2"]; ?></td>
		<?php if ($results5["dezactivat"] == "da") { ?>
		<td><?php echo $results5["cota1"]; ?></td>
		<td><?php echo $results5["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results5["cota1"]; ?></button><input type="hidden" name="id" value="5" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results5["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results5["cota2"]; ?></button><input type="hidden" name="id" value="5" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results5["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results5["data"]; ?></td>
		<td><?php if ($results5["echipa_castigatoare"] == "1") echo $results5["clan1"]; else if ($results5["echipa_castigatoare"] == "2") echo $results5["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results6["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results6["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results6["clan2"]; ?></td>
		<?php if ($results6["dezactivat"] == "da") { ?>
		<td><?php echo $results6["cota1"]; ?></td>
		<td><?php echo $results6["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results6["cota1"]; ?></button><input type="hidden" name="id" value="6" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results6["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results6["cota2"]; ?></button><input type="hidden" name="id" value="6" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results6["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results6["data"]; ?></td>
		<td><?php if ($results6["echipa_castigatoare"] == "1") echo $results6["clan1"]; else if ($results6["echipa_castigatoare"] == "2") echo $results6["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results7["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results7["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results7["clan2"]; ?></td>
		<?php if ($results7["dezactivat"] == "da") { ?>
		<td><?php echo $results7["cota1"]; ?></td>
		<td><?php echo $results7["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results7["cota1"]; ?></button><input type="hidden" name="id" value="7" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results7["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results7["cota2"]; ?></button><input type="hidden" name="id" value="7" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results7["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results7["data"]; ?></td>
		<td><?php if ($results7["echipa_castigatoare"] == "1") echo $results7["clan1"]; else if ($results7["echipa_castigatoare"] == "2") echo $results7["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results8["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results8["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results8["clan2"]; ?></td>
		<?php if ($results8["dezactivat"] == "da") { ?>
		<td><?php echo $results8["cota1"]; ?></td>
		<td><?php echo $results8["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results8["cota1"]; ?></button><input type="hidden" name="id" value="8" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results8["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results8["cota2"]; ?></button><input type="hidden" name="id" value="8" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results8["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results8["data"]; ?></td>
		<td><?php if ($results8["echipa_castigatoare"] == "1") echo $results8["clan1"]; else if ($results8["echipa_castigatoare"] == "2") echo $results8["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results9["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results9["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results9["clan2"]; ?></td>
		<?php if ($results9["dezactivat"] == "da") { ?>
		<td><?php echo $results9["cota1"]; ?></td>
		<td><?php echo $results9["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results9["cota1"]; ?></button><input type="hidden" name="id" value="9" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results9["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results9["cota2"]; ?></button><input type="hidden" name="id" value="9" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results9["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results9["data"]; ?></td>
		<td><?php if ($results9["echipa_castigatoare"] == "1") echo $results9["clan1"]; else if ($results9["echipa_castigatoare"] == "2") echo $results9["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results10["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results10["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results10["clan2"]; ?></td>
		<?php if ($results10["dezactivat"] == "da") { ?>
		<td><?php echo $results10["cota1"]; ?></td>
		<td><?php echo $results10["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results10["cota1"]; ?></button><input type="hidden" name="id" value="10" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results10["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results10["cota2"]; ?></button><input type="hidden" name="id" value="10" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results10["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results10["data"]; ?></td>
		<td><?php if ($results10["echipa_castigatoare"] == "1") echo $results10["clan1"]; else if ($results10["echipa_castigatoare"] == "2") echo $results10["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results11["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results11["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results11["clan2"]; ?></td>
		<?php if ($results11["dezactivat"] == "da") { ?>
		<td><?php echo $results11["cota1"]; ?></td>
		<td><?php echo $results11["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results11["cota1"]; ?></button><input type="hidden" name="id" value="11" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results11["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results11["cota2"]; ?></button><input type="hidden" name="id" value="11" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results11["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results11["data"]; ?></td>
		<td><?php if ($results11["echipa_castigatoare"] == "1") echo $results11["clan1"]; else if ($results11["echipa_castigatoare"] == "2") echo $results11["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results12["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results12["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results12["clan2"]; ?></td>
		<?php if ($results12["dezactivat"] == "da") { ?>
		<td><?php echo $results12["cota1"]; ?></td>
		<td><?php echo $results12["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results12["cota1"]; ?></button><input type="hidden" name="id" value="12" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results12["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results12["cota2"]; ?></button><input type="hidden" name="id" value="12" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results12["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results12["data"]; ?></td>
		<td><?php if ($results12["echipa_castigatoare"] == "1") echo $results12["clan1"]; else if ($results12["echipa_castigatoare"] == "2") echo $results12["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results13["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results13["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results13["clan2"]; ?></td>
		<?php if ($results13["dezactivat"] == "da") { ?>
		<td><?php echo $results13["cota1"]; ?></td>
		<td><?php echo $results13["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results13["cota1"]; ?></button><input type="hidden" name="id" value="13" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results13["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results13["cota2"]; ?></button><input type="hidden" name="id" value="13" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results13["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results13["data"]; ?></td>
		<td><?php if ($results13["echipa_castigatoare"] == "1") echo $results13["clan1"]; else if ($results13["echipa_castigatoare"] == "2") echo $results13["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results14["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results14["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results14["clan2"]; ?></td>
		<?php if ($results14["dezactivat"] == "da") { ?>
		<td><?php echo $results14["cota1"]; ?></td>
		<td><?php echo $results14["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results14["cota1"]; ?></button><input type="hidden" name="id" value="14" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results14["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results14["cota2"]; ?></button><input type="hidden" name="id" value="14" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results14["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results14["data"]; ?></td>
		<td><?php if ($results14["echipa_castigatoare"] == "1") echo $results14["clan1"]; else if ($results14["echipa_castigatoare"] == "2") echo $results14["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

<?php
if ($results15["clan1"] !== "-1")
{
?>
	<form method="post" action="cart_update.php">
	<tr>
		<td><?php echo $results15["clan1"]; ?> <font color="#d10000">vs</font> <?php echo $results15["clan2"]; ?></td>
		<?php if ($results15["dezactivat"] == "da") { ?>
		<td><?php echo $results15["cota1"]; ?></td>
		<td><?php echo $results15["cota2"]; ?></td>
		<?php } else { ?>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results15["cota1"]; ?></button><input type="hidden" name="id" value="15" /> <input type="hidden" name="echipa" value="1" /> <input type="hidden" name="cota" value="<?php echo $results15["cota1"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<td><form method="post" action="cart_update.php"><button class="add_to_cart"><?php echo $results15["cota2"]; ?></button><input type="hidden" name="id" value="15" /> <input type="hidden" name="echipa" value="2" /> <input type="hidden" name="cota" value="<?php echo $results15["cota2"]; ?>" /> <input type="hidden" name="type" value="add" /> <input type="hidden" name="return_url" value="<?php echo $current_url; ?>" /> </form></td>
		<?php } ?>
		<td><?php echo $results15["data"]; ?></td>
		<td><?php if ($results15["echipa_castigatoare"] == "1") echo $results15["clan1"]; else if ($results15["echipa_castigatoare"] == "2") echo $results15["clan2"]; else echo 'Meciul inca nu s-a jucat'; ?></td>
	</tr>
		</form>
<?php
}
?>

	</tbody>
</table>
    </div>
    
<div class="shopping-cart">
<h2>Biletul tau</h2>
<?php
if(isset($_SESSION["products"]))
{
    $total = 0;
    echo '<ol>';
    foreach ($_SESSION["products"] as $cart_itm)
    {
        echo '<li class="cart-itm">';
        echo '<span class="remove-itm"><a href="cart_update.php?removep='.$cart_itm["id"].'&return_url='.$current_url.'">&times;</a></span>';
        echo '<div class="p-code"><strong>Meci :</strong> '.$cart_itm["clan1"]. ' vs ' .$cart_itm["clan2"].'</div>';
        echo '<div class="p-qty"><strong>Echipa castigatoare :</strong> '.$cart_itm["echipa"].'</div>';
        echo '<div class="p-price"><strong>Cota : </strong>';  echo $cart_itm["cota"];  echo '</div>';
        echo '</li>';
		
		$total = ($total + $cart_itm["cota"]);
    }
    echo '</ol>';
	
	echo '<form name="paruiri" action="" method="post">';

	echo '<span class="check-out-txt"><strong>Cota Totala : '.$total.'</strong><br>';
	if (!$_POST['banii_mei'])
	{
		$total2 = ($total * "0.50");
		$plata = "0.50"; 
	}
	else
	{
		$total2 = ($total * $_POST['banii_mei']);
		$plata = $_POST['banii_mei'];
	}
	?>
				<h3>Pariezi: <select name="banii_mei" onchange="this.form.submit();">
				<option <?php if ($_POST['banii_mei'] == "0.50") { ?> selected <?php } ?> value="0.50">0.50 Euro</option>
				<option <?php if ($_POST['banii_mei'] == "1") { ?> selected <?php } ?> value="1">1 Euro</option>
				<option <?php if ($_POST['banii_mei'] == "2") { ?> selected <?php } ?> value="2">2 Euro</option>
				<option <?php if ($_POST['banii_mei'] == "3") { ?> selected <?php } ?> value="3">3 Euro</option>
				<option <?php if ($_POST['banii_mei'] == "4") { ?> selected <?php } ?> value="4">4 Euro</option>
				<option <?php if ($_POST['banii_mei'] == "5") { ?> selected <?php } ?> value="5">5 Euro</option>
				<option <?php if ($_POST['banii_mei'] == "10") { ?> selected <?php } ?> value="10">10 Euro</option>
			</select></h3><br>
	<?php
	echo '<span class="check-out-txt"><strong>Castig : '.$total2.' Euro</strong><br>';

	echo '<input type="hidden" name="total" value="'.$total.'" />';
	echo '<input type="hidden" name="total2" value="'.$total2.'" />';
	echo '<input type="hidden" name="plata" value="'.$plata.'" />';
	echo '<input type="submit" name="rahat" value="cumpara" class="buton_albastru" />';
	echo '</form>';
	

}else{
    echo 'Nu ai selectat nici un meci.';
}
?>
</div>
    
</div>
<br>
<br>
<br>
<br>
<br>
<h3>Verifica bilet:</h3>
		<form name="form1" method="post" action="verificare.php?user=<?php echo $user; ?>&pass=<?php echo $pass; ?>">
			<h3>Nr. Bilet: <input type="text" name="biletnr" />
			<input type="submit" name="submit" value="Verifica" class="buton_albastru" /></h3>
		</form>

</body>
</html>
<?php
}
?>