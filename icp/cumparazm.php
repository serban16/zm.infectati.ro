<?php

define('INCLUDE_CHECK',true);

require 'connect.php';
require 'functions.php';
require 'header.php';
// Those two files can be included only if INCLUDE_CHECK is defined

?>
<html>

<head>
    <link rel="stylesheet" type="text/css" href="login_panel/css/tabel_cuparari.css"/>
</head>

<body>
<div class="pageContent">
    <div id="main">
      <div class="container">
        <h1>Cumpara Grad pe Zm.infectati.ro</h1>
        <h2>Infect Control Panel</h2>
        </div>
		
		<?php require 'meniu.php'; 
			$commanda="SELECT * FROM preturi WHERE nume_produs = 'zm_slot'";
			$resultsa = mysql_query($commanda);
			while($rowa = mysql_fetch_array($resultsa))
			{
				$pret = $rowa["pret"];
			}
			$commanda2="SELECT * FROM preturi WHERE nume_produs = 'zm_mini_admin'";
			$resultsa2 = mysql_query($commanda2);
			while($rowa2 = mysql_fetch_array($resultsa2))
			{
				$pret2 = $rowa2["pret"];
			}
			$commanda3="SELECT * FROM preturi WHERE nume_produs = 'zm_co_administrator'";
			$resultsa3 = mysql_query($commanda3);
			while($rowa3 = mysql_fetch_array($resultsa3))
			{
				$pret3 = $rowa3["pret"];
			}
			$commanda4="SELECT * FROM preturi WHERE nume_produs = 'zm_administrator'";
			$resultsa4 = mysql_query($commanda4);
			while($rowa4 = mysql_fetch_array($resultsa4))
			{
				$pret4 = $rowa4["pret"];
			}
			$commanda5="SELECT * FROM preturi WHERE nume_produs = 'zm_owner'";
			$resultsa5 = mysql_query($commanda5);
			while($rowa5 = mysql_fetch_array($resultsa5))
			{
				$pret5 = $rowa5["pret"];
			}
			$commanda6="SELECT * FROM preturi WHERE nume_produs = 'zm_vip'";
			$resultsa6 = mysql_query($commanda6);
			while($rowa6 = mysql_fetch_array($resultsa6))
			{
				$pret6 = $rowa6["pret"];
			}
			$commanda7="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1000'";
			$resultsa7 = mysql_query($commanda7);
			while($rowa7 = mysql_fetch_array($resultsa7))
			{
				$pret7 = $rowa7["pret"];
			}
			$commanda8="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_1500'";
			$resultsa8 = mysql_query($commanda8);
			while($rowa8 = mysql_fetch_array($resultsa8))
			{
				$pret8 = $rowa8["pret"];
			}
			$commanda9="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2000'";
			$resultsa9 = mysql_query($commanda9);
			while($rowa9 = mysql_fetch_array($resultsa9))
			{
				$pret9 = $rowa9["pret"];
			}
			$commanda10="SELECT * FROM preturi WHERE nume_produs = 'zm_banca_2500'";
			$resultsa10 = mysql_query($commanda10);
			while($rowa10 = mysql_fetch_array($resultsa10))
			{
				$pret10 = $rowa10["pret"];
			}
		?>
        
        <div class="container">
        
    <table cellspacing="0">
    <tr><th>Nume Grad</th><th>Pret/Luna</th><th>Cumpara</th></tr>
    <tr><td>VIP</a></td><td><?php echo $pret6; ?> Euro</td><td><a href="cumpara_zm_vip.php">Cumpara</a></td></tr>
    <tr><td>Slot</td><td><?php echo $pret; ?> Euro</td><td><a href="cumpara_zm_slot.php">Cumpara</a></td></tr>
	<tr><td>Mini-Admin</td><td><?php echo $pret2; ?> Euro</td><td><a href="cumpara_zm_mini_admin.php">Cumpara</a></td></tr>
    <tr><td>Co-Administrator</td><td><?php echo $pret3; ?> Euro</td><td><a href="cumpara_zm_co_administrator.php">Cumpara</a></td></tr>
    <tr><td>Administrator</td><td><?php echo $pret4; ?> Euro</td><td><a href="cumpara_zm_administrator.php">Cumpara</a></td></tr>
    <tr><td>Owner</td><td><?php echo $pret5; ?> Euro</td><td><a href="cumpara_zm_owner.php">Cumpara</a></td></tr>
	<tr><td>Marire banca la 1000 Euro</td><td><?php echo $pret7; ?> Euro</td><td><a href="cumpara_zm_banca_1000.php">Cumpara</a></td></tr>
	<tr><td>Marire banca la 1500 Euro</td><td><?php echo $pret8; ?> Euro</td><td><a href="cumpara_zm_banca_1500.php">Cumpara</a></td></tr>
	<tr><td>Marire banca la 2000 Euro</td><td><?php echo $pret9; ?> Euro</td><td><a href="cumpara_zm_banca_2000.php">Cumpara</a></td></tr>
	<tr><td>Marire banca la 2500 Euro</td><td><?php echo $pret10; ?> Euro</td><td><a href="cumpara_zm_banca_2500.php">Cumpara</a></td></tr>
    </table>
	<br>
	<h4><font color="#d10000">ATENTIE:</font> Abuzul se pedepseste cu stergerea gradului fara inapoierea banilor.</h4><br><br>

		  <div class="clear"></div>
        
		</div>
        
	<?php
	require 'foother.php';
	?>	
    </div>
</div>

</body>
</html>