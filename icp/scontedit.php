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
			$idd = $row2["id"];
			$balanta16 = $row2["balanta"];
			$email = $row2["email"];
			$nume = $row2["nume"];
			$oras = $row2["oras"];
			$adresa = $row2["judet"];
			$telefon = $row2["telefon"];
			$parola = $row2["password"];
			$ips = $row2["regIP"];
			$ips2 = $row2["ip_ultimul"];
			$ips3 = $row2["ip_ultimul2"];
			$ips4 = $row2["ip_ultimul3"];
			$ips5 = $row2["ip_ultimul4"];
			$ips6 = $row2["ip_ultimul5"];
			
			$expira_vip_zm = $row2["zm_expira_vip"];
			$expira_admin_zm = $row2["zm_expira_access"];
			$expira_banca_zm = $row2["zm_expira_banca"];
			
			$access_cs = $row2["access_cs"];
			$expira_admin_cs = $row2["cs_expira_access"];
			
			$zm_access = $row2["access_zm"];
			$zm_access_vip = $row2["access_zm_vip"];
			$zm_access_banca = $row2["access_zm_bank"];
			
			$ban_icp = $row2["bantime"];
		}
		
		$cauta_sql2 = "SELECT * FROM zp_bank WHERE auth LIKE '".$_POST['casuta']."'";
		$cauta_query2 = mysql_query($cauta_sql2);
		while($row26 = mysql_fetch_array($cauta_query2))
		{
			$cantitate = $row26["cantitate"];
		}		$expira_admin_zm = date('d-m-Y',strtotime($expira_admin_zm));		$expira_vip_zm = date('d-m-Y',strtotime($expira_vip_zm));		$expira_banca_zm = date('d-m-Y',strtotime($expira_banca_zm));				$expira_admin_cs = date('d-m-Y',strtotime($expira_admin_cs));		if ($ban_icp == "0000-00-00")			$ban_icp = "00-00-0000";		else			$ban_icp = date('d-m-Y',strtotime($ban_icp));

		?>
		
		<h1>Editeza Utilizator</h1><br>
		
		<form name="form2" method="post"  action="sconteditfinal.php">
		<input type="text" name="casuta555" value="<?php echo $idd; ?>" style="display: none" />
			<h3>Nume de Utilizator:  <input type="text" name="auth" value="<?php echo $rezultat; ?>"><br></h3><br>
			<h3>Balanta Credit:  <input type="text" name="balanta" value="<?php echo $balanta16; ?>"> Euro<br></h3><br>
			<h3>Email:  <input type="text" name="email" value="<?php echo $email; ?>"><br></h3>
			
			<h3>Parola: <input type="password" name="password" value="<?php echo $parola; ?>"><br></h3>
			<h3>Rescrie Parola: <input type="password" name="password2" value=""><br></h3>
			<br>
			<h3>Inregistrat cu Adresa IP: <font color="#d10000"><?php echo $ips; ?></font><br></h3>
			<h3>Ultima autentificare cu Adresa IP: <font color="#d10000"><?php echo $ips2; ?></font><?php if ($ips3 !== "") { ?><br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color="#d10000"><?php echo $ips3; } ?></font><?php if ($ips4 !== "") { ?><br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color="#d10000"><?php echo $ips4; } ?></font><?php if ($ips5 !== "") { ?><br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color="#d10000"><?php echo $ips5; } ?></font><?php if ($ips6 !== "") { ?><br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<font color="#d10000"><?php echo $ips6; } ?></font><br></h3>
			<br>
			
			<h3>Nume si Prenume:  <input type="text" name="nume" value="<?php echo $nume; ?>"><br></h3>
			<h3>Oras:  <input type="text" name="oras" value="<?php echo $oras; ?>"><br></h3>
			<h3>Judet:  <input type="text" name="adresa" value="<?php echo $adresa; ?>"><br></h3>
			<h3>Telefon:  <input class="field" type="text" name="telefon" id="telefon" value="<?php echo $telefon; ?>"><br></h3>
			<br><h3>Zm.infectati.ro:</h3>
			<br><h3>Grad admin:<select name="admin_zm">
				<option <?php if (($zm_access == "z") or ($zm_access == "x")) { ?> selected <?php } ?> value="nume_rezervat_zm">Nume Rezervat</option>
				<option <?php if (($zm_access == "b") or ($zm_access == "bx")) { ?> selected <?php } ?> value="slot_zm">Slot</option>
				<option <?php if (($zm_access == "cefij") or ($zm_access == "cefijx")) { ?> selected <?php } ?> value="mini_zm">Mini-Admin</option>
				<option <?php if (($zm_access == "cdefijm") or ($zm_access == "cdefijmx")) { ?> selected <?php } ?> value="co_administrator_zm">Co-Administrator</option>
				<option <?php if (($zm_access == "cdefgijmn") or ($zm_access == "cdefgijmnx")) { ?> selected <?php } ?> value="administrator_zm">Administrator</option>
				<option <?php if (($zm_access == "abcdefghijklmnopqrstu") or ($zm_access == "abcdefghijklmnopqrstux")) { ?> selected <?php } ?> value="owner_zm">Owner</option>
			</select></h3>
			<h3>Grad VIP:<select name="vip">
				<option <?php if ($zm_access_vip == "abcde") { ?> selected <?php } ?> value="vip_da">Da</option>
				<option <?php if ($zm_access_vip <> "abcde") { ?> selected <?php } ?> value="vip_nu">Nu</option>
			</select></h3>
				<h3>Grad banca:<select name="banca">
				<option <?php if ($zm_access_banca == "") { ?> selected <?php } ?> value="banca_500">Banca 500 Euro</option>
				<option <?php if ($zm_access_banca == "a") { ?> selected <?php } ?> value="banca_1000">Banca 1000 Euro</option>
				<option <?php if ($zm_access_banca == "ab") { ?> selected <?php } ?> value="banca_1500">Banca 1500 Euro</option>
				<option <?php if ($zm_access_banca == "abc") { ?> selected <?php } ?> value="banca_2000">Banca 2000 Euro</option>
				<option <?php if ($zm_access_banca == "abcd") { ?> selected <?php } ?> value="banca_2500">Banca 2500 Euro</option>
				<option <?php if ($zm_access_banca == "abcde") { ?> selected <?php } ?> value="banca_2501">Banca 2500 Euro + give/remove</option>
			</select></h3>
			<h3>Cont Bancar:  <input type="text" name="bancar" value="<?php echo $cantitate; ?>"> Euro<br></h3>
			<h3>Data expirarii Adminului:  <input type="text" name="expira_admin_zm" value="<?php echo $expira_admin_zm; ?>"></h3>
			<h3>Data expirarii VIP:  <input type="text" name="expira_vip_zm" value="<?php echo $expira_vip_zm; ?>"></h3>
			<h3>Data exirarii Bancii:  <input type="text" name="expira_banca_zm" value="<?php echo $expira_banca_zm; ?>"></h3>
			
			<br><h3>Cs.infectati.ro:</h3>
			<br><h3>Grad admin:<select name="admin_cs">
				<option <?php if ($access_cs == "z") { ?> selected <?php } ?> value="nume_rezervat_cs">Nume Rezervat</option>
				<option <?php if ($access_cs == "b") { ?> selected <?php } ?> value="slot_cs">Slot</option>
				<option <?php if ($access_cs == "cefij") { ?> selected <?php } ?> value="mini_cs">Mini-Admin</option>
				<option <?php if ($access_cs == "cdefijm") { ?> selected <?php } ?> value="co_administrator_cs">Co-Administrator</option>
				<option <?php if ($access_cs == "cdefgijmn") { ?> selected <?php } ?> value="administrator_cs">Administrator</option>
				<option <?php if ($access_cs == "abcdefghijklmnopqrstu") { ?> selected <?php } ?> value="owner_cs">Owner</option>
			</select></h3>
			<h3>Data expirarii Adminului:  <input type="text" name="expira_admin_cs" value="<?php echo $expira_admin_cs; ?>"><br></h3><br>
			
			<br><h3>Ban ICP:</h3>
			<h3>Baneaza pana la data de :  <input type="text" name="ban_icp" value="<?php echo $ban_icp; ?>"><br></h3>
			<h3>UnBan = 01-01-2000</h3><br>
			
			<h3><font color="#d10000">ATENTIE:</font> Daca doriti sa adaugati un grad sau BANAREA contului Permanent adaugati utilizatorului data scadenta 01-01-3000</h3>
			<h3><font color="#d10000">ATENTIE2:</font> Banarea permanenta a contului ii v-a scoate utilizatorului respectiv toate gradele de pe toate serverele.</h3><br>
						<input type="submit" name="submit2" value="Editeaza" class="buton_albastru" /><br><br>
			<center><h3>Jurnal Personal</h3></center>
			<h3>---------------------------------------------------------------------------------------------------------------------------------------------------------</h3>
		<?php
			$command1611="SELECT * FROM log ORDER BY id DESC";
			$results1611 = mysql_query($command1611);
			while($row1611 = mysql_fetch_array($results1611))
			{
				if (strpos($row1611['comanda'],$rezultat) !== false) {
		?><h3>La data de <?php echo $row1611['data'];?> <font color="#d10000"><?php echo $row1611['comanda'];?></font><?php if (($row1611['admin'] == "da") or ($row1611['admin'] == "avertisment")) { ?> si este Administrator pe ICP <?php } ?><br><br></h3>
		<?php
				}
			}
		?>
			
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
